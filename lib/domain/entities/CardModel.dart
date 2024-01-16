class CardModel {
  CardModel({
    num? statusCode,
    String? message,
    List<CardData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  CardModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CardData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<CardData>? _data;
  

  CardModel copyWith({
    num? statusCode,
    String? message,
    List<CardData>? data,
  }) =>
      CardModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<CardData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CardData {
  CardData({
    String? id,
    String? object,
    BillingDetails? billingDetails,
    CardInfo? card,
    num? created,
    String? customer,
    bool? livemode,
    dynamic metadata,
    String? type,
  }) {
    _id = id;
    _object = object;
    _billingDetails = billingDetails;
    _card = card;
    _created = created;
    _customer = customer;
    _livemode = livemode;
    _metadata = metadata;
    _type = type;
  }

  CardData.fromJson(dynamic json) {
    _id = json['id'];
    _object = json['object'];
    _billingDetails = json['billing_details'] != null
        ? BillingDetails.fromJson(json['billing_details'])
        : null;
    _card = json['card'] != null ? CardInfo.fromJson(json['card']) : null;
    _created = json['created'];
    _customer = json['customer'];
    _livemode = json['livemode'];
    _metadata = json['metadata'];
    _type = json['type'];
  }

  String? _id;
  String? _object;
  BillingDetails? _billingDetails;
  CardInfo? _card;
  num? _created;
  String? _customer;
  bool? _livemode;
  dynamic _metadata;
  String? _type;
  bool? _isSelected = false;

  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }
  CardData copyWith({
    String? id,
    String? object,
    BillingDetails? billingDetails,
    CardInfo? card,
    num? created,
    String? customer,
    bool? livemode,
    dynamic metadata,
    String? type,
  }) =>
      CardData(
        id: id ?? _id,
        object: object ?? _object,
        billingDetails: billingDetails ?? _billingDetails,
        card: card ?? _card,
        created: created ?? _created,
        customer: customer ?? _customer,
        livemode: livemode ?? _livemode,
        metadata: metadata ?? _metadata,
        type: type ?? _type,
      );

  String? get id => _id;

  String? get object => _object;

  BillingDetails? get billingDetails => _billingDetails;

  CardInfo? get card => _card;

  num? get created => _created;

  String? get customer => _customer;

  bool? get livemode => _livemode;

  dynamic get metadata => _metadata;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['object'] = _object;
    if (_billingDetails != null) {
      map['billing_details'] = _billingDetails?.toJson();
    }
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    map['created'] = _created;
    map['customer'] = _customer;
    map['livemode'] = _livemode;
    map['metadata'] = _metadata;
    map['type'] = _type;
    return map;
  }
}

class CardInfo {
  CardInfo({
    String? brand,
    Checks? checks,
    String? country,
    num? expMonth,
    num? expYear,
    String? fingerprint,
    String? funding,
    dynamic generatedFrom,
    String? last4,
    Networks? networks,
    ThreeDSecureUsage? threeDSecureUsage,
    dynamic wallet,
  }) {
    _brand = brand;
    _checks = checks;
    _country = country;
    _expMonth = expMonth;
    _expYear = expYear;
    _fingerprint = fingerprint;
    _funding = funding;
    _generatedFrom = generatedFrom;
    _last4 = last4;
    _networks = networks;
    _threeDSecureUsage = threeDSecureUsage;
    _wallet = wallet;
  }

  CardInfo.fromJson(dynamic json) {
    _brand = json['brand'];
    _checks = json['checks'] != null ? Checks.fromJson(json['checks']) : null;
    _country = json['country'];
    _expMonth = json['exp_month'];
    _expYear = json['exp_year'];
    _fingerprint = json['fingerprint'];
    _funding = json['funding'];
    _generatedFrom = json['generated_from'];
    _last4 = json['last4'];
    _networks =
        json['networks'] != null ? Networks.fromJson(json['networks']) : null;
    _threeDSecureUsage = json['three_d_secure_usage'] != null
        ? ThreeDSecureUsage.fromJson(json['three_d_secure_usage'])
        : null;
    _wallet = json['wallet'];
  }

  String? _brand;
  Checks? _checks;
  String? _country;
  num? _expMonth;
  num? _expYear;
  String? _fingerprint;
  String? _funding;
  dynamic _generatedFrom;
  String? _last4;
  Networks? _networks;
  ThreeDSecureUsage? _threeDSecureUsage;
  dynamic _wallet;

  CardInfo copyWith({
    String? brand,
    Checks? checks,
    String? country,
    num? expMonth,
    num? expYear,
    String? fingerprint,
    String? funding,
    dynamic generatedFrom,
    String? last4,
    Networks? networks,
    ThreeDSecureUsage? threeDSecureUsage,
    dynamic wallet,
  }) =>
      CardInfo(
        brand: brand ?? _brand,
        checks: checks ?? _checks,
        country: country ?? _country,
        expMonth: expMonth ?? _expMonth,
        expYear: expYear ?? _expYear,
        fingerprint: fingerprint ?? _fingerprint,
        funding: funding ?? _funding,
        generatedFrom: generatedFrom ?? _generatedFrom,
        last4: last4 ?? _last4,
        networks: networks ?? _networks,
        threeDSecureUsage: threeDSecureUsage ?? _threeDSecureUsage,
        wallet: wallet ?? _wallet,
      );

  String? get brand => _brand;

  Checks? get checks => _checks;

  String? get country => _country;

  num? get expMonth => _expMonth;

  num? get expYear => _expYear;

  String? get fingerprint => _fingerprint;

  String? get funding => _funding;

  dynamic get generatedFrom => _generatedFrom;

  String? get last4 => _last4;

  Networks? get networks => _networks;

  ThreeDSecureUsage? get threeDSecureUsage => _threeDSecureUsage;

  dynamic get wallet => _wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = _brand;
    if (_checks != null) {
      map['checks'] = _checks?.toJson();
    }
    map['country'] = _country;
    map['exp_month'] = _expMonth;
    map['exp_year'] = _expYear;
    map['fingerprint'] = _fingerprint;
    map['funding'] = _funding;
    map['generated_from'] = _generatedFrom;
    map['last4'] = _last4;
    if (_networks != null) {
      map['networks'] = _networks?.toJson();
    }
    if (_threeDSecureUsage != null) {
      map['three_d_secure_usage'] = _threeDSecureUsage?.toJson();
    }
    map['wallet'] = _wallet;
    return map;
  }
}

