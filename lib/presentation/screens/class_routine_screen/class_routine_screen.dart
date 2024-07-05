import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/presentation/screens/class_routine_screen/routine_card.dart';
import 'package:nist_tes/presentation/widgets/appbar/home_appbar.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';

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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Subjects with codes",
                      style: AppStyles.cardTitle,
                    ),
                  ),
                  vSizedBox1,
                  Text(
                    "TOC - Theory of computaion CSC(201)",
                    style: AppStyles.bodyMediumDark,
                  ),
                  vSizedBox1,
                  Text(
                    "AI - Artificial Intellegence CSC(202)",
                    style: AppStyles.bodyMediumDark,
                  ),
                  vSizedBox1,
                  Text(
                    "DBMS - Database Management System  CSC(112)",
                    style: AppStyles.bodyMediumDark,
                  ),
                  vSizedBox1,
                  Text(
                    "OS - Operating System  CSC(112)",
                    style: AppStyles.bodyMediumDark,
                  ),
                  vSizedBox1,
                  Text(
                    "CN - Computer Network  CSC(114)",
                    style: AppStyles.bodyMediumDark,
                  ),
                ],
              ),
            ],
          ),
        )),
        SliverList.builder(
            itemBuilder: (context, index) {
              return const RoutineDay(
                day: "Sunday",
              );
            },
            itemCount: 10)
      ],
    );
  }
}
