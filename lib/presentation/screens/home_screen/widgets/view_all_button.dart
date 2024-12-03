import 'package:flutter/material.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';

class ViewAllButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  const ViewAllButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            text ?? 'View All',
          ),
          hSizedBox1,
          const Icon(
            Icons.remove_red_eye_outlined,
          ),
        ],
      ),
    );
  }
}
