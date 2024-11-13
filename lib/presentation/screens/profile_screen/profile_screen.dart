import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/screens/profile_screen/widgets/profile_list_tile.dart';

import '../../widgets/appbar/home_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const HomeAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileListTile(
                    title: 'Personal Information',
                    leading: FontAwesome5Regular.user_circle,
                    onPressed: () {
                      context.push(AppRoutes.userPersonalInfoScreen);
                    },
                    color: Colors.green,
                  ),
                  ProfileListTile(
                    title: 'Academic Information',
                    leading: SimpleLineIcons.graduation,
                    onPressed: () {
                      context.push(AppRoutes.academicInfoScreen);
                    },
                    color: AppColors.primaryColor,
                  ),
                  ProfileListTile(
                    title: 'Account Setting',
                    leading: MaterialCommunityIcons.account_outline,
                    onPressed: () {
                      context.push(AppRoutes.accountSettingScreen);
                    },
                    color: Colors.purple,
                  ),
                  ProfileListTile(
                    color: Colors.orange,
                    title: 'Change Password',
                    leading: Icons.lock,
                    onPressed: () {
                      context.push(AppRoutes.changePasswordScreen);
                    },
                  ),
                  ProfileListTile(
                    color: AppColors.primaryColor,
                    title: 'FAQ',
                    leading: MaterialCommunityIcons.chat_question_outline,
                    onPressed: () {
                      context.push(AppRoutes.faqScreen);
                    },
                  ),
                  ProfileListTile(
                    color: Colors.red,
                    title: 'Logout',
                    leading: Icons.logout,
                    onPressed: () {
                      context.go(AppRoutes.loginScreen);
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
