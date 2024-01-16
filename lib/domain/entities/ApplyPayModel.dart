class ApplyPayModel {
  ApplyPayModel({
    String? data,
    String? signature,
    Header? header,
    String? version,
  }) {
    _data = data;
    _signature = signature;
    _header = header;
    _version = version;
  }

  ApplyPayModel.fromJson(dynamic json) {
    _data = json['data'];
    _signature = json['signature'];
    _header = json['header'] != null ? Header.fromJson(json['header']) : null;
    _version = json['version'];
  }

  String? _data;
  String? _signature;
  Header? _header;
  String? _version;

  ApplyPayModel copyWith({
    String? data,
    String? signature,
    Header? header,
    String? version,
  }) =>
      ApplyPayModel(
        data: data ?? _data,
        signature: signature ?? _signature,
        header: header ?? _header,
        version: version ?? _version,
      );

  String? get data => _data;

  String? get signature => _signature;

  Header? get header => _header;

  String? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['signature'] = _signature;
    if (_header != null) {
      map['header'] = _header?.toJson();
    }
    map['version'] = _version;
    return map;
  }
}

class Header {
  Header({
    String? publicKeyHash,
    String? ephemeralPublicKey,
    String? transactionId,
  }) {
    _publicKeyHash = publicKeyHash;
    _ephemeralPublicKey = ephemeralPublicKey;
    _transactionId = transactionId;
  }

  Header.fromJson(dynamic json) {
    _publicKeyHash = json['publicKeyHash'];
    _ephemeralPublicKey = json['ephemeralPublicKey'];
    _transactionId = json['transactionId'];
  }

  String? _publicKeyHash;
  String? _ephemeralPublicKey;
  String? _transactionId;

  Header copyWith({
    String? publicKeyHash,
    String? ephemeralPublicKey,
    String? transactionId,
  }) =>
      Header(
        publicKeyHash: publicKeyHash ?? _publicKeyHash,
        ephemeralPublicKey: ephemeralPublicKey ?? _ephemeralPublicKey,
        transactionId: transactionId ?? _transactionId,
      );

  String? get publicKeyHash => _publicKeyHash;

  String? get ephemeralPublicKey => _ephemeralPublicKey;

  String? get transactionId => _transactionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publicKeyHash'] = _publicKeyHash;
    map['ephemeralPublicKey'] = _ephemeralPublicKey;
    map['transactionId'] = _transactionId;
    return map;
  }
}
