



import 'package:rabble/core/config/export.dart';
class ApiResponse<T> extends RabbleBaseModel {
  T data;
  String message;
  int status;

  ApiResponse._(
      {required this.data, required this.message, required this.status});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    assert(dataFactories.containsKey(T),
        'Type not found in dataFactories ${T.toString()}');
    T model = dataFactories[T]!(json) as T;

    return ApiResponse._(
        data: model, message: json['message'].toString().contains(',') ? json['message'][0] : json['message'], status: json['statusCode']);
  }
}
