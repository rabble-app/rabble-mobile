import 'package:flutter/services.dart';

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedValue = _formatExpiryDate(newValue.text);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatExpiryDate(String input) {
    input = input.replaceAll('/', ''); // Remove existing slashes
    if (input.length >= 3) {
      input = input.substring(0, 2) + '/' + input.substring(2);
    }
    return input;
  }
}
