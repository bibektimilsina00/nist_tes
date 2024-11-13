import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/config/size_config.dart';

class ShimmerTeacherCard extends StatelessWidget {
  const ShimmerTeacherCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.5,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          contentPadding: const EdgeInsets.all(4),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 24,
          ),
          title: Container(
            height: 10,
            color: Colors.grey[300],
          ),
          subtitle: Container(
            height: 10,
            color: Colors.grey[300],
            margin: const EdgeInsets.only(top: 4),
          ),
        ),
      ),
    );
  }
}
