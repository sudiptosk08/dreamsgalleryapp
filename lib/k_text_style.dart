import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
Focus: To maintain app wide design consistency all
the text style that are used in this app should be
declared here.

*Note: In special case: When let's say one title
text or textButton theme needsto be different,
say the color needs to be red instead of Black.
Don't create titleStyle1 (-_-). Just follow this:
Code Snippet:  (Applicable for all styles)
Text(segmentTitle,
style: AppTextStyle.titleStyle.copyWith(color: KColor.red)),
*/

class KTextStyle {
  static TextStyle headline1 = GoogleFonts.rubik(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle headline2 = GoogleFonts.inter(
      fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 0.15);

  static TextStyle headline3 = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.2);

  static TextStyle headline4 = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.25);

  static TextStyle headline5 = GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.3);

  static TextStyle headline6 = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle subtitle1 = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle subtitle2 = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle subtitle3 = GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle subtitle4 = GoogleFonts.inter(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle drawer = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  static TextStyle bodyText1 = GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle bodyText2 = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle bodyText3 = GoogleFonts.inter(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle bodyText4 = GoogleFonts.inter(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle buttonText1 = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle buttonText2 = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle buttonText3 = GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle buttonText4 = GoogleFonts.inter(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.2);

  static TextStyle caption = GoogleFonts.inter(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.2);

  static TextStyle overline = GoogleFonts.inter(
      fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.5);
}
