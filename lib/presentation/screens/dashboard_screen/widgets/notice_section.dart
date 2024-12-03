import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../widgets/notice_card.dart';
import '../../notice_screen/notice_screen.dart';

class NoticeUpdatesSection extends StatelessWidget {
  const NoticeUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                NoticeCard(
                  notice: noticeList[0],
                ),
                NoticeCard(
                  notice: noticeList[1],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
