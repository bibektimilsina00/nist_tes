import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? backgroudColor;
  final Color? forgroundColor;
  final VoidCallback ontap;
  const PrimaryButton({
    super.key,
    this.backgroudColor,
    this.forgroundColor,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroudColor,
          foregroundColor: forgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: ontap,
      child: Text(
        text,
      ),
    );
  }
}
