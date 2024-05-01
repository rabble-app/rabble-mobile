import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rabble/core/config/config.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/config/parser.dart';
import 'package:rabble/core/blocs/global_bloc.dart';
import 'package:rabble/core/dio_retry.dart';
import 'package:rabble/core/pagination.dart';
import 'package:rabble/core/util/errors.dart';
import 'package:rabble/core/widgets/app_error_sheet.dart';
import 'package:rabble/core/widgets/generic_http_error_snackbars.dart';
import 'package:rabble/domain/entities/rabble_enum.dart';


/// If we introduce a new version of the API, we need to make that source a part of this file else we wont be able to access the private base methods listed here;
part 'source.dart';

class RabbleDioOption<String> extends RabbleEnum<String> {
  const RabbleDioOption(String value) : super(value);

  static const SnackbarOnError = RabbleDioOption('snackbarOnError');
  static const AuthorizationOAuth = RabbleDioOption('oAuth');
}

abstract class BaseSource {
  static _parseAndDecode(String responseBody) {
    return json.decode(responseBody);
  }

  static parseJson(String responseBody) {
    return compute(_parseAndDecode, responseBody);
  }

  final Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  //Can add this transformer to the dio instance to make it work with the isolate transformer
  // ..transformer = DefaultTransformer(jsonDecodeCallback: parseJson);

  final String apiUrl;
  final String methodName;
  final Parser parser;

  final ignoreResponseStatusCodes = [304];

  /// Whether to include oauth token in every request
  final bool useAuthentication = true;

  BaseSource({
    required this.apiUrl,
    required this.methodName,
    required this.parser,
  }) {
    _setupInterceptors();
  }

  Options makeOptions(Options options) {
    assert(options.headers == null,
        "We'll need a proper deep copy if you want to set headers");

    return options.copyWith(
      headers: {
        // This allows the server to send gzipped JSON which is a lot smaller
        // Testing shows the trade-off between CPU and bandwidth looks worth it
      },
    );
  }

  //Problem with this is that we need to know the type of the response, so we can parse it accordingly
  //For this case where T is the simple type like Meetup or MeetupWrapper we can do that easily
  //But when T is somethin like APIResponse<T> we need to know the type of T which we cant and then this is the problem
  //so it's better not to parse this in the most inner layer and do it in the outer layer where we know the type
  //TODO: Find a better way to do this

