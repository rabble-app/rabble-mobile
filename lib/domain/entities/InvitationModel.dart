import 'package:rabble/domain/entities/ProducerModel.dart';

import 'UserTeamModel.dart';

class InvitationModel {
  InvitationModel({
    num? statusCode,
    String? message,
    InvitationData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  InvitationModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? InvitationData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  InvitationData? _data;

  InvitationModel copyWith({
    num? statusCode,
    String? message,
    InvitationData? data,
  }) =>
      InvitationModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  InvitationData? get data => _data;

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

class InvitationData {
  InvitationData({
    String? phone,
    String? teamId,
    String? teamName,
    Producer? producerInfo,
  }) {
    _phone = phone;
    _teamId = teamId;
    _teamName = teamName;
    _producerInfo = producerInfo;
  }

  InvitationData.fromJson(dynamic json) {
    _phone = json['phone'];
    _teamId = json['teamId'];
    _teamName = json['teamName'];
    _producerInfo = json['producerInfo'] != null
        ? Producer.fromJson(json['producerInfo'])
        : null;
  }

  String? _phone;
  String? _teamId;
  String? _teamName;
  Producer? _producerInfo;

  InvitationData copyWith({
    String? phone,
    String? teamId,
    String? teamName,
    Producer? producerInfo,
  }) =>
      InvitationData(
        phone: phone ?? _phone,
        teamId: teamId ?? _teamId,
        teamName: teamName ?? _teamName,
        producerInfo: producerInfo ?? _producerInfo,
      );

  String? get phone => _phone;

  String? get teamId => _teamId;

  String? get teamName => _teamName;

  Producer? get producerInfo => _producerInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['teamId'] = _teamId;
    map['teamName'] = _teamName;
    if (_producerInfo != null) {
      map['producerInfo'] = _producerInfo?.toJson();
    }
    return map;
  }
}

