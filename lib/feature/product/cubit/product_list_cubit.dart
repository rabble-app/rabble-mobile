import 'package:rabble/config/export.dart';

class ProductListCubit extends RabbleBaseCubit {
  ProductListCubit(this.id) : super(RabbleBaseState.idle()) {
    fetchProductList(id);
  }

  final String id;
  final BehaviorSubject<List<ProductDetail>> productListSubject$ =
      BehaviorSubject<List<ProductDetail>>();

  Future<void> fetchProductList(String id) async {
    emit(RabbleBaseState.primaryBusy());
    var res = await producerRepo.fetchProducerProductList(id,errorCallBack: (){
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200 && res.data !=null) {
//      productListSubject$.sink.add(res.data!);
    }
    emit(RabbleBaseState.idle());
  }
}
