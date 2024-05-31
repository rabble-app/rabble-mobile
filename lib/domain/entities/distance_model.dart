class DistanceModel {
  DistanceModel({
    From? from,
    To? to,
    num? metres,
  }) {
    _from = from;
    _to = to;
    _metres = metres;
  }

  DistanceModel.fromJson(dynamic json) {
    _from = json['from'] != null ? From.fromJson(json['from']) : null;
    _to = json['to'] != null ? To.fromJson(json['to']) : null;
    _metres = json['metres'];
  }

  From? _from;
  To? _to;
  num? _metres;

  DistanceModel copyWith({
    From? from,
    To? to,
    num? metres,
  }) =>
      DistanceModel(
        from: from ?? _from,
        to: to ?? _to,
        metres: metres ?? _metres,
      );

  From? get from => _from;

  To? get to => _to;

  num? get metres => _metres;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_from != null) {
      map['from'] = _from?.toJson();
    }
    if (_to != null) {
      map['to'] = _to?.toJson();
    }
    map['metres'] = _metres;
    return map;
  }
}

class To {
  To({
    num? latitude,
    num? longitude,
    String? postcode,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _postcode = postcode;
  }

  To.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _postcode = json['postcode'];
  }

  num? _latitude;
  num? _longitude;
  String? _postcode;

  To copyWith({
    num? latitude,
    num? longitude,
    String? postcode,
  }) =>
      To(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        postcode: postcode ?? _postcode,
      );

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get postcode => _postcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['postcode'] = _postcode;
    return map;
  }
}

class From {
  From({
    num? latitude,
    num? longitude,
    String? postcode,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _postcode = postcode;
  }

  From.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _postcode = json['postcode'];
  }

  num? _latitude;
  num? _longitude;
  String? _postcode;

  From copyWith({
    num? latitude,
    num? longitude,
    String? postcode,
  }) =>
      From(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        postcode: postcode ?? _postcode,
      );

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get postcode => _postcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['postcode'] = _postcode;
    return map;
  }
}