class ThreeDSecureUsage {
  ThreeDSecureUsage({
    bool? supported,
  }) {
    _supported = supported;
  }

  ThreeDSecureUsage.fromJson(dynamic json) {
    _supported = json['supported'];
  }

  bool? _supported;

  ThreeDSecureUsage copyWith({
    bool? supported,
  }) =>
      ThreeDSecureUsage(
        supported: supported ?? _supported,
      );

  bool? get supported => _supported;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['supported'] = _supported;
    return map;
  }
}

class Networks {
  Networks({
    List<String>? available,
    dynamic preferred,
  }) {
    _available = available;
    _preferred = preferred;
  }

  Networks.fromJson(dynamic json) {
    _available =
        json['available'] != null ? json['available'].cast<String>() : [];
    _preferred = json['preferred'];
  }

  List<String>? _available;
  dynamic _preferred;

  Networks copyWith({
    List<String>? available,
    dynamic preferred,
  }) =>
      Networks(
        available: available ?? _available,
        preferred: preferred ?? _preferred,
      );

  List<String>? get available => _available;

  dynamic get preferred => _preferred;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['available'] = _available;
    map['preferred'] = _preferred;
    return map;
  }
}

class Checks {
  Checks({
    dynamic addressLine1Check,
    dynamic addressPostalCodeCheck,
    String? cvcCheck,
  }) {
    _addressLine1Check = addressLine1Check;
    _addressPostalCodeCheck = addressPostalCodeCheck;
    _cvcCheck = cvcCheck;
  }

  Checks.fromJson(dynamic json) {
    _addressLine1Check = json['address_line1_check'];
    _addressPostalCodeCheck = json['address_postal_code_check'];
    _cvcCheck = json['cvc_check'];
  }

  dynamic _addressLine1Check;
  dynamic _addressPostalCodeCheck;
  String? _cvcCheck;

  Checks copyWith({
    dynamic addressLine1Check,
    dynamic addressPostalCodeCheck,
    String? cvcCheck,
  }) =>
      Checks(
        addressLine1Check: addressLine1Check ?? _addressLine1Check,
        addressPostalCodeCheck:
            addressPostalCodeCheck ?? _addressPostalCodeCheck,
        cvcCheck: cvcCheck ?? _cvcCheck,
      );

  dynamic get addressLine1Check => _addressLine1Check;

  dynamic get addressPostalCodeCheck => _addressPostalCodeCheck;

  String? get cvcCheck => _cvcCheck;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line1_check'] = _addressLine1Check;
    map['address_postal_code_check'] = _addressPostalCodeCheck;
    map['cvc_check'] = _cvcCheck;
    return map;
  }
}

class BillingDetails {
  BillingDetails({
    Address? address,
    dynamic email,
    dynamic name,
    dynamic phone,
  }) {
    _address = address;
    _email = email;
    _name = name;
    _phone = phone;
  }

  BillingDetails.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _email = json['email'];
    _name = json['name'];
    _phone = json['phone'];
  }

  Address? _address;
  dynamic _email;
  dynamic _name;
  dynamic _phone;

  BillingDetails copyWith({
    Address? address,
    dynamic email,
    dynamic name,
    dynamic phone,
  }) =>
      BillingDetails(
        address: address ?? _address,
        email: email ?? _email,
        name: name ?? _name,
        phone: phone ?? _phone,
      );

  Address? get address => _address;

  dynamic get email => _email;

  dynamic get name => _name;

  dynamic get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['email'] = _email;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }
}

class Address {
  Address({
    dynamic city,
    dynamic country,
    dynamic line1,
    dynamic line2,
    dynamic postalCode,
    dynamic state,
  }) {
    _city = city;
    _country = country;
    _line1 = line1;
    _line2 = line2;
    _postalCode = postalCode;
    _state = state;
  }

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _country = json['country'];
    _line1 = json['line1'];
    _line2 = json['line2'];
    _postalCode = json['postal_code'];
    _state = json['state'];
  }

  dynamic _city;
  dynamic _country;
  dynamic _line1;
  dynamic _line2;
  dynamic _postalCode;
  dynamic _state;

  Address copyWith({
    dynamic city,
    dynamic country,
    dynamic line1,
    dynamic line2,
    dynamic postalCode,
    dynamic state,
  }) =>
      Address(
        city: city ?? _city,
        country: country ?? _country,
        line1: line1 ?? _line1,
        line2: line2 ?? _line2,
        postalCode: postalCode ?? _postalCode,
        state: state ?? _state,
      );

  dynamic get city => _city;

  dynamic get country => _country;

  dynamic get line1 => _line1;

  dynamic get line2 => _line2;

  dynamic get postalCode => _postalCode;

  dynamic get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['country'] = _country;
    map['line1'] = _line1;
    map['line2'] = _line2;
    map['postal_code'] = _postalCode;
    map['state'] = _state;
    return map;
  }
}
