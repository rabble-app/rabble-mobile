class Owner {
  Owner({
    this.firstName,
    this.lastName,
  });

  Owner.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  String? firstName;
  String? lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    return map;
  }
}
