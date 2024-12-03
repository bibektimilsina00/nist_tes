import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/screens/profile_screen/widgets/profile_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Account',
                    [
                      ProfileListTile(
                        title: 'Personal Information',
                        leading: FontAwesome5Regular.user_circle,
                        onPressed: () =>
                            context.push(AppRoutes.userPersonalInfoScreen),
                        color: theme.colorScheme.primary,
                      ),
                      ProfileListTile(
                        title: 'Academic Information',
                        leading: SimpleLineIcons.graduation,
                        onPressed: () =>
                            context.push(AppRoutes.academicInfoScreen),
                        color: theme.colorScheme.tertiary,
                      ),
                    ],
                    theme,
                  ),
                  _buildSection(
                    'Settings',
                    [
                      ProfileListTile(
                        title: 'Account Setting',
                        leading: MaterialCommunityIcons.account_outline,
                        onPressed: () =>
                            context.push(AppRoutes.accountSettingScreen),
                        color: theme.colorScheme.secondary,
                      ),
                      ProfileListTile(
                        title: 'Change Password',
                        leading: Icons.lock_outline,
                        onPressed: () =>
                            context.push(AppRoutes.changePasswordScreen),
                        color: theme.colorScheme.tertiary,
                      ),
                    ],
                    theme,
                  ),
                  _buildSection(
                    'Help',
                    [
                      ProfileListTile(
                        title: 'FAQ',
                        leading: MaterialCommunityIcons.chat_question_outline,
                        onPressed: () => context.push(AppRoutes.faqScreen),
                        color: theme.colorScheme.secondary,
                      ),
                      ProfileListTile(
                        title: 'Logout',
                        leading: Icons.logout,
                        onPressed: () => context.go(AppRoutes.loginScreen),
                        color: theme.colorScheme.error,
                      ),
                    ],
                    theme,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}
