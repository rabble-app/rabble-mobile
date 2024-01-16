class ChargeModel {
  ChargeModel({
    num? statusCode,
    String? message,
    ChargeData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ChargeModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? ChargeData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  ChargeData? _data;

  ChargeModel copyWith({
    num? statusCode,
    String? message,
    ChargeData? data,
  }) =>
      ChargeModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  ChargeData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class ChargeData {
  ChargeData({
    String? id,
    String? paymentIntentId,
    String? clientSecret,
    String? orderId,
    String? object,
    num? amount,
    num? amountCapturable,
    AmountDetails? amountDetails,
    num? amountReceived,
    dynamic application,
    dynamic applicationFeeAmount,
    dynamic automaticPaymentMethods,
    dynamic canceledAt,
    dynamic cancellationReason,
    String? captureMethod,
    String? confirmationMethod,
    num? created,
    String? currency,
    String? customer,
    dynamic description,
    dynamic invoice,
    dynamic lastPaymentError,
    dynamic latestCharge,
    bool? livemode,
    dynamic metadata,
    NextAction? nextAction,
    dynamic onBehalfOf,
    String? paymentMethod,
    dynamic paymentMethodConfigurationDetails,
    PaymentMethodOptions? paymentMethodOptions,
    List<String>? paymentMethodTypes,
    dynamic processing,
    dynamic receiptEmail,
    dynamic review,
    String? setupFutureUsage,
    dynamic shipping,
    dynamic source,
    dynamic statementDescriptor,
    dynamic statementDescriptorSuffix,
    String? status,
    dynamic transferData,
    dynamic transferGroup,
  }) {
    _id = id;
    _paymentIntentId = paymentIntentId;
    _clientSecret = clientSecret;
    _orderId = orderId;
    _object = object;
    _amount = amount;
    _amountCapturable = amountCapturable;
    _amountDetails = amountDetails;
    _amountReceived = amountReceived;
    _application = application;
    _applicationFeeAmount = applicationFeeAmount;
    _automaticPaymentMethods = automaticPaymentMethods;
    _canceledAt = canceledAt;
    _cancellationReason = cancellationReason;
    _captureMethod = captureMethod;
    _clientSecret = clientSecret;
    _confirmationMethod = confirmationMethod;
    _created = created;
    _currency = currency;
    _customer = customer;
    _description = description;
    _invoice = invoice;
    _lastPaymentError = lastPaymentError;
    _latestCharge = latestCharge;
    _livemode = livemode;
    _metadata = metadata;
    _nextAction = nextAction;
    _onBehalfOf = onBehalfOf;
    _paymentMethod = paymentMethod;
    _paymentMethodConfigurationDetails = paymentMethodConfigurationDetails;
    _paymentMethodOptions = paymentMethodOptions;
    _paymentMethodTypes = paymentMethodTypes;
    _processing = processing;
    _receiptEmail = receiptEmail;
    _review = review;
    _setupFutureUsage = setupFutureUsage;
    _shipping = shipping;
    _source = source;
    _statementDescriptor = statementDescriptor;
    _statementDescriptorSuffix = statementDescriptorSuffix;
    _status = status;
    _transferData = transferData;
    _transferGroup = transferGroup;
  }

  ChargeData.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _paymentIntentId = json['paymentIntentId'] ?? '';
    _clientSecret = json['clientSecret'] ?? '';
    _orderId = json['orderId'] ?? '';
    _object = json['object'] ?? '';
    _amount = json['amount'] ?? 0;
    _amountCapturable = json['amount_capturable'] ?? 0;
    _amountDetails = json['amount_details'] != null
        ? AmountDetails.fromJson(json['amount_details'])
        : null;
    _amountReceived = json['amount_received'] ?? 0;
    _application = json['application'] ?? '';
    _applicationFeeAmount = json['application_fee_amount'] ?? '';
    _automaticPaymentMethods = json['automatic_payment_methods'] ?? '';
    _canceledAt = json['canceled_at'] ?? '';
    _cancellationReason = json['cancellation_reason'] ?? '';
    _captureMethod = json['capture_method'] ?? '';
    _clientSecret = json['client_secret'] ?? '';
    _confirmationMethod = json['confirmation_method'] ?? '';
    _created = json['created'] ?? 0;
    _currency = json['currency'] ?? '';
    _customer = json['customer'] ?? '';
    _description = json['description'] ?? '';
    _invoice = json['invoice'] ?? '';
    _lastPaymentError = json['last_payment_error'] ?? '';
    _latestCharge = json['latest_charge'] ?? '';
    _livemode = json['livemode'] ?? false;
    _metadata = json['metadata'] ?? '';
    _nextAction = json['next_action'] != null
        ? NextAction.fromJson(json['next_action'])
        : null;
    _onBehalfOf = json['on_behalf_of'] ?? '';
    _paymentMethod = json['payment_method'] ?? '';
    _paymentMethodConfigurationDetails =
        json['payment_method_configuration_details'];
    _paymentMethodOptions = json['payment_method_options'] != null
        ? PaymentMethodOptions.fromJson(json['payment_method_options'])
        : null;
    _paymentMethodTypes = json['payment_method_types'] != null
        ? json['payment_method_types'].cast<String>()
        : [];
    _processing = json['processing'] ?? '';
    _receiptEmail = json['receipt_email'] ?? '';
    _review = json['review'] ?? '';
    _setupFutureUsage = json['setup_future_usage'] ?? '';
    _shipping = json['shipping'] ?? '';
    _source = json['source'] ?? '';
    _statementDescriptor = json['statement_descriptor'] ?? '';
    _statementDescriptorSuffix = json['statement_descriptor_suffix'] ?? '';
    _status = json['status'] ?? '';
    _transferData = json['transfer_data'] ?? '';
    _transferGroup = json['transfer_group'] ?? '';
  }

  String? _id;
  String? _paymentIntentId;
  String? _clientSecret;
  String? _orderId;
  String? _object;
  num? _amount;
  num? _amountCapturable;
  AmountDetails? _amountDetails;
  num? _amountReceived;
  dynamic _application;
  dynamic _applicationFeeAmount;
  dynamic _automaticPaymentMethods;
  dynamic _canceledAt;
  dynamic _cancellationReason;
  String? _captureMethod;
  String? _confirmationMethod;
  num? _created;
  String? _currency;
  String? _customer;
  dynamic _description;
  dynamic _invoice;
  dynamic _lastPaymentError;
  dynamic _latestCharge;
  bool? _livemode;
  dynamic _metadata;
  NextAction? _nextAction;
  dynamic _onBehalfOf;
  String? _paymentMethod;
  dynamic _paymentMethodConfigurationDetails;
  PaymentMethodOptions? _paymentMethodOptions;
  List<String>? _paymentMethodTypes;
  dynamic _processing;
  dynamic _receiptEmail;
  dynamic _review;
  String? _setupFutureUsage;
  dynamic _shipping;
  dynamic _source;
  dynamic _statementDescriptor;
  dynamic _statementDescriptorSuffix;
  String? _status;
  dynamic _transferData;
  dynamic _transferGroup;

  ChargeData copyWith({
    String? id,
    String? paymentIntentId,
    String? clientSecret,
    String? orderId,
    String? object,
    num? amount,
    num? amountCapturable,
    AmountDetails? amountDetails,
    num? amountReceived,
    dynamic application,
    dynamic applicationFeeAmount,
    dynamic automaticPaymentMethods,
    dynamic canceledAt,
    dynamic cancellationReason,
    String? captureMethod,
    String? confirmationMethod,
    num? created,
    String? currency,
    String? customer,
    dynamic description,
    dynamic invoice,
    dynamic lastPaymentError,
    dynamic latestCharge,
    bool? livemode,
    dynamic metadata,
    NextAction? nextAction,
    dynamic onBehalfOf,
    String? paymentMethod,
    dynamic paymentMethodConfigurationDetails,
    PaymentMethodOptions? paymentMethodOptions,
    List<String>? paymentMethodTypes,
    dynamic processing,
    dynamic receiptEmail,
    dynamic review,
    String? setupFutureUsage,
    dynamic shipping,
    dynamic source,
    dynamic statementDescriptor,
    dynamic statementDescriptorSuffix,
    String? status,
    dynamic transferData,
    dynamic transferGroup,
  }) =>
      ChargeData(
        id: id ?? _id,
        paymentIntentId: paymentIntentId ?? _paymentIntentId,
        clientSecret: clientSecret ?? _clientSecret,
        orderId: orderId ?? _orderId,
        object: object ?? _object,
        amount: amount ?? _amount,
        amountCapturable: amountCapturable ?? _amountCapturable,
        amountDetails: amountDetails ?? _amountDetails,
        amountReceived: amountReceived ?? _amountReceived,
        application: application ?? _application,
        applicationFeeAmount: applicationFeeAmount ?? _applicationFeeAmount,
        automaticPaymentMethods:
            automaticPaymentMethods ?? _automaticPaymentMethods,
        canceledAt: canceledAt ?? _canceledAt,
        cancellationReason: cancellationReason ?? _cancellationReason,
        captureMethod: captureMethod ?? _captureMethod,
        confirmationMethod: confirmationMethod ?? _confirmationMethod,
        created: created ?? _created,
        currency: currency ?? _currency,
        customer: customer ?? _customer,
        description: description ?? _description,
        invoice: invoice ?? _invoice,
        lastPaymentError: lastPaymentError ?? _lastPaymentError,
        latestCharge: latestCharge ?? _latestCharge,
        livemode: livemode ?? _livemode,
        metadata: metadata ?? _metadata,
        nextAction: nextAction ?? _nextAction,
        onBehalfOf: onBehalfOf ?? _onBehalfOf,
        paymentMethod: paymentMethod ?? _paymentMethod,
        paymentMethodConfigurationDetails: paymentMethodConfigurationDetails ??
            _paymentMethodConfigurationDetails,
        paymentMethodOptions: paymentMethodOptions ?? _paymentMethodOptions,
        paymentMethodTypes: paymentMethodTypes ?? _paymentMethodTypes,
        processing: processing ?? _processing,
        receiptEmail: receiptEmail ?? _receiptEmail,
        review: review ?? _review,
        setupFutureUsage: setupFutureUsage ?? _setupFutureUsage,
        shipping: shipping ?? _shipping,
        source: source ?? _source,
        statementDescriptor: statementDescriptor ?? _statementDescriptor,
        statementDescriptorSuffix:
            statementDescriptorSuffix ?? _statementDescriptorSuffix,
        status: status ?? _status,
        transferData: transferData ?? _transferData,
        transferGroup: transferGroup ?? _transferGroup,
      );

  String? get id => _id;

  String? get paymentIntentId => _paymentIntentId;

  String? get clientSecret => _clientSecret;

  String? get orderId => _orderId;

  String? get object => _object;

  num? get amount => _amount;

  num? get amountCapturable => _amountCapturable;

  AmountDetails? get amountDetails => _amountDetails;

  num? get amountReceived => _amountReceived;

  dynamic get application => _application;

  dynamic get applicationFeeAmount => _applicationFeeAmount;

  dynamic get automaticPaymentMethods => _automaticPaymentMethods;

  dynamic get canceledAt => _canceledAt;

  dynamic get cancellationReason => _cancellationReason;

  String? get captureMethod => _captureMethod;

  String? get confirmationMethod => _confirmationMethod;

  num? get created => _created;

  String? get currency => _currency;

  String? get customer => _customer;

  dynamic get description => _description;

  dynamic get invoice => _invoice;

  dynamic get lastPaymentError => _lastPaymentError;

  dynamic get latestCharge => _latestCharge;

  bool? get livemode => _livemode;

  dynamic get metadata => _metadata;

  NextAction? get nextAction => _nextAction;

  dynamic get onBehalfOf => _onBehalfOf;

  String? get paymentMethod => _paymentMethod;

  dynamic get paymentMethodConfigurationDetails =>
      _paymentMethodConfigurationDetails;

  PaymentMethodOptions? get paymentMethodOptions => _paymentMethodOptions;

  List<String>? get paymentMethodTypes => _paymentMethodTypes;

  dynamic get processing => _processing;

  dynamic get receiptEmail => _receiptEmail;

  dynamic get review => _review;

  String? get setupFutureUsage => _setupFutureUsage;

  dynamic get shipping => _shipping;

  dynamic get source => _source;

  dynamic get statementDescriptor => _statementDescriptor;

  dynamic get statementDescriptorSuffix => _statementDescriptorSuffix;

  String? get status => _status;

  dynamic get transferData => _transferData;

  dynamic get transferGroup => _transferGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['paymentIntentId'] = _paymentIntentId;
    map['clientSecret'] = _clientSecret;
    map['orderId'] = _orderId;
    map['object'] = _object;
    map['amount'] = _amount;
    map['amount_capturable'] = _amountCapturable;
    if (_amountDetails != null) {
      map['amount_details'] = _amountDetails?.toJson();
    }
    map['amount_received'] = _amountReceived;
    map['application'] = _application;
    map['application_fee_amount'] = _applicationFeeAmount;
    map['automatic_payment_methods'] = _automaticPaymentMethods;
    map['canceled_at'] = _canceledAt;
    map['cancellation_reason'] = _cancellationReason;
    map['capture_method'] = _captureMethod;
    map['client_secret'] = _clientSecret;
    map['confirmation_method'] = _confirmationMethod;
    map['created'] = _created;
    map['currency'] = _currency;
    map['customer'] = _customer;
    map['description'] = _description;
    map['invoice'] = _invoice;
    map['last_payment_error'] = _lastPaymentError;
    map['latest_charge'] = _latestCharge;
    map['livemode'] = _livemode;
    map['metadata'] = _metadata;
    if (_nextAction != null) {
      map['next_action'] = _nextAction?.toJson();
    }
    map['on_behalf_of'] = _onBehalfOf;
    map['payment_method'] = _paymentMethod;
    map['payment_method_configuration_details'] =
        _paymentMethodConfigurationDetails;
    if (_paymentMethodOptions != null) {
      map['payment_method_options'] = _paymentMethodOptions?.toJson();
    }
    map['payment_method_types'] = _paymentMethodTypes;
    map['processing'] = _processing;
    map['receipt_email'] = _receiptEmail;
    map['review'] = _review;
    map['setup_future_usage'] = _setupFutureUsage;
    map['shipping'] = _shipping;
    map['source'] = _source;
    map['statement_descriptor'] = _statementDescriptor;
    map['statement_descriptor_suffix'] = _statementDescriptorSuffix;
    map['status'] = _status;
    map['transfer_data'] = _transferData;
    map['transfer_group'] = _transferGroup;
    return map;
  }
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    UserCard? card,
  }) {
    _card = card;
  }

  PaymentMethodOptions.fromJson(dynamic json) {
    _card = json['card'] != null ? UserCard.fromJson(json['card']) : null;
  }

  UserCard? _card;

  PaymentMethodOptions copyWith({
    UserCard? card,
  }) =>
      PaymentMethodOptions(
        card: card ?? _card,
      );

  UserCard? get card => _card;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    return map;
  }
}

