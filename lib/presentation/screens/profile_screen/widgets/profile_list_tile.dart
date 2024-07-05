import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final VoidCallback onPressed;
  const ProfileListTile(
      {super.key, required this.title, this.leading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: leading,
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
