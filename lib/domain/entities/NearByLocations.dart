class NearByLocations {
  NearByLocations({
    num? latitude,
    num? longitude,
    List<String>? addresses,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _addresses = addresses;
  }

  NearByLocations.fromJson(dynamic json) {
    _latitude = json['Latitude'];
    _longitude = json['Longitude'];
    _addresses =
        json['Addresses'] != null ? json['Addresses'].cast<String>() : [];
  }

  num? _latitude;
  num? _longitude;
  List<String>? _addresses;

  NearByLocations copyWith({
    num? latitude,
    num? longitude,
    List<String>? addresses,
  }) =>
      NearByLocations(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        addresses: addresses ?? _addresses,
      );

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  List<String>? get addresses => _addresses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Latitude'] = _latitude;
    map['Longitude'] = _longitude;
    map['Addresses'] = _addresses;
    return map;
  }
}
