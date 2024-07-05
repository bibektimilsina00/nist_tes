import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/presentation/screens/teachers_screen/widgets/teacher_detail_card.dart';

import '../../widgets/appbar/home_appbar.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const HomeAppBar(),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Teachers',
                  style: AppStyles.cardTitle,
                ),
              ],
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return const TeacherDetailCard();
          },
          itemCount: 10,
        ),
      ],
    );
  }
}
