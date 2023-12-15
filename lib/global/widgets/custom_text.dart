import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText01 extends StatefulWidget {
  const CustomText01({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.letterSpacing,
    this.maxLines,
    this.overflow,
    this.textDecoration,
    this.textAlign,
  });

  final String text;
  final double? fontSize, letterSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  @override
  State<CustomText01> createState() => _CustomText01State();
}

class _CustomText01State extends State<CustomText01> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.merriweather(
        fontSize: widget.fontSize,
        color: widget.color ?? Colors.black87,
        fontWeight: widget.fontWeight,
        letterSpacing: widget.letterSpacing,
        decoration: widget.textDecoration,
      ),
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}
