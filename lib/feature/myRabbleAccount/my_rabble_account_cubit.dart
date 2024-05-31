import 'package:rabble/domain/entities/ProfilePictureModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rabble/core/config/export.dart';

class MyRabbleAccountCubit extends RabbleBaseCubit with Validators {
  MyRabbleAccountCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<bool> focus$ = BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  BehaviorSubject<File> selectedImageSubject$ = BehaviorSubject<File>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();

  final BehaviorSubject<String> _nameC = BehaviorSubject<String>.seeded('');

  Function(String) get nameC => _nameC.sink.add;

  Stream<String> get nameStream => _nameC.transform(validateEmpty);

  final BehaviorSubject<String> _surnameC = BehaviorSubject<String>.seeded('');

  Function(String) get surnameC => _surnameC.sink.add;

  Stream<String> get surnameStream => _surnameC.transform(validateEmpty);

  final BehaviorSubject<String> _emailC = BehaviorSubject<String>();

  Function(String) get emailC => _emailC.sink.add;

  Stream<String> get emailStream => _emailC.transform(validateEmail);

  final BehaviorSubject<String> _phoneC = BehaviorSubject<String>();

  Function(String) get phoneC => _phoneC.sink.add;

  Stream<String> get phoneStream => _phoneC.transform(validatePhone);

  Stream<bool> get validUpdateDataField => Rx.combineLatest2(
      nameStream,
      surnameStream,
      (
        String a,
        String b,
      ) =>
          true).onErrorReturn(false);

  Stream<bool> get validUserInfoField => Rx.combineLatest2(
      nameStream,
      surnameStream,
      (
        String a,
        String b,
      ) =>
          true).onErrorReturn(false);

  Future<void> fetchMyData() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    if (userData != null) {
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
      _emailC.sink.add(userModel.email ?? '');
      _phoneC.sink.add(userModel.phone ?? '');
      _nameC.sink.add(userModel.firstName ?? '');
      _surnameC.sink.add(userModel.lastName ?? '');
      nameController.text = userModel.firstName ?? '';
      surNameController.text = userModel.lastName ?? '';
      userDataSubject$.sink.add(userModel);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> changePhoto(BuildContext context) async {
    bool permission = await AskPermission().askPhotoPermission();
    if (permission) {
      XFile? pic = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pic != null) {
        selectedImageSubject$.sink.add(File(pic.path));
      }
    }
  }

  Future<void> updateProfileData() async {
    emit(RabbleBaseState.secondaryBusy());

    Map<String, String> body = {
      pPhone: _phoneC.value,
      pFirstName: _nameC.value,
      pLastName: _surnameC.value,
    };

    late ProfilePictureModel? profileUpdateRes;
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    if (selectedImageSubject$.hasValue) {
      File? file = await selectedImageSubject$.value;
      MultipartFile image =
          await MultipartFile.fromFile(file.path, filename: 'image.jpg');
      FormData formData;
      if (userModel.imageKey != null) {
        formData = FormData.fromMap({
          'userId': userModel.id!,
          'imageKey': userModel.imageKey!,
          'file': image,
        });
      } else {
        formData = FormData.fromMap({
          'userId': userModel.id!,
          'file': image,
        });
      }

      profileUpdateRes = await userRepo.updateProfilePhoto(
          body: formData,
          throwOnError: false,
          errorCallBack: () {
            emit(RabbleBaseState.idle());
          });

      userModel.imageKey = profileUpdateRes!.data!.key;
      userModel.imageUrl = profileUpdateRes.data!.location;
    }

    BaseModel? updateRes = await userRepo.updateProfileData(
        body: body,
        throwOnError: false,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });

    if (updateRes!.status == 200) {
      await RabbleStorage().storeDynamicValue(
          RabbleStorage().userKey, jsonEncode(updateRes.data));
      NavigatorHelper().pop();
    }

    globalBloc.showSuccessSnackBar(message: updateRes.message);

    emit(RabbleBaseState.idle());
  }

  Future<bool> addProfileData(
      String phoneNumber, Map data, BuildContext context) async {
    Map<String, String> body = {
      pPhone: phoneNumber,
      pFirstName: _nameC.value,
      pLastName: _surnameC.value,
    };
    emit(RabbleBaseState.secondaryBusy());
    BaseModel? updateRes =
        await userRepo.updateProfileData(body: body, throwOnError: false);
    if (data['type'] == '1')
      globalBloc.showSuccessSnackBar(message: updateRes!.message);

    if (updateRes!.status == 200) {
      UserModel userData = UserModel.fromJson(updateRes.data);
      await RabbleStorage().storeDynamicValue(
          RabbleStorage().userKey, jsonEncode(userData));
      return true;
    }
    emit(RabbleBaseState.idle());

    return false;
  }

  Future<bool> deleteMyAccount() async {
    emit((RabbleBaseState.tertiaryBusy()));
    var skipNextDeliveryRes = await userRepo.deleteMyAccount(
        throwOnError: true,
        id: userDataSubject$.value.id!,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);

      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  BehaviorSubject<List<NotificationData>> notificationsListSubject$ =
      BehaviorSubject<List<NotificationData>>.seeded([]);

  Future<void> fetchNotifications() async {
    emit(RabbleBaseState.primaryBusy());

    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    NotificationModel? res = await userRepo.fetchMyNotifications(
        userId: userModel.id,
        throwOnError: true,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (res!.statusCode == 200) {
      if (res.data!.isNotEmpty) {
        notificationsListSubject$.sink.add(res.data!);
      }
    }
    emit(RabbleBaseState.idle());
  }
}
