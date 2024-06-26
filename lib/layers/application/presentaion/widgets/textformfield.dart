import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool readOnly;
  final TextEditingController controller;
  final TextStyle? hintstyle;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType type;
  final TextStyle? style;
  final int maxlines;
  final ValueChanged<String>? onChanged; 
  final bool showError;// New onChanged callback

  const CustomTextFormField({
    Key? key,
    this.hintstyle,
    this.errorStyle,
    this.readOnly = false,
    this.style,
    required this.controller,
    this.maxlines = 1,
    this.type = TextInputType.text,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged, 
    this.showError = false// Added onChanged
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      style: TextStyle(color: Colors.white),
      maxLines: widget.maxlines,
      keyboardType: widget.type,
      controller: widget.controller,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        hintStyle: TextStyle(color: Colors.white),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
      ),
      obscureText: widget.obscureText && _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,);
  }
}
