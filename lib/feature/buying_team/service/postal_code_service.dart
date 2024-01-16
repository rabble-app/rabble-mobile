import 'package:rabble/config/export.dart';

class PostalCodeService {
  static final PostalCodeService _instance = PostalCodeService._internal();

  PostalCodeService._internal();

  factory PostalCodeService() {
    return _instance;
  }

  final postalCodeGlobalSubject = BehaviorSubject<String>.seeded('');
  final isSheetOpenGlobalSubject = BehaviorSubject<bool>.seeded(false);
  final ispostalCodeChangedGlobalSubject = BehaviorSubject<bool>.seeded(false);

  reset() {
    postalCodeGlobalSubject.drain(null);
    isSheetOpenGlobalSubject.drain(null);
  }

  goBack() {
    reset();
    NavigatorHelper().pop();
  }
}
