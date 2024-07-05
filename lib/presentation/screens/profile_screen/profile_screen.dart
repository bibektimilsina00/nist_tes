import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                    leading: const Icon(
                      Icons.person_outline,
                    ),
                    onPressed: () {},
                  ),
                  ProfileListTile(
                    title: 'Academic Information',
                    leading: const Icon(Icons.school_outlined),
                    onPressed: () {},
                  ),
                  ProfileListTile(
                    title: 'Account Setting',
                    leading: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                  ),
                  ProfileListTile(
                    title: 'Change Password',
                    leading: const Icon(Icons.lock_outline),
                    onPressed: () {},
                  ),
                  ProfileListTile(
                    title: 'FAQ',
                    leading: const Icon(Icons.question_answer_outlined),
                    onPressed: () {},
                  ),
                  ProfileListTile(
                    title: 'Logout',
                    leading: const Icon(Icons.logout),
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
