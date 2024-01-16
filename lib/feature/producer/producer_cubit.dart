import 'package:rabble/config/export.dart';

class ProducerCubit extends RabbleBaseCubit {
  ProducerCubit() : super(RabbleBaseState.idle()) {

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (!isEmpty) {
            offset = offset + 10;
            fetchProducerList();
          }
        }
      }
    });
  }

  ScrollController scrollController = ScrollController();
  int offset = 0;
  bool isEmpty = false;

  BehaviorSubject<List<ProducerDetail>> producerListSubject$ =
      BehaviorSubject<List<ProducerDetail>>();

  Future<void> fetchProducerList() async {
    if (offset == 0) {
      emit(RabbleBaseState.secondaryBusy());
    } else {
      emit(RabbleBaseState.tertiaryBusy());
    }
    var producerRes = await producerRepo.fetchProducerList(offset,errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (producerRes!.statusCode == 200) {
      List<ProducerDetail> tempList =
          producerListSubject$.hasValue ? producerListSubject$.value : [];

      if (producerRes.data!.isEmpty) {
        isEmpty = true;
      } else {
        tempList.addAll(producerRes.data!);
        producerListSubject$.sink.add(tempList);
      }
    }
    emit(RabbleBaseState.idle());
  }
}
