import 'package:flutter/services.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:676785540.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3390248160.
class DurationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    newText = newText.replaceAll(RegExp(r'[^0-9h min]'), '');

    newText = newText.replaceAll(RegExp(r'(h|min)\1+'), r'\1');

    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    if (newText.isNotEmpty) {
      if (newText.length == 1 && !newText.endsWith('h')) {
        newText += 'h '; 
      } else if (newText.length >= 2 && newText.length <= 4) {
        String horas = newText.substring(0, newText.indexOf('h')).trim();
        String minutos =
            newText.substring(newText.indexOf('h') + 2).replaceAll('min', '').trim();

        if (minutos.isNotEmpty && !newText.endsWith('min') && newText.length > 3) {
          newText = '$horas h $minutos min';
        } else if (newText.length <= 3 && !newText.endsWith('min')){
            newText = '$horas h ';
        } else if (newText.length <= 5 && newText.endsWith('min')){
            newText = '$horas h $minutos min';
        }
      }
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
