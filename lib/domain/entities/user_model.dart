class UserModel {
  UserModel({
      String? id, 
      String? phone, 
      dynamic email, 
      String? firstName, 
      String? lastName, 
      String? postalCode, 
      String? stripeCustomerId, 
      String? stripeDefaultPaymentMethodId, 
      String? cardLastFourDigits, 
      String? imageUrl, 
      String? imageKey, 
      String? role, 
      String? createdAt, 
      String? updatedAt, 
      String? token,}){
    _id = id;
    _phone = phone;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _postalCode = postalCode;
    _stripeCustomerId = stripeCustomerId;
    _stripeDefaultPaymentMethodId = stripeDefaultPaymentMethodId;
    _cardLastFourDigits = cardLastFourDigits;
    _imageUrl = imageUrl;
    _imageKey = imageKey;
    _role = role;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _phone = json['phone'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _postalCode = json['postalCode'];
    _stripeCustomerId = json['stripeCustomerId'];
    _stripeDefaultPaymentMethodId = json['stripeDefaultPaymentMethodId'];
    _cardLastFourDigits = json['cardLastFourDigits'];
    _imageUrl = json['imageUrl'];
    _imageKey = json['imageKey'];
    _role = json['role'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _token = json['token'];
  }
  String? _id;
  String? _phone;
  dynamic _email;
  String? _firstName;
  String? _lastName;
  String? _postalCode;
  String? _stripeCustomerId;
  String? _stripeDefaultPaymentMethodId;
  String? _cardLastFourDigits;
  String? _imageUrl;
  String? _imageKey;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
UserModel copyWith({  String? id,
  String? phone,
  dynamic email,
  String? firstName,
  String? lastName,
  String? postalCode,
  String? stripeCustomerId,
  String? stripeDefaultPaymentMethodId,
  String? cardLastFourDigits,
  String? imageUrl,
  String? imageKey,
  String? role,
  String? createdAt,
  String? updatedAt,
  String? token,
}) => UserModel(  id: id ?? _id,
  phone: phone ?? _phone,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  postalCode: postalCode ?? _postalCode,
  stripeCustomerId: stripeCustomerId ?? _stripeCustomerId,
  stripeDefaultPaymentMethodId: stripeDefaultPaymentMethodId ?? _stripeDefaultPaymentMethodId,
  cardLastFourDigits: cardLastFourDigits ?? _cardLastFourDigits,
  imageUrl: imageUrl ?? _imageUrl,
  imageKey: imageKey ?? _imageKey,
  role: role ?? _role,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  token: token ?? _token,
);
  String? get id => _id;
  String? get phone => _phone;
  dynamic get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get postalCode => _postalCode;
  String? get stripeCustomerId => _stripeCustomerId;
  String? get stripeDefaultPaymentMethodId => _stripeDefaultPaymentMethodId;
  String? get cardLastFourDigits => _cardLastFourDigits;
  String? get imageUrl => _imageUrl;
  String? get imageKey => _imageKey;
  String? get role => _role;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone'] = _phone;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['postalCode'] = _postalCode;
    map['stripeCustomerId'] = _stripeCustomerId;
    map['stripeDefaultPaymentMethodId'] = _stripeDefaultPaymentMethodId;
    map['cardLastFourDigits'] = _cardLastFourDigits;
    map['imageUrl'] = _imageUrl;
    map['imageKey'] = _imageKey;
    map['role'] = _role;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['token'] = _token;
    return map;
  }

  set imageKey(String? value) {
    _imageKey = value;
  }

  set imageUrl(String? value) {
    _imageUrl = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }
}