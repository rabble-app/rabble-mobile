import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

class CustomDropDownCubit extends RabbleBaseCubit with Validators {
  CustomDropDownCubit() : super(RabbleBaseState.idle());

  String singleComma(String str) {
    String result = str.split(',')
        .map((element) => element.trim())  // Trim whitespace from each element
        .where((element) => element.isNotEmpty)  // Remove empty entries
        .join(',');

    print(result);
    return result;
  }

}
