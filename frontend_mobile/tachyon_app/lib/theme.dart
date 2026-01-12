import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tachyon_core/tachyon_core.dart';

class TachyonTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    final silver = Color(TachyonColors.lanteanSilver);
    final blue = Color(TachyonColors.atlantisBlue);
    final horizon = Color(TachyonColors.eventHorizon);

    return base.copyWith(
      scaffoldBackgroundColor: horizon,
      primaryColor: blue,
      colorScheme: base.colorScheme.copyWith(
        primary: blue,
        secondary: blue,
        surface: horizon,
        onPrimary: Colors.black,
        onSurface: silver,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.michroma(
          textStyle: base.textTheme.displayLarge?.copyWith(color: silver),
        ),
        displayMedium: GoogleFonts.michroma(
          textStyle: base.textTheme.displayMedium?.copyWith(color: silver),
        ),
        displaySmall: GoogleFonts.michroma(
          textStyle: base.textTheme.displaySmall?.copyWith(color: silver),
        ),
        headlineMedium: GoogleFonts.michroma(
          textStyle: base.textTheme.headlineMedium?.copyWith(color: silver),
        ),
        titleLarge: GoogleFonts.michroma(
          textStyle: base.textTheme.titleLarge?.copyWith(color: silver),
        ),
        bodyLarge: GoogleFonts.inter(
          textStyle: base.textTheme.bodyLarge?.copyWith(color: silver),
        ),
        bodyMedium: GoogleFonts.inter(
          textStyle: base.textTheme.bodyMedium?.copyWith(
            color: silver.withOpacity(0.8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: silver.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: silver.withOpacity(0.2)),
        ),
        labelStyle: TextStyle(color: silver.withOpacity(0.7)),
        hintStyle: TextStyle(color: silver.withOpacity(0.3)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: Colors.black,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
