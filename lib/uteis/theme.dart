import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundColor = Color(0xfff4f7ff);
const Color corCnza   = Color(0xFFC4C4C4);
const Color corCnza1  = Color(0xFFE7ECEF);

InputDecoration inputDecoration({
  String? hintText,
  EdgeInsets? contentPadding,
  BoxConstraints? constraints,
  bool isDropDown = false
}){
  return InputDecoration(
    hintText: hintText,
    contentPadding: contentPadding ?? (isDropDown ? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17.5) : null),
    constraints: constraints,
    labelStyle: GoogleFonts.inter(
        fontSize: 17.0,
        color: Colors.black,
        fontWeight: FontWeight.w400
    ),
    errorStyle: GoogleFonts.inter(
        color: Colors.red
    ),
    hintStyle: GoogleFonts.inter(
        fontSize: 17.0,
        color: Colors.black54,
        fontWeight: FontWeight.w400
    ),
    filled: true,
    fillColor: Colors.white,
    suffixIconColor: Colors.black,
    counterStyle: const TextStyle(fontSize: 0.01, color: Colors.transparent),
    border: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: corCnza1),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: corCnza1),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: corCnza1, width: 3.0),
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: corCnza),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
  );
}