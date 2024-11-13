import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/core/notifiers/routine_notifier.dart';
import 'package:nist_tes/core/notifiers/subject_notifier.dart';
import 'package:nist_tes/presentation/screens/class_routine_screen/routine_card.dart';
import 'package:nist_tes/presentation/widgets/appbar/home_appbar.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/shimmers/routine_day_shimmer.dart';

class ClassRoutineScreen extends StatelessWidget {
  const ClassRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeAppBar(),
        SliverToBoxAdapter(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: AppColors.iconBackground, shape: BoxShape.circle),
                child: const Icon(Icons.book_outlined,
                    color: AppColors.primaryColor, size: 20),
              ),
              hSizedBox1,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Subjects with codes",
                      style: AppStyles.cardTitle,
                    ),
                  ),
                  Consumer<SubjectNotifier>(
                    builder: (context, notifier, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...notifier.subjectList.map(
                            (subject) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                "${subject.name} - (${subject.subjectCode})",
                                style: AppStyles.bodyMediumDark,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        )),
        Consumer<RoutineNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading.value) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ShimmerRoutineDay(),
                  childCount: 5,
                ),
              );
            } else if (notifier.routineList.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('No routines available'),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return RoutineDay(
                      day: notifier.routineList[index].name.toUpperCase(),
                      routineList: notifier.routineList[index].routineDetails,
                    );
                  },
                  childCount: notifier.routineList.length,
                ),
              );
            }
          },
        )
      ],
    );
  }
}
