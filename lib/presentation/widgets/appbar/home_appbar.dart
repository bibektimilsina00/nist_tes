import 'package:flutter/material.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/core/model/user_model.dart';
import 'package:nist_tes/core/notifiers/profile_notifier.dart';
import 'package:provider/provider.dart';

import '../shimmers/home_app_bar_shimmer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.primaryContainer.withOpacity(0.1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FlexibleSpaceBar(
          background: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              return notifier.isLoading.value || notifier.userProfile == null
                  ? const HomeAppBarShimmer()
                  : HomeAppBarContent(userModel: notifier.userProfile!);
            },
          ),
        ),
      ),
    );
  }
}

class HomeAppBarContent extends StatelessWidget {
  final UserModel userModel;
  const HomeAppBarContent({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 0, left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(theme),
          const SizedBox(width: 16), // Reduced spacing
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(theme),
                const SizedBox(height: 2), // Reduced spacing
                _buildUserInfo(theme),
              ],
            ),
          ),
          _buildNotificationButton(theme, context),
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.5),
            theme.colorScheme.primary.withOpacity(0.2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: theme.colorScheme.surface,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage:
              userModel.avatar != null ? NetworkImage(userModel.avatar!) : null,
          child: userModel.avatar == null
              ? Icon(Icons.person, color: theme.colorScheme.primary, size: 36)
              : null,
        ),
      ),
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    return Row(
      children: [
        Text(
          '${_getGreeting()},',
          style: theme.textTheme.bodyLarge?.copyWith(
            // Reduced from titleMedium
            color: theme.colorScheme.onSurfaceVariant,
            letterSpacing: 0.3,
            height: 1.2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4), // Reduced spacing
        Text(
          '👋',
          style: theme.textTheme.titleMedium?.copyWith(
            // Reduced from titleLarge
            fontSize: 20, // Smaller emoji
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationButton(ThemeData theme, context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withOpacity(0.3),
            theme.colorScheme.primaryContainer.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.go(AppRoutes.notificationScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: theme.colorScheme.onSurface,
                  size: 26,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.surface,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userModel.name,
          style: theme.textTheme.titleMedium?.copyWith(
            // Reduced from titleLarge
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2), // Reduced spacing
        Text(
          '${userModel.student?.section.classModel?.faculty?.name ?? ''} ${userModel.student?.section.classModel?.name ?? ''}',
          style: theme.textTheme.bodySmall?.copyWith(
            // Reduced from bodyMedium
            color: theme.colorScheme.onSurfaceVariant,
            letterSpacing: 0.1,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
