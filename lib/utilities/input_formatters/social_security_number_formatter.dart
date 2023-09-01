import 'package:flutter/services.dart';

class SocialSecurityNumberFormatter extends TextInputFormatter {
  static const int maxLength =
      9; // Social security numbers are 9 digits + 2 dashes

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric characters from the new value
    String sanitizedValue = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // If the sanitized value is longer than the max length, truncate it
    if (sanitizedValue.length > maxLength) {
      sanitizedValue = sanitizedValue.substring(0, maxLength);
    }

    // Add dashes to the sanitized value at the appropriate positions
    String formattedValue = '';
    for (int i = 0; i < sanitizedValue.length; i++) {
      if (i == 3 || i == 5) {
        formattedValue += '-';
      }
      formattedValue += sanitizedValue[i];
    }

    // If the new value is the same as the formatted value, no need to update the text editing value
    if (newValue.text == formattedValue) {
      return newValue;
    }

    // Otherwise, create and return a new text editing value with the formatted value
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
