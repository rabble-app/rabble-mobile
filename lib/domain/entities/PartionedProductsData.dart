import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/PartitionedProductUsersRecordModel.dart';

class PartionedProducts {
  PartionedProducts({
    num? threshold,
    ProductDetail? product,
    num? accumulator,
    String? id,
    List<PartitionedProductUsersRecord>? partitionedProductUsersRecord,
  }) {
    _threshold = threshold;
    _accumulator = accumulator;
    _id = id;
    _product = product;
    _partitionedProductUsersRecord = partitionedProductUsersRecord;
  }

  PartionedProducts.fromJson(dynamic json) {
    _threshold = json['threshold'];
    _accumulator = json['accumulator'];
    if (json['id'] != null) {
      _id = json['id'];
    }
    if (json['product'] != null) {
      _product = json['product'] != null
          ? ProductDetail.fromJson(json['product'])
          : null;
    }
    if (json['PartitionedProductUsersRecord'] != null) {
      _partitionedProductUsersRecord = [];
      json['PartitionedProductUsersRecord'].forEach((v) {
        _partitionedProductUsersRecord
            ?.add(PartitionedProductUsersRecord.fromJson(v));
      });
    }
  }

  num? _threshold;
  String? _id;
  num? _accumulator;
  ProductDetail? _product;
  List<PartitionedProductUsersRecord>? _partitionedProductUsersRecord;

  PartionedProducts copyWith({
    num? threshold,
    num? accumulator,
    String? id,
    ProductDetail? product,
    List<PartitionedProductUsersRecord>? partitionedProductUsersRecord,
  }) =>
      PartionedProducts(
        threshold: threshold ?? _threshold,
        accumulator: accumulator ?? _accumulator,
        product: product ?? _product,
        id: id ?? _id,
        partitionedProductUsersRecord:
            partitionedProductUsersRecord ?? _partitionedProductUsersRecord,
      );

  num? get threshold => _threshold;

  String? get id => _id;

  num? get accumulator => _accumulator;


  set accumulator(num? value) {
    _accumulator = value;
  }

  ProductDetail? get product => _product;

  List<PartitionedProductUsersRecord>? get partitionedProductUsersRecord =>
      _partitionedProductUsersRecord;

  set partitionedProductUsersRecord(
      List<PartitionedProductUsersRecord>? value) {
    _partitionedProductUsersRecord = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['threshold'] = _threshold;
    map['accumulator'] = _accumulator;
    return map;
  }
}
