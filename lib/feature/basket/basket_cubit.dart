import 'package:rabble/config/export.dart';

class BasketCubit extends RabbleBaseCubit {
  BasketCubit() : super(RabbleBaseState.idle());
  BehaviorSubject<bool> expanded$ = BehaviorSubject.seeded(true);
}
