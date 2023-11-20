import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField01 extends StatefulWidget {
  const CustomTextField01({
    super.key,
    required this.controller,
    required this.labelText,
    this.labelTextSize,
    this.textInputType,
    this.obscureText,
  });

  final TextEditingController controller;
  final String labelText;
  final double? labelTextSize;
  final TextInputType? textInputType;
  final bool? obscureText;

  @override
  State<CustomTextField01> createState() => _CustomTextField01State();
}

class _CustomTextField01State extends State<CustomTextField01> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
          ),
        ),
        labelText: widget.labelText,
        labelStyle: GoogleFonts.merriweather(color: Colors.black87),
        suffix: const Icon(
          Icons.visibility,
          color: Colors.amber,
        ),
      ),
      cursorColor: Colors.black87,
      obscureText: widget.obscureText ?? false,
      onTapOutside: (event) {},
      textCapitalization: TextCapitalization.sentences,
      keyboardType: widget.textInputType,
    );
  }
}

// ! ------------------------------------------------

class CustomTextField02 extends StatefulWidget {
  const CustomTextField02({
    super.key,
    required this.controller,
    required this.labelText,
    this.labelTextSize,
    this.textInputType,
    this.obscureText,
    this.widget,
    this.maxLines = 1,
    this.onChanged,
    this.textCapitalization,
  });
  final TextEditingController controller;
  final String labelText;
  final double? labelTextSize;
  final TextInputType? textInputType;
  final bool? obscureText;
  final Widget? widget;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextCapitalization? textCapitalization;

  @override
  State<CustomTextField02> createState() => _CustomTextField02State();
}

class _CustomTextField02State extends State<CustomTextField02> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: const Color(0xffFBFBFD),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffEE3A57),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffEE3A57),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffEE3A57),
          ),
        ),
        hintText: widget.labelText,
        hintStyle: GoogleFonts.merriweather(
          // color: const Color(0xffFBFBFD),
          color: Colors.grey.shade600,
        ),
        suffixIcon: widget.widget,
      ),
      maxLines: widget.maxLines,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.textInputType,
      onTapOutside: (event) {},
      onChanged: widget.onChanged,
      style: GoogleFonts.merriweather(
        color: const Color(0xffFBFBFD),
      ),
      textCapitalization:
          widget.textCapitalization ?? TextCapitalization.sentences,
    );
  }
}
