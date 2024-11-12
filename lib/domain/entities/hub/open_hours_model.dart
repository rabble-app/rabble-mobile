
class OpenHoursModel {
  OpenHoursModel({
    String? type,
    List<CustomOpenHours>? customOpenHours,
  }) {
    _type = type;
    _customOpenHours = customOpenHours;
  }

  OpenHoursModel.fromJson(dynamic json) {
    _type = json['type'];
    if (json['CustomOpenHours'] != null && (json['type'] == 'CUSTOM' || json['type'] == 'MON_TO_FRI' )) {
      _customOpenHours = [];
      json['CustomOpenHours'].forEach((v) {
        _customOpenHours?.add(CustomOpenHours.fromJson(v));
      });
    }
  }

  String? _type;
  List<CustomOpenHours>? _customOpenHours;

  OpenHoursModel copyWith({
    String? type,
    List<CustomOpenHours>? customOpenHours,
  }) =>
      OpenHoursModel(
        type: type ?? _type,
        customOpenHours: customOpenHours ?? _customOpenHours,
      );

  String? get type => _type;

  List<CustomOpenHours>? get customOpenHours => _customOpenHours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_customOpenHours != null) {
      map['CustomOpenHours'] =
          _customOpenHours?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CustomOpenHours {
  CustomOpenHours({
    String? startTime,
    String? endTime,
    String? day,
  }) {
    _startTime = startTime;
    _endTime = endTime;
    _day = day;
  }

  CustomOpenHours.fromJson(dynamic json) {
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _day = json['day'];
  }

  String? _startTime;
  String? _endTime;
  String? _day;

  CustomOpenHours copyWith({
    String? startTime,
    String? endTime,
    String? day,
  }) =>
      CustomOpenHours(
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        day: day ?? _day,
      );

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get day => _day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['day'] = _day;
    return map;
  }
}
