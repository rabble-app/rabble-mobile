class HostData {
  HostData({
    String? firstName,
    String? lastName,
  }) {
    _firstName = firstName;
    _lastName = lastName;
  }

  HostData.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
  }

  String? _firstName;
  String? _lastName;

  HostData copyWith({
    String? firstName,
    String? lastName,
  }) =>
      HostData(
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
      );

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    return map;
  }
}
