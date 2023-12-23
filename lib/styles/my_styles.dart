import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  static TextTheme myTextTheme = TextTheme(
      displayLarge: GoogleFonts.poppins(
          fontSize: 51, fontWeight: FontWeight.w500, letterSpacing: -1.5),
      displayMedium: GoogleFonts.poppins(
          fontSize: 45, fontWeight: FontWeight.w500, letterSpacing: -0.5),
      displaySmall:
          GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w500),
      headlineMedium: GoogleFonts.poppins(
          fontSize: 29, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall:
          GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
      titleLarge: GoogleFonts.poppins(
          fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: GoogleFonts.poppins(
          fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelLarge: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      labelSmall: GoogleFonts.poppins(
          fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5));

  static Color primaryColor = const Color(0xFF66C34F);
}
