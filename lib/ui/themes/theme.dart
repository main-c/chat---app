import 'package:chat_app/ui/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final customTheme = AppTheme.dark();

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: CustomColors.black,
      backgroundColor: CustomColors.black,
      scaffoldBackgroundColor: CustomColors.black,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }
}
