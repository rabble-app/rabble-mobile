class CollectionDetail {
  CollectionDetail({
    String? id,
    String? userId,
    String? dateOfCollection,
    String? status,
    String? qrCode,
  }) {
    _id = id;
    _userId = userId;
    _dateOfCollection = dateOfCollection;
    _status = status;
    _qrCode = qrCode;
  }

  CollectionDetail.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _dateOfCollection = json['dateOfCollection'];
    _status = json['status'];
    _qrCode = json['qrCode'] ?? '';
  }

  String? _id;
  String? _userId;
  String? _dateOfCollection;
  String? _status;
  String? _qrCode;

  CollectionDetail copyWith({
    String? id,
    String? userId,
    String? dateOfCollection,
    String? status,
    String? qrCode,
  }) =>
      CollectionDetail(
        id: id ?? _id,
        userId: userId ?? _userId,
        dateOfCollection: dateOfCollection ?? _dateOfCollection,
        status: status ?? _status,
        qrCode: qrCode ?? _qrCode,
      );


  String? get qrCode => _qrCode;

  String? get id => _id;

  String? get userId => _userId;

  String? get dateOfCollection => _dateOfCollection;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['dateOfCollection'] = _dateOfCollection;
    map['status'] = _status;
    return map;
  }
}