class UserCard {
  UserCard({
    dynamic installments,
    dynamic mandateOptions,
    dynamic network,
    String? requestThreeDSecure,
  }) {
    _installments = installments;
    _mandateOptions = mandateOptions;
    _network = network;
    _requestThreeDSecure = requestThreeDSecure;
  }

  UserCard.fromJson(dynamic json) {
    _installments = json['installments'];
    _mandateOptions = json['mandate_options'];
    _network = json['network'];
    _requestThreeDSecure = json['request_three_d_secure'];
  }

  dynamic _installments;
  dynamic _mandateOptions;
  dynamic _network;
  String? _requestThreeDSecure;

  UserCard copyWith({
    dynamic installments,
    dynamic mandateOptions,
    dynamic network,
    String? requestThreeDSecure,
  }) =>
      UserCard(
        installments: installments ?? _installments,
        mandateOptions: mandateOptions ?? _mandateOptions,
        network: network ?? _network,
        requestThreeDSecure: requestThreeDSecure ?? _requestThreeDSecure,
      );

  dynamic get installments => _installments;

  dynamic get mandateOptions => _mandateOptions;

  dynamic get network => _network;

  String? get requestThreeDSecure => _requestThreeDSecure;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['installments'] = _installments;
    map['mandate_options'] = _mandateOptions;
    map['network'] = _network;
    map['request_three_d_secure'] = _requestThreeDSecure;
    return map;
  }
}

