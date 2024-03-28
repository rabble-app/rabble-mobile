import 'package:rabble/core/config/export.dart';

class BuyingTeamCreationService {
  static final BuyingTeamCreationService _instance =
      BuyingTeamCreationService._internal();

  BuyingTeamCreationService._internal();

  factory BuyingTeamCreationService() {
    return _instance;
  }

  BehaviorSubject<String> groupNameSubject$ =
      BehaviorSubject<String>.seeded('');


  BehaviorSubject<Map<String,dynamic>> appleDataSubject$ =
  BehaviorSubject<Map<String,dynamic>>();

  BehaviorSubject<Map<String,dynamic>> apiDataSubject$ =
  BehaviorSubject<Map<String,dynamic>>();

  final BehaviorSubject<List<Map<String,dynamic>>> myBasketList =
  BehaviorSubject<List<Map<String,dynamic>>>();

  BehaviorSubject<String> orderIdSubject$ =
  BehaviorSubject<String>.seeded('');

  BehaviorSubject<String> teamIdSubject$ =
  BehaviorSubject<String>.seeded('');



  BehaviorSubject< Map<String,dynamic> > creationDataSubject$ = BehaviorSubject< Map<String,dynamic> >.seeded({});
  BehaviorSubject<bool> isAuthSubject$ = BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<Map<String, dynamic>> payDataSubject$ =
      BehaviorSubject<Map<String, dynamic>>();

  reset() {
    groupNameSubject$ = BehaviorSubject<String>.seeded('');
    creationDataSubject$ = BehaviorSubject< Map<String,dynamic> >.seeded({});
  }

  goBack() {
    reset();
    NavigatorHelper().pop();
  }

  void addPaymentData(String key, dynamic value) {
    Map<String,dynamic> data = payDataSubject$.hasValue ? payDataSubject$.value : {};
    data[key] = value;

    payDataSubject$.sink.add(data);
  }


  void addTeamCreationData(String key, dynamic value) {
    Map<String,dynamic> data = creationDataSubject$.hasValue ? creationDataSubject$.value : {};
    data[key] = value;

    creationDataSubject$.sink.add(data);
  }

}
