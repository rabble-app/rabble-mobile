class PopularSearchModel {
  PopularSearchModel({
      num? statusCode, 
      String? message, 
      List<PopularSearchData>? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  PopularSearchModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PopularSearchData.fromJson(v));
      });
    }
  }
  num? _statusCode;
  String? _message;
  List<PopularSearchData>? _data;
PopularSearchModel copyWith({  num? statusCode,
  String? message,
  List<PopularSearchData>? data,
}) => PopularSearchModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  List<PopularSearchData>? get data => _data;

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

class PopularSearchData {
  PopularSearchData({
      String? id, 
      String? keyword, 
      String? category, 
      num? count, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _keyword = keyword;
    _category = category;
    _count = count;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PopularSearchData.fromJson(dynamic json) {
    _id = json['id'];
    _keyword = json['keyword'];
    _category = json['category'];
    _count = json['count'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _keyword;
  String? _category;
  num? _count;
  String? _createdAt;
  String? _updatedAt;
PopularSearchData copyWith({  String? id,
  String? keyword,
  String? category,
  num? count,
  String? createdAt,
  String? updatedAt,
}) => PopularSearchData(  id: id ?? _id,
  keyword: keyword ?? _keyword,
  category: category ?? _category,
  count: count ?? _count,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get keyword => _keyword;
  String? get category => _category;
  num? get count => _count;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['keyword'] = _keyword;
    map['category'] = _category;
    map['count'] = _count;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}