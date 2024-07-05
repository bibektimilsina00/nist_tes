import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';

class RoutineDay extends StatelessWidget {
  final String day;

  const RoutineDay({super.key, required this.day});

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
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        '6:30 - 7:15',
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
                      child: const Center(
                          child: Text(
                        'TOC',
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
                      child: const Center(
                          child: Text(
                        'Jendi Bade Shrestha',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        '6:30 - 7:15',
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
                      child: const Center(
                          child: Text(
                        'TOC',
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
                      child: const Center(
                          child: Text(
                        'Jendi Bade Shrestha',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        '6:30 - 7:15',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        'TOC',
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
                      child: const Center(
                          child: Text(
                        'Jendi Bade Shrestha',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        '6:30 - 7:15',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        'TOC',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        'Jendi Bade Shrestha',
                        style: AppStyles.cardBodyTitle,
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
