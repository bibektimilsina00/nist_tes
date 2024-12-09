import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/screens/profile_screen/widgets/profile_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/auth/auth_notifier.dart';

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
                        onPressed: () =>
                            _showLogoutConfirmation(context, theme),
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

  void _showLogoutConfirmation(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                color: theme.colorScheme.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Logout',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to logout?',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<AuthenticationNotifier>().logout();
                        context.go(AppRoutes.collegeWallScreen);
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: theme.colorScheme.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
