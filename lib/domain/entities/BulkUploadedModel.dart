class BulkUploadedModel {
  BulkUploadedModel({
      num? statusCode, 
      String? message, 
      BulkData? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  BulkUploadedModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'] is List && json['message'].toString().contains(',') ? json['message'][0] : json['message'];
    _data = json['data'] != null ? BulkData.fromJson(json['data']) : null;
  }
  num? _statusCode;
  String? _message;
  BulkData? _data;

BulkUploadedModel copyWith({  num? statusCode,
  String? message,
  BulkData? data,
}) => BulkUploadedModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  BulkData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class BulkData {
  BulkData({
      num? count,}){
    _count = count;
}

  BulkData.fromJson(dynamic json) {
    _count = json['count'];
  }
  num? _count;
BulkData copyWith({  num? count,
}) => BulkData(  count: count ?? _count,
);
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    return map;
  }

}