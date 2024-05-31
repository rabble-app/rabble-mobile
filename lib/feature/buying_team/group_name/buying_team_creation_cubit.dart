import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

class BuyingTeamCreateCubit extends RabbleBaseCubit with Validators {
  BuyingTeamCreateCubit() : super(RabbleBaseState.idle());
  final BehaviorSubject<String> _groupName = BehaviorSubject();
  final BehaviorSubject<bool> privateGroupStream = BehaviorSubject<bool>();

  Function(String) get groupNameC => _groupName.sink.add;

  Stream<String> get groupNameStream => _groupName.transform(validateGroupName);

  Stream<bool> get validGroupNameField =>
      Rx.combineLatest([groupNameStream], (p) => true).onErrorReturn(false);

  final BehaviorSubject<String> groupNameSubject$ =
      BehaviorSubject<String>.seeded('');

  final TextEditingController groupController = TextEditingController();

  BehaviorSubject<bool> focus$ = BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<String> _persolizedName = BehaviorSubject();

  Function(String) get persolizedC => _persolizedName.sink.add;

  Stream<String> get persolizedStream =>
      _persolizedName.transform(validateGroupName);

  Stream<bool> get validatePersolizedField =>
      Rx.combineLatest([persolizedStream], (p) => true).onErrorReturn(false);

  //add address

  final BehaviorSubject<String> _postalCode = BehaviorSubject();

  Function(String) get postalCodeC => _postalCode.sink.add;

  Stream<String> get postalCodeStream =>
      _postalCode.transform(validateGroupName).onErrorReturn('');

  final BehaviorSubject<String> _buildingNumberlCode = BehaviorSubject();

  Function(String) get buildingNumberC => _buildingNumberlCode.sink.add;

  Stream<String> get buildingNumberStream =>
      _buildingNumberlCode.transform(validateGroupName).onErrorReturn('');

  final BehaviorSubject<String> _addressLineCode = BehaviorSubject();

  Function(String) get addressLineC => _addressLineCode.sink.add;

  Stream<String> get addressLineStream =>
      _addressLineCode.transform(validateGroupName).onErrorReturn('');

  final BehaviorSubject<String> _cityCode = BehaviorSubject();

  Function(String) get cityC => _cityCode.sink.add;

  Stream<String> get cityStream =>
      _cityCode.transform(validateGroupName).onErrorReturn('');

  Stream<bool> get validAddressesField => Rx.combineLatest4(
      postalCodeStream,
      buildingNumberStream,
      addressLineStream,
      cityStream,
      (
        String a,
        String b,
        String c,
        String d,
      ) =>
          true).onErrorReturn(false);

  TextEditingController postalCodeController = TextEditingController();
  TextEditingController buildingeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  bool isAlreadyAddress = false;

  final BehaviorSubject<AddressData> userAddressSubject$ =
      BehaviorSubject<AddressData>();

  Future<void> addNewAddress() async {
    emit(RabbleBaseState.secondaryBusy());
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    Map<String, String>? body;
    if (isAlreadyAddress) {
      body = {
        mbuildingNo: _buildingNumberlCode.value,
        maddress: _addressLineCode.value,
        mcity: _cityCode.value,
      };
    } else {
      body = {
        pUserId: userModel.id!,
        mbuildingNo: _buildingNumberlCode.value,
        maddress: _addressLineCode.value,
        mcity: _cityCode.value,
      };
    }

    BaseModel? addNewAddressRes = isAlreadyAddress
        ? await userRepo.updateAddress(
            body: body, userId: userModel.id!, throwOnError: true)
        : await userRepo.addNewAddress(
            body: body,
            throwOnError: true,
            errorCallBack: () {
              emit(RabbleBaseState.idle());
            });
    if (addNewAddressRes!.status == 201 || addNewAddressRes.status == 200) {
      NavigatorHelper().navigateTo('/select_payment_method_view');
    }
    emit(RabbleBaseState.idle());
  }

  Future<bool> checkTeamNameExist() async {
    emit(RabbleBaseState.secondaryBusy());

    var res = await userRepo.checkTeamNameExist(
        groupNameSubject$.hasValue ? groupNameSubject$.value : '',
        throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200) {
      if (res.data!) globalBloc.showWarningSnackBar(message: res.message);
    }

    emit(RabbleBaseState.idle());

    return res.data!;
  }

