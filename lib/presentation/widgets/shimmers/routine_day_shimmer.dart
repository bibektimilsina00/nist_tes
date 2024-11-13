import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';

class ShimmerRoutineDay extends StatelessWidget {
  const ShimmerRoutineDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 20,
            color: Colors.grey[300],
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
          ),
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
                    shimmerTableCell(),
                    shimmerTableCell(),
                    shimmerTableCell(),
                  ]),
                  shimmerTableRow(),
                  shimmerTableRow(),
                  shimmerTableRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerTableCell() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '',
          style: AppStyles.cardBodyTitle,
        ),
      ),
    );
  }

  TableRow shimmerTableRow() {
    return TableRow(
      children: [
        shimmerTableCell(),
        shimmerTableCell(),
        shimmerTableCell(),
      ],
    );
  }
}
