import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';

import '../../../core/model/routine_model.dart';

class RoutineDay extends StatelessWidget {
  final String day;
  final List<RoutineDetailModel> routineList;

  const RoutineDay({super.key, required this.day, required this.routineList});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(
          day,
          style: AppStyles.cardTitle,
        ),
        leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: AppColors.secondaryColor, shape: BoxShape.circle),
            child: const Icon(Icons.calendar_today,
                color: AppColors.primaryColor)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Duration',
                            style:
                                AppStyles.cardBodyTitle.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(Icons.book_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Subject',
                            style:
                                AppStyles.cardBodyTitle.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                          'Teacher',
                          style: AppStyles.cardBodyTitle.copyWith(fontSize: 12),
                        )),
                      ],
                    ),
                  ),
                ]),
                ...routineList.map(
                  (routine) => TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          '${formatTime(routine.startTime)} - ${formatTime(routine.endTime)}',
                          style: AppStyles.cardBodyTitle,
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          routine.subject.subjectCode,
                          style: AppStyles.cardBodyTitle,
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          routine.subject.teacher?.user.name ?? "N/A",
                          style: AppStyles.cardBodyTitle,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String time) {
    final parsedTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('HH:mm').format(parsedTime);
  }
}
