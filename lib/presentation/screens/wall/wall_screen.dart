import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/const/app_assets.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';

class WallScreen extends StatelessWidget {
  const WallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(AppAssets.collegeLogo)),
        title: const Text('College Wall', style: AppStyles.cardTitle),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.secondaryColor),
                onPressed: () {
                  context.go(AppRoutes.loginScreen);
                },
                child: const Text(
                  "Login",
                  style: AppStyles.appBarTitle,
                )),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          CollegeWallSection(),
          vSizedBox1,
          CollegeWallSection(),
          vSizedBox1,
          CollegeWallSection(),
        ],
      ),
    );
  }
}