class NextAction {
  NextAction({
    String? type,
    UseStripeSdk? useStripeSdk,
  }) {
    _type = type;
    _useStripeSdk = useStripeSdk;
  }

  NextAction.fromJson(dynamic json) {
    _type = json['type'];
    _useStripeSdk = json['use_stripe_sdk'] != null
        ? UseStripeSdk.fromJson(json['use_stripe_sdk'])
        : null;
  }

  String? _type;
  UseStripeSdk? _useStripeSdk;

  NextAction copyWith({
    String? type,
    UseStripeSdk? useStripeSdk,
  }) =>
      NextAction(
        type: type ?? _type,
        useStripeSdk: useStripeSdk ?? _useStripeSdk,
      );

  String? get type => _type;

  UseStripeSdk? get useStripeSdk => _useStripeSdk;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_useStripeSdk != null) {
      map['use_stripe_sdk'] = _useStripeSdk?.toJson();
    }
    return map;
  }
}

class UseStripeSdk {
  UseStripeSdk({
    String? source,
    String? stripeJs,
    String? type,
  }) {
    _source = source;
    _stripeJs = stripeJs;
    _type = type;
  }

  UseStripeSdk.fromJson(dynamic json) {
    _source = json['source'];
    _stripeJs = json['stripe_js'];
    _type = json['type'];
  }

  String? _source;
  String? _stripeJs;
  String? _type;

  UseStripeSdk copyWith({
    String? source,
    String? stripeJs,
    String? type,
  }) =>
      UseStripeSdk(
        source: source ?? _source,
        stripeJs: stripeJs ?? _stripeJs,
        type: type ?? _type,
      );

  String? get source => _source;

  String? get stripeJs => _stripeJs;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['source'] = _source;
    map['stripe_js'] = _stripeJs;
    map['type'] = _type;
    return map;
  }
}

class AmountDetails {
  AmountDetails({
    dynamic tip,
  }) {
    _tip = tip;
  }

  AmountDetails.fromJson(dynamic json) {
    _tip = json['tip'];
  }

  dynamic _tip;

  AmountDetails copyWith({
    dynamic tip,
  }) =>
      AmountDetails(
        tip: tip ?? _tip,
      );

  dynamic get tip => _tip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tip'] = _tip;
    return map;
  }
}
