import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextOpenSans extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextOpenSans({
    required this.text,
    required this.fontSize,
    required this.fontWeight,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.openSans(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
