import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../app/enum/enum.dart';
import '../../../core/notifiers/theme/theme_notifier.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  final bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Settings",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.5),
                            theme.colorScheme.primary.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/250?image=9',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'john.doe@email.com',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSettingsSection(
                    title: 'Account',
                    children: [
                      _buildSettingTile(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: () {
                          context.push(AppRoutes.editProfileScreen);
                        },
                        theme: theme,
                      ),
                      _buildSettingTile(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        onTap: () {
                          context.push(AppRoutes.changePasswordScreen);
                        },
                        theme: theme,
                      ),
                    ],
                    theme: theme,
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsSection(
                    title: 'Notifications',
                    children: [
                      _buildSwitchTile(
                        icon: Icons.notifications_outlined,
                        title: 'Push Notifications',
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                        },
                        theme: theme,
                      ),
                      _buildSwitchTile(
                        icon: Icons.email_outlined,
                        title: 'Email Notifications',
                        value: _emailNotifications,
                        onChanged: (value) {
                          setState(() => _emailNotifications = value);
                        },
                        theme: theme,
                      ),
                    ],
                    theme: theme,
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsSection(
                    title: 'Appearance',
                    children: [
                      Consumer<ThemeNotifier>(
                        builder: (context, themeNotifier, child) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.dark_mode_outlined,
                                        size: 20,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Theme Mode',
                                      style:
                                          theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SegmentedButton<AppThemeMode>(
                                  segments: const [
                                    ButtonSegment(
                                      value: AppThemeMode.light,
                                      icon: Icon(Icons.light_mode),
                                      label: Text('Light'),
                                    ),
                                    ButtonSegment(
                                      value: AppThemeMode.system,
                                      icon: Icon(Icons.smartphone),
                                      label: Text('System'),
                                    ),
                                    ButtonSegment(
                                      value: AppThemeMode.dark,
                                      icon: Icon(Icons.dark_mode),
                                      label: Text('Dark'),
                                    ),
                                  ],
                                  selected: {themeNotifier.themeMode},
                                  onSelectionChanged:
                                      (Set<AppThemeMode> selection) {
                                    themeNotifier.setThemeMode(selection.first);
                                  },
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(
                                        color: theme.colorScheme.outlineVariant
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                    theme: theme,
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsSection(
                    title: 'Other',
                    children: [
                      _buildSettingTile(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {},
                        theme: theme,
                      ),
                      _buildSettingTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () {},
                        theme: theme,
                      ),
                    ],
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? theme.colorScheme.error.withOpacity(0.1)
                      : theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isDestructive
                        ? theme.colorScheme.error
                        : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
