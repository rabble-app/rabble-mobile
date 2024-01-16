/// statusCode : 200
/// message : "Profile photo uploaded successfully"
/// data : {"ETag":"\"097e2cb578f4f50ae2436901cff4d122\"","ServerSideEncryption":"AES256","Location":"https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg","key":"profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg","Key":"profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg","Bucket":"rabble-dev1"}

class ProfilePictureModel {
  ProfilePictureModel({
      num? statusCode, 
      String? message, 
      Data? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ProfilePictureModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  String? _message;
  Data? _data;
ProfilePictureModel copyWith({  num? statusCode,
  String? message,
  Data? data,
}) => ProfilePictureModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

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

/// ETag : "\"097e2cb578f4f50ae2436901cff4d122\""
/// ServerSideEncryption : "AES256"
/// Location : "https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg"
/// key : "profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg"
/// Key : "profile/d1bdbd5e-cb21-4c1c-a328-73be47a7fc7d-hotseat2.jpg"
/// Bucket : "rabble-dev1"

class Data {
  Data({
      String? eTag, 
      String? serverSideEncryption, 
      String? location, 
      String? key, 
      String? bucket,}){
    _eTag = eTag;
    _serverSideEncryption = serverSideEncryption;
    _location = location;
    _key = key;
    _key = key;
    _bucket = bucket;
}

  Data.fromJson(dynamic json) {
    _eTag = json['ETag'];
    _serverSideEncryption = json['ServerSideEncryption'];
    _location = json['Location'];
    _key = json['key'];
    _bucket = json['Bucket'];
  }
  String? _eTag;
  String? _serverSideEncryption;
  String? _location;
  String? _key;
  String? _bucket;
Data copyWith({  String? eTag,
  String? serverSideEncryption,
  String? location,
  String? key,
  String? bucket,
}) => Data(  eTag: eTag ?? _eTag,
  serverSideEncryption: serverSideEncryption ?? _serverSideEncryption,
  location: location ?? _location,
  key: key ?? _key,
  bucket: bucket ?? _bucket,
);
  String? get eTag => _eTag;
  String? get serverSideEncryption => _serverSideEncryption;
  String? get location => _location;
  String? get key => _key;
  String? get bucket => _bucket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ETag'] = _eTag;
    map['ServerSideEncryption'] = _serverSideEncryption;
    map['Location'] = _location;
    map['Key'] = _key;
    map['Bucket'] = _bucket;
    return map;
  }

}