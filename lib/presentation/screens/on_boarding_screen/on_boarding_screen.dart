import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/const/app_assets.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/widgets/buttons/primary_button.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              AppAssets.collegeLogo,
              height: 50,
            ),

            Image.asset(AppAssets.onboardGirl),

            //rich text with space between
            RichText(
              text: const TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'NIST College',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 270,
              child: Text(
                'TeachTrack simplifies teacher evaluations at NIST College, providing swift, actionable insights to improve teaching standards and student engagement ',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimaryButton(
                    text: "Get Started",
                    ontap: () {
                      context.go(AppRoutes.loginScreen);
                    }),
                PrimaryButton(
                    backgroudColor: AppColors.accentColor,
                    text: 'View Wall',
                    ontap: () {
                      context.go(AppRoutes.wallScreen);
                    })
              ],
            ),
          ],
        ));
  }
}
