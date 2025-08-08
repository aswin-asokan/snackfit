import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightmode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: const Color(0xffEB2933),
    inversePrimary: const Color(0xffF5F0F0),
    onPrimary: const Color(0xffffffff),
    onPrimaryFixedVariant: const Color(0xff000000),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
);
