import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/const/app_assets.dart';
import '../../../app/routes/app_routes.dart';

class LoggedOutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoggedOutAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 100,
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
              theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Image.asset(
          AppAssets.collegeLogo,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        'NIST College',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
          fontSize: 20,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => context.push(AppRoutes.loginScreen),
            child: Text(
              'Login',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
