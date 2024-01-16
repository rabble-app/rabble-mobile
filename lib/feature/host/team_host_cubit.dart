import 'package:rabble/config/export.dart';

class TeamHostCubit extends RabbleBaseCubit {
  TeamHostCubit() : super(RabbleBaseState.idle());
  BehaviorSubject<bool> expanded$ = BehaviorSubject.seeded(true);
}
