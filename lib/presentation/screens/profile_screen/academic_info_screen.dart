import 'package:flutter/material.dart';

class AcademicInfoScreen extends StatelessWidget {
  const AcademicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Info"),
      ),
      body: Column(
        children: [
          Container(
            child: const Column(
              children: [
                Row(
                  children: [Text(''), Chip(label: Text(''))],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
