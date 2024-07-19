import 'package:rabble/domain/entities/hub/open_hours_model.dart';

class Partner {
  Partner({
      this.name, 
      this.postalCode, 
      this.city, 
      this.streetAddress, 
      this.direction,
    this.openHoursModel

  });

  Partner.fromJson(dynamic json) {
    name = json['name'] ?? '';
    postalCode = json['postalCode'] ?? '';
    city = json['city'] ?? '';
    streetAddress = json['streetAddress'] ?? '';
    direction = json['direction'] ?? '';
    if(json['openhour']!=null) {
      openHoursModel = OpenHoursModel.fromJson(json['openhour']) ;
    }
  }
  String? name;
  String? postalCode;
  String? city;
  String? streetAddress;
  String? direction;
  OpenHoursModel? openHoursModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['postalCode'] = postalCode;
    map['city'] = city;
    map['streetAddress'] = streetAddress;
    map['direction'] = direction;
    map['openhour'] = openHoursModel;
    return map;
  }

}