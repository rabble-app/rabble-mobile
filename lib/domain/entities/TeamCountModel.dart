class Count {
  Count({
    num? buyingteams,
    num? order,
    num? members,
  }) {
    _buyingteams = buyingteams;
    _order = order;
    _members = members;
  }

  Count.fromJson(dynamic json) {
    _buyingteams = json['buyingteams'];
    _order = json['orders'] ?? 0;
    _members = json['members'] ?? 0;
  }

  num? _buyingteams;
  num? _order;
  num? _members;

  Count copyWith({
    num? buyingteams,
    num? order,
    num? members,
  }) =>
      Count(
        buyingteams: buyingteams ?? _buyingteams,
        order: order ?? _order,
        members: members ?? _members,
      );

  num? get buyingteams => _buyingteams;

  num? get order => _order;


  num? get members => _members;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buyingteams'] = _buyingteams;
    return map;
  }
}
