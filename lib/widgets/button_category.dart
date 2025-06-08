import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCategory extends StatefulWidget {
  final String title;
  final bool active;
  final void Function() onPressed;

  const ButtonCategory({
    super.key,
    required this.title,
    required this.active,
    required this.onPressed,
  });

  @override
  State<ButtonCategory> createState() => _ButtonCategoryState();
}

class _ButtonCategoryState extends State<ButtonCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
          backgroundColor: widget.active
              ? const Color(0xFF129575)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: widget.active ? Colors.white : const Color(0xFF71B1A1),
          ),
        ),
      ),
    );
  }
}
