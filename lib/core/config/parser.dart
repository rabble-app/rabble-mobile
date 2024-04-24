

import 'package:rabble/core/config/export.dart';

class Parser {
  ApiResponse<T>? parse<T>(Response? response) {
    if (response == null) return null;
    try {

      return ApiResponse<T>.fromJson(response.data);
    } catch (e, stacktrace) {
      rethrow;
    }
  }

  ApiResponse<T>? parseMap<T>(dynamic response) {
    if (response == null) return null;
    try {
      return ApiResponse<T>.fromJson(response);
    } catch (e, stacktrace) {
      rethrow;
    }
  }
}
