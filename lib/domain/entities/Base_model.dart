class BaseModel{
  BaseModel({
      this.message, 
      this.status, 
   });

  BaseModel.fromJson(dynamic json) {
    print("***** ${json.toString()}");
    if(json['message']!=null) {
      message = json['message'] is List && json['message'].toString().contains(',') ? json['message'][0] ?? '' : json['message'] ?? '';
    }
    if(json['statusCode']!=null) {
      status = json['statusCode'] ?? '';
    }
    if(json['data']!=null) {
      data = json['data'];
    }else{
      data = json;
    }
  }
  String? message;
  int? status;
  dynamic? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = status;
    map['data'] = data;
    return map;
  }


}
