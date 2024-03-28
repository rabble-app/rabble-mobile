part of 'base_source.dart';

abstract class Source extends BaseSource {
  Source({required String methodName})
      : super(
            apiUrl: Config().API_URL, methodName: methodName, parser: Parser());

  Future<ApiResponse<T>?> get<T>(
    String url, {
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    VoidCallback? errorCallBack,
  }) async {
    final res = await _get(url,
        dioExtraOptions: dioExtraOptions,
        snackbarOnError: snackbarOnError,
        throwOnError: throwOnError,
        errorCallBack: errorCallBack);

    return parser.parse<T>(res);
  }

  Future<ApiResponse<T>?> post<T>(
    String url, {
    Map<String, dynamic>? body,
    FormData? data,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool? retry,
    VoidCallback? errorCallBack,
        Function? retryCallBack,
  }) async {
    print("body ${body.toString()}");
    if (data != null) print("data ${data.fields.toString()}");
    print("url ${url.toString()}");
    print("retry ${retry}");

    final res = await _post(url,
        body: body,
        data: data,
        dioExtraOptions: dioExtraOptions,
        snackbarOnError: snackbarOnError,
        throwOnError: throwOnError,
        retry: retry ?? true,
        retryCallBack: retryCallBack ,
        errorCallBack: errorCallBack);
    return parser.parse<T>(res);
  }

  Future<ApiResponse<T>?> put<T>(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    final res = await _put(
      url,
      body: body,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    print("PUT REQUEST ${res!.data.toString()}");
    return parser.parse<T>(res);
  }

  Future<ApiResponse<T>?> patch<T>(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await _patch(url,
        body: body,
        dioExtraOptions: dioExtraOptions,
        snackbarOnError: snackbarOnError,
        throwOnError: throwOnError,
        retry: retry,
        errorCallBack: errorCallBack);
    print("PUT REQUEST ${res!.data.toString()}");
    return parser.parse<T>(res);
  }

  Future<ApiResponse<T>?> delete<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
    VoidCallback? errorCallBack,
  }) async {
    final res = await _delete(url,
        body: body,
        dioExtraOptions: dioExtraOptions,
        snackbarOnError: snackbarOnError,
        throwOnError: throwOnError,
        retry: retry,
        errorCallBack: errorCallBack);
    return parser.parse<T>(res);
  }

  // Not a good way to do but couldn't find the other way around.
  Future<ApiResponse<T>?> deleteReturnData<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> dioExtraOptions = const {},
    List<Function(T)>? listeners,
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    final res = await _delete(
      url,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    final model = parser.parse<T>(res);
    if (model?.data != null && listeners != null && listeners.length > 0)
      listeners.forEach((event) => event(model!.data!));
    return model;
  }
}
