
import 'package:rabble/domain/entities/Owner.dart';

class PartitionedProductUsersRecord {
  PartitionedProductUsersRecord({
    num? amount,
    num? quantity,
    Owner? owner,
  }) {
    _amount = amount;
    _quantity = quantity;
    _owner = owner;
  }

  PartitionedProductUsersRecord.fromJson(dynamic json) {
    _amount = json['amount'];
    if(json['quantity']!=null) {
      _quantity = json['quantity'];
    }
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  num? _amount;
  num? _quantity;
  Owner? _owner;

  PartitionedProductUsersRecord copyWith({
    num? amount,
    num? quantity,
    Owner? owner,
  }) =>
      PartitionedProductUsersRecord(
        amount: amount ?? _amount,
        quantity: quantity ?? _quantity,
        owner: owner ?? _owner,
      );

  num? get amount => _amount;


  num? get quantity => _quantity;

  Owner? get owner => _owner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    return map;
  }
}

