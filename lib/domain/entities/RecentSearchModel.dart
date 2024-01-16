class RecentSearchModel {
  RecentSearchModel({
      num? statusCode, 
      String? message, 
      List<RecentSearchData>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  RecentSearchModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RecentSearchData.fromJson(v));
      });
    }
  }
  num? _statusCode;
  String? _message;
  List<RecentSearchData>? _data;
RecentSearchModel copyWith({  num? statusCode,
  String? message,
  List<RecentSearchData>? data,
}) => RecentSearchModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  List<RecentSearchData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RecentSearchData {
  RecentSearchData({
      String? id, 
      String? keyword}){
    _id = id;
    _keyword = keyword;

}

  RecentSearchData.fromJson(dynamic json) {
    _id = json['id'].toString();
    _keyword = json['keyword'];
  }
  String? _id;
  String? _keyword;

RecentSearchData copyWith({  String? id,
  String? keyword,

}) => RecentSearchData(  id: id ?? _id,
  keyword: keyword ?? _keyword,

);
  String? get id => _id;
  String? get keyword => _keyword;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['keyword'] = _keyword;

    return map;
  }

}