import 'package:flutter/material.dart';

import '../../../app/const/app_colors.dart';

class PrimaryTextField extends StatefulWidget {
  final String? hintText;
  final bool isObscure;
  final Color? fill;
  final bool isBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? trailing;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  const PrimaryTextField(
      {super.key,
      this.hintText,
      this.isObscure = false,
      this.trailing,
      this.fill,
      this.isBorder = true,
      this.contentPadding,
      this.controller,
      this.validator,
      this.onChanged,
      this.onEditingComplete});

  @override
  PrimaryTextFieldState createState() => PrimaryTextFieldState();
}

class PrimaryTextFieldState extends State<PrimaryTextField> {
  late bool _isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: widget.isBorder
                  ? AppColors.inputBorderDark
                  : Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: widget.isBorder
                  ? AppColors.inputBorderDark
                  : Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.inputBorderDark),
        ),
        filled: true,
        fillColor: widget.fill ?? Colors.white,
        suffixIcon: widget.isObscure
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              )
            : widget.trailing,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscure;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}