  Future<void> fetchMyAddress() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    CustomerAddress? myAddress = await userRepo.fetchMyAddress(
        userId: userModel.id!,
        throwOnError: true,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (myAddress!.statusCode == 200) {
      if (myAddress.data != null &&
          myAddress.data!.address != null &&
          myAddress.data!.address!.isNotEmpty) {
        isAlreadyAddress = true;
        postalCodeController.text = userModel.postalCode!;

        _postalCode.sink.add(userModel.postalCode!);

        buildingeController.text = myAddress.data!.buildingNo!;

        _buildingNumberlCode.sink.add(myAddress.data!.buildingNo!);

        // addressController.text = myAddress.data!.address!;
        //
        // _addressLineCode.sink.add(myAddress.data!.address!);
        //
        // cityController.text = myAddress.data!.city!;
        //
        // _cityCode.sink.add(myAddress.data!.city!);
        showNearBy.sink.add(false);
      } else {
        List<String>? nearByAddress = await userRepo
            .fetchNearBY(userModel.postalCode!, errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
        if (nearByAddress.isNotEmpty) {
          nearByLcoationListSubject$.sink.add(nearByAddress);
          postalCodeController.text = userModel.postalCode!;
          _postalCode.sink.add(userModel.postalCode!);
          showNearBy.sink.add(true);
        }
      }
    }

    emit(RabbleBaseState.idle());
  }

  BehaviorSubject<List<String>> nearByLcoationListSubject$ =
      BehaviorSubject<List<String>>();

  BehaviorSubject<bool> showNearBy = BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<String> numberSubject$ =
      BehaviorSubject<String>.seeded('Select Your Address');

  BehaviorSubject<int> isExpandedSubject$ = BehaviorSubject<int>.seeded(0);

  void onSelectAddress(String val) {
    List<String> data = val.trim().split(',');

    _buildingNumberlCode.sink.add(data[1].trim().isEmpty ? '' : data.first);
    buildingeController.text = data[1].trim().isEmpty ? '' : data.first;

    _addressLineCode.sink.add(data[1].trim().isEmpty ? data.first : data[1]);
    addressController.text = data[1].trim().isEmpty ? data.first : data[1];

    _cityCode.sink.add(data[5]);
    cityController.text = data[5];
  }

  Future<bool> updateTeamData(String teamId, Map<String, dynamic> body) async {
    emit((RabbleBaseState.secondaryBusy()));

    var addTeamRes = await userRepo.updateTeamData(teamId,
        throwOnError: true, body: body, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (addTeamRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      emit((RabbleBaseState.idle()));
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  Future<void> quiteTeam(String id) async {
    emit((RabbleBaseState.tertiaryBusy()));
    var skipNextDeliveryRes = await userRepo.quiteTeam(
        throwOnError: true,
        id: id,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
      NavigatorHelper().navigateAnClearAll('/home');
    }
    emit((RabbleBaseState.idle()));
  }

  Future<void> nudgeTeam(String teamId) async {
    emit((RabbleBaseState.secondaryBusy()));
    var skipNextDeliveryRes = await userRepo.nudgeTeam(
        throwOnError: true,
        teamId: teamId,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
    }
    emit((RabbleBaseState.idle()));
  }

  Future<void> searchAddress(String val) async {
    emit((RabbleBaseState.tertiaryBusy()));
    List<String>? nearByAddress =
        await userRepo.fetchNearBY(val, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (nearByAddress.isNotEmpty) {
      nearByLcoationListSubject$.sink.add(nearByAddress);
      showNearBy.sink.add(true);
    } else {
      nearByLcoationListSubject$.sink.add([]);
      showNearBy.sink.add(false);
    }
    emit((RabbleBaseState.idle()));
  }

  String singleComma(String str) {
    String result = str
        .split(',')
        .map((element) => element.trim()) // Trim whitespace from each element
        .where((element) => element.isNotEmpty) // Remove empty entries
        .join(',');

    print(result);
    return result;
  }

  getHintPersonalization(String? producerName, int? frequency) {
    int value = DateFormatUtil().epochToTotalWeeks(frequency!);

    String result = 'We buy direct from $producerName ';

    if (value == 1) {
      result += 'weekly';
    } else if (value >= 4) {
      int months =
          value ~/ 4; // Integer division to get the number of full months.
      int remainingWeeks =
          value % 4; // Remaining weeks after extracting full months.

      if (months > 0) {
        result += (months == 1)
            ? '${remainingWeeks > 0 ? '$months month' : ' monthly'}'
            : 'every $months months';
      }

      if (remainingWeeks > 0) {
        if (months > 0) {
          result += ' and ';
        }
        result += '$remainingWeeks week${remainingWeeks > 1 ? 's' : ''}';
      }
    } else {
      result += 'every $value weeks';
    }

    return result += '. Send me a message and join the team';
  }

  setData(String? name) {
    if (name!.isNotEmpty) {
      groupController.text = name;
      groupNameSubject$.sink.add(name);
    }
  }
}