  Future<Response?> _get(
    String url, {
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    VoidCallback? errorCallBack,
  }) async {
    try {
      print("url ${url.toString()}");

      final Response res = await dio.get(
        url,
        cancelToken: cancelToken,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status == 500) {
              bool isAvailble =
                  PostalCodeService().isSheetOpenGlobalSubject.value;
              if (!isAvailble) {
                PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
                CustomBottomSheet.show500BottomModelSheet(
                        NavigatorHelper.navigatorKey.currentContext!,
                        AppErrorSheet(
                          callBackTryAgain: () async {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              _get(url, errorCallBack: errorCallBack);
                            } else {
                              _get(url);
                            }
                          },
                          callBackClose: () {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              errorCallBack.call();
                            }
                          },
                        ),
                        true,
                        isRemove: true)
                    .then((value) {
                  PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
                });
              }
            }
            return status! < 500;
          },
        ),
      );

      print("res ${res.toString()}");
      return res;
    } catch (e) {
      bool isAvailble = PostalCodeService().isSheetOpenGlobalSubject.value;
      if (!isAvailble) {
        PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
        CustomBottomSheet.show500BottomModelSheet(
                NavigatorHelper.navigatorKey.currentContext!,
                AppErrorSheet(
                  callBackTryAgain: () async {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null) {
                      _get(url, errorCallBack: errorCallBack);
                    } else {
                      _get(url);
                    }
                  },
                  callBackClose: () {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null) {
                      errorCallBack.call();
                    }
                  },
                ),
                true,
                isRemove: true)
            .then((value) {
          PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
        });
      }
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _post(String url,
      {Map<String, dynamic>? body,
      FormData? data,
      Map<String, dynamic> dioExtraOptions = const {},
      bool snackbarOnError = false,
      bool throwOnError = true,
      bool retry = false,
      VoidCallback? errorCallBack,
      Function? retryCallBack}) async {
    try {
      Response res = await dio.post(
        url,
        data: data ?? body,
        cancelToken: cancelToken,
        options: dioExtraOptions.containsKey('Authorization')
            ? Options(headers: dioExtraOptions)
            : Options(
                followRedirects: false,
                validateStatus: (status) {
                  if (status == 500) {
                    bool isAvailble =
                        PostalCodeService().isSheetOpenGlobalSubject.value;
                    if (!isAvailble) {
                      PostalCodeService()
                          .isSheetOpenGlobalSubject
                          .sink
                          .add(true);
                      if (errorCallBack != null) {
                        errorCallBack.call();
                      } else {
                        CustomBottomSheet.show500BottomModelSheet(
                                NavigatorHelper.navigatorKey.currentContext!,
                                AppErrorSheet(
                                  callBackTryAgain: () async {
                                    PostalCodeService()
                                        .isSheetOpenGlobalSubject
                                        .sink
                                        .add(false);
                                    if (errorCallBack != null &&
                                        retryCallBack != null) {
                                      _post(url,
                                              body: body,
                                              errorCallBack: errorCallBack,
                                              retryCallBack: retryCallBack)
                                          .then((res) {
                                        if (retryCallBack != null) {
                                          retryCallBack.call(res);
                                        }
                                      });
                                    } else if (retryCallBack != null) {
                                      _post(url,
                                              body: body,
                                              retryCallBack: retryCallBack)
                                          .then((res) {
                                        if (retryCallBack != null) {
                                          retryCallBack.call(res);
                                        }
                                      });
                                    } else if (errorCallBack != null) {
                                      _post(
                                        url,
                                        body: body,
                                        errorCallBack: errorCallBack,
                                      );
                                    } else {
                                      _post(url, body: body);
                                    }
                                  },
                                  callBackClose: () {
                                    PostalCodeService()
                                        .isSheetOpenGlobalSubject
                                        .sink
                                        .add(false);
                                    if (errorCallBack != null) {
                                      errorCallBack.call();
                                    }
                                  },
                                ),
                                true,
                                isRemove: true)
                            .then((value) {
                          PostalCodeService()
                              .isSheetOpenGlobalSubject
                              .sink
                              .add(false);
                        });
                      }
                    } else {
                      if (errorCallBack != null) {
                        errorCallBack.call();
                      } else {
                        CustomBottomSheet.show500BottomModelSheet(
                                NavigatorHelper.navigatorKey.currentContext!,
                                AppErrorSheet(
                                  callBackTryAgain: () async {
                                    PostalCodeService()
                                        .isSheetOpenGlobalSubject
                                        .sink
                                        .add(false);
                                    if (errorCallBack != null &&
                                        retryCallBack != null) {
                                      _post(url,
                                              body: body,
                                              errorCallBack: errorCallBack,
                                              retryCallBack: retryCallBack)
                                          .then((res) {
                                        if (retryCallBack != null) {
                                          retryCallBack.call(res);
                                        }
                                      });
                                    } else if (retryCallBack != null) {
                                      _post(url,
                                              body: body,
                                              retryCallBack: retryCallBack)
                                          .then((res) {
                                        if (retryCallBack != null) {
                                          retryCallBack.call(res);
                                        }
                                      });
                                    } else if (errorCallBack != null) {
                                      _post(
                                        url,
                                        body: body,
                                        errorCallBack: errorCallBack,
                                      );
                                    } else {
                                      _post(url, body: body);
                                    }
                                  },
                                  callBackClose: () {
                                    PostalCodeService()
                                        .isSheetOpenGlobalSubject
                                        .sink
                                        .add(false);
                                    if (errorCallBack != null) {
                                      errorCallBack.call();
                                    }
                                  },
                                ),
                                true,
                                isRemove: true)
                            .then((value) {
                          PostalCodeService()
                              .isSheetOpenGlobalSubject
                              .sink
                              .add(false);
                        });
                      }
                    }
                  }
                  return status! < 500;
                },
              ),
      );
      print("res ${res.toString()}");
      print("url ${url.toString()}");

      return res;
    } catch (e) {
      bool isAvailble = PostalCodeService().isSheetOpenGlobalSubject.value;
      if (!isAvailble) {
        PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
        if (errorCallBack != null) {
          errorCallBack.call();
        } else {
          CustomBottomSheet.show500BottomModelSheet(
                  NavigatorHelper.navigatorKey.currentContext!,
                  AppErrorSheet(
                    callBackTryAgain: () async {
                      PostalCodeService()
                          .isSheetOpenGlobalSubject
                          .sink
                          .add(false);
                      if (errorCallBack != null && retryCallBack != null) {
                        _post(url,
                                body: body,
                                errorCallBack: errorCallBack,
                                retryCallBack: retryCallBack)
                            .then((res) {
                          if (retryCallBack != null) {
                            retryCallBack.call(res);
                          }
                        });
                      } else if (retryCallBack != null) {
                        _post(url, body: body, retryCallBack: retryCallBack)
                            .then((res) {
                          if (retryCallBack != null) {
                            retryCallBack.call(res);
                          }
                        });
                      } else if (errorCallBack != null) {
                        _post(
                          url,
                          body: body,
                          errorCallBack: errorCallBack,
                        );
                      } else {
                        _post(url, body: body);
                      }
                    },
                    callBackClose: () {
                      PostalCodeService()
                          .isSheetOpenGlobalSubject
                          .sink
                          .add(false);
                      if (errorCallBack != null) {
                        errorCallBack.call();
                      }
                    },
                  ),
                  true,
                  isRemove: true)
              .then((value) {
            PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
          });
        }
      } else {
        if (errorCallBack != null) {
          errorCallBack.call();
        } else {
          CustomBottomSheet.show500BottomModelSheet(
                  NavigatorHelper.navigatorKey.currentContext!,
                  AppErrorSheet(
                    callBackTryAgain: () async {
                      PostalCodeService()
                          .isSheetOpenGlobalSubject
                          .sink
                          .add(false);
                      if (errorCallBack != null && retryCallBack != null) {
                        _post(url,
                                body: body,
                                errorCallBack: errorCallBack,
                                retryCallBack: retryCallBack)
                            .then((res) {
                          if (retryCallBack != null) {
                            retryCallBack.call(res);
                          }
                        });
                      } else if (retryCallBack != null) {
                        _post(url, body: body, retryCallBack: retryCallBack)
                            .then((res) {
                          if (retryCallBack != null) {
                            retryCallBack.call(res);
                          }
                        });
                      } else if (errorCallBack != null) {
                        _post(
                          url,
                          body: body,
                          errorCallBack: errorCallBack,
                        );
                      } else {
                        _post(url, body: body);
                      }
                    },
                    callBackClose: () {
                      PostalCodeService()
                          .isSheetOpenGlobalSubject
                          .sink
                          .add(false);
                      if (errorCallBack != null) {
                        errorCallBack.call();
                      }
                    },
                  ),
                  true,
                  isRemove: true)
              .then((value) {
            PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
          });
        }
      }
      if (throwOnError) rethrow;
    }
    print("h12");
    return null;
  }

  Future<Response?> _put(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    try {
      Response res = await dio.put(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status == 500) {
              if (retry) {
                CustomBottomSheet.show500BottomModelSheet(
                    NavigatorHelper.navigatorKey.currentContext!, AppErrorSheet(
                  callBackTryAgain: () async {
                    _put(url, body: body);
                  },
                ), true, isRemove: true);
              }
            }
            return status! < 500;
          },
        ),
      );
      return res;
    } catch (e) {
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _patch(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
    VoidCallback? errorCallBack,
  }) async {
    try {
      Response res = await dio.patch(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status == 500) {
              bool isAvailble =
                  PostalCodeService().isSheetOpenGlobalSubject.value;
              if (!isAvailble) {
                PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
                CustomBottomSheet.show500BottomModelSheet(
                        NavigatorHelper.navigatorKey.currentContext!,
                        AppErrorSheet(
                          callBackTryAgain: () async {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              _patch(url,
                                  body: body, errorCallBack: errorCallBack);
                            } else {
                              _patch(url, body: body);
                            }
                          },
                          callBackClose: () {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              errorCallBack.call();
                            }
                          },
                        ),
                        true,
                        isRemove: true)
                    .then((value) {
                  PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
                });
              }
            }
            return status! < 500;
          },
        ),
      );
      print("res ${res.toString()}");
      print("url ${url.toString()}");

      return res;
    } catch (e) {
      bool isAvailble = PostalCodeService().isSheetOpenGlobalSubject.value;
      if (!isAvailble) {
        PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
        CustomBottomSheet.show500BottomModelSheet(
                NavigatorHelper.navigatorKey.currentContext!,
                AppErrorSheet(
                  callBackTryAgain: () async {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null) {
                      _patch(url, body: body, errorCallBack: errorCallBack);
                    } else {
                      _patch(url, body: body);
                    }
                  },
                  callBackClose: () {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null) {
                      errorCallBack.call();
                    }
                  },
                ),
                true,
                isRemove: true)
            .then((value) {
          PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
        });
      }
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
    VoidCallback? errorCallBack,
  }) async {
    try {
      print(url);
      Response res = await dio.delete(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status == 500) {
              bool isAvailble =
                  PostalCodeService().isSheetOpenGlobalSubject.value;
              if (!isAvailble) {
                PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
                CustomBottomSheet.show500BottomModelSheet(
                        NavigatorHelper.navigatorKey.currentContext!,
                        AppErrorSheet(
                          callBackTryAgain: () async {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              _delete(url,
                                  body: body, errorCallBack: errorCallBack);
                            } else {
                              _delete(url, body: body);
                            }
                          },
                          callBackClose: () {
                            PostalCodeService()
                                .isSheetOpenGlobalSubject
                                .sink
                                .add(false);
                            if (errorCallBack != null) {
                              errorCallBack.call();
                            }
                          },
                        ),
                        true,
                        isRemove: true)
                    .then((value) {
                  PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
                });
              }
            }
            return status! < 500;
          },
        ),
      );
      print("res ${res.toString()}");
      print("url ${url.toString()}");

      return res;
    } catch (e) {
      bool isAvailble = PostalCodeService().isSheetOpenGlobalSubject.value;
      if (!isAvailble) {
        PostalCodeService().isSheetOpenGlobalSubject.sink.add(true);
        CustomBottomSheet.show500BottomModelSheet(
                NavigatorHelper.navigatorKey.currentContext!,
                AppErrorSheet(
                  callBackTryAgain: () async {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null)
                      _delete(url, body: body, errorCallBack: errorCallBack);
                    else {
                      _delete(url, body: body);
                    }
                  },
                  callBackClose: () {
                    PostalCodeService()
                        .isSheetOpenGlobalSubject
                        .sink
                        .add(false);
                    if (errorCallBack != null) {
                      errorCallBack.call();
                    }
                  },
                ),
                true,
                isRemove: true)
            .then((value) {
          PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
        });
      }
      if (throwOnError) rethrow;
    }
    return null;
  }

  String constructUrlWithoutMethodName(String path) => '$apiUrl/$path';

  String constructUrl(String path) => '$apiUrl/$methodName$path';

  String constructQueryUrl(String path, Map<String, String?> query) =>
      '$apiUrl/$methodName/$path?${query.entries.where((kv) => kv.value != null).map((kv) => '${kv.key}=${kv.value}').join('&')}';

  String constructQueryPageUrl(
          String path, Map<String, String> query, PageRequest page) =>
      constructQueryUrl(
        path,
        {
          ...query,
          page.constructSortKey(): page.lastValue,
          'limit': '${page.limit}'
        },
      );

  String constructPageUrl(String path, PageRequest page) => constructQueryUrl(
        path,
        {
          'limit': '${page.limit}',
          // Eg '&createdAt:lte=...'
          page.constructSortKey(): page.lastValue
        },
      );

  _setupInterceptors() {
    // Custom error handling
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          options.extra.putIfAbsent(
            RabbleDioOption.AuthorizationOAuth.value,
            () => false,
          );
          if (options.extra
                  .containsKey(RabbleDioOption.AuthorizationOAuth.value) &&
              !options.extra[RabbleDioOption.AuthorizationOAuth.value] &&
              useAuthentication) {
            try {
              final accessToken = await RabbleStorage().getToken();

              options.headers['Authorization'] = 'Bearer $accessToken';

              print(options.headers['Authorization']);
            } catch (e) {
              // TODO need to find a better way to deal with failing to get access token
              // The problem is that the error didn't seem to propagate outside of Dio... this might be new behavior
              options.headers['Authorization'] = '';
            }
          }
          if (Config().isDevelopment()) {
            options.connectTimeout = Duration(seconds: 15);
            options.receiveTimeout = Duration(seconds: 15);
          } else {
            options.connectTimeout = Duration(seconds: 30);
            options.receiveTimeout = Duration(seconds: 30);
          }
          options.extra.putIfAbsent(
            RabbleDioOption.SnackbarOnError.value,
            () => true,
          );
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.requestOptions.extra
                  .containsKey(RabbleDioOption.SnackbarOnError.value) &&
              !e.requestOptions.extra[RabbleDioOption.SnackbarOnError.value]) {
            // Log().debug('Sshh no snacky bar today');
            return handler.next(e);
          }

          ///Check if the error is 304 then we are good to go as our ETag caching works we just serve the cached version
          if (e.response != null &&
              ignoreResponseStatusCodes.contains(e.response!.statusCode)) {
            return handler.next(e);
          }
          // Why doesn't this throw??
          final errorSnackbar = GenericHTTPErrorSnackbars.fromDioError(e);
          // Snackbars only work in Scaffold
          // Login sequence is not scaffold
          // Login sequence is wrapped in Scaffold cause of builder. If it still not shows it must be something else

          if (e.isConnectionError()) {
            globalBloc.showConnectionErrorSnackBar();
            return handler.next(e);
          }

          if (globalBloc.scaffoldKey.currentContext != null &&
              errorSnackbar != null) {
            // NOTE can't hide+show because if this is called many times it will just
            // go up/down really quickly
            // Instead we just throttle so only one error shows in case of multiple
            final statusCodeRegex = RegExp(r'^5\d{2}$'); // regex for 5XX

            /// If the environment is production and the error status code is not in 5XX
            /// we will show the Snack-bar
            if (Config().isProduction() &&
                e.response != null &&
                !statusCodeRegex.hasMatch(e.response!.statusCode.toString())) {
              globalBloc.showHttpErrorSnackBar(errorSnackbar);
            }

            /// If the environment is development or QA show the Snack-bar
            /// without checking the error status code
            // else if (Config().isDevelopment() || Config().isQA())
            //   globalBloc.showHttpErrorSnackBar(errorSnackbar);

            return handler.next(e);
          }
        },
      ),
    );
  }

  showTimeoutDialog() {
    GenericTimeoutDialog(
      actions: [
        RabbleDialogButton(
          label: "RETRY",
          dialogButtonType: DialogButtonTypes.PRIMARY,
          onPressed: () {
            NavigatorHelper().pop();
            retry();
          },
        ),
      ],
    ).show(dismissible: false);
  }

  retry() async {
    await NavigatorHelper().navigateToScreen('/splash');
  }
}
