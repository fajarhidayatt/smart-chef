import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatefulWidget {
  final String value;
  final bool clearWhenSubmitted;
  final void Function(String) onSubmitted;

  const TextInput({
    super.key, 
    required this.value,
    required this.clearWhenSubmitted,
    required this.onSubmitted,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.value;
    super.initState();
  }

  void handleSubmitted(value){
    widget.onSubmitted(value);
    if(widget.clearWhenSubmitted) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: handleSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: 'Cari resep...',
          hintStyle: GoogleFonts.poppins(color: const Color(0xFFD9D9D9)),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset('assets/vectors/ic_search.svg'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}