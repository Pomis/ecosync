import 'dart:ui';

const Color _primaryColor = Color(0xFF7aad85);
const Color _secondaryColor = Color(0xFFF4FBF5);
const Color _accentColor = Color.fromARGB(255, 151, 244, 97);

const Color primaryWarningColor = Color(0xFFff5500);
const Color secondaryWarningColor = Color(0xFFFBF6F4);
const Color accentWarningColor = Color(0xFFD61200);

class ColorStore {
  static bool isGreenColorScheme = true;

  static Color get primaryColor =>
      isGreenColorScheme ? _primaryColor : primaryWarningColor;

  static Color get secondaryColor =>
      isGreenColorScheme ? _secondaryColor : secondaryWarningColor;

  static Color get accentColor =>
      isGreenColorScheme ? _accentColor : accentWarningColor;
}
