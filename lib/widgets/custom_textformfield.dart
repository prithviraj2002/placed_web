import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app-ui/placed_colors.dart';

class CustomTextFieldForm extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  void Function(String) ontap;

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();

  CustomTextFieldForm({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.ontap,
  });
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.ontap,
      style: GoogleFonts.poppins(
        color: PlacedColors.PrimaryBlack,
        fontSize: 12,
        letterSpacing: 1.2,
      ),
      decoration: InputDecoration(
        fillColor: PlacedColors.PrimaryWhiteDark.withOpacity(0.5),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.all(12.0),
        hintText: widget.hintText,
        hintStyle:
            GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey4),
        errorStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
            letterSpacing: 0.8),
      ),
      keyboardType: widget.textInputType,
    );
  }
}
