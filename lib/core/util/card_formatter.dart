import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    for (int i = 0; i < newTextLength; i++) {
      if (i % 4 == 0 && i > 0) {
        newText.write(' '); // Add a space every 4 characters
        if (selectionIndex > i) {
          selectionIndex++;
        }
      }
      newText.write(newValue.text[usedSubstringIndex]);
      usedSubstringIndex++;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
