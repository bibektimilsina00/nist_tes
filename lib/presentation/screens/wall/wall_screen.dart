import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/const/app_assets.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/presentation/widgets/college_wall_card.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/wall_notifier.dart';

class WallScreen extends StatefulWidget {
  const WallScreen({super.key});

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
          'College Wall',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FilledButton.tonal(
              onPressed: () => context.go(AppRoutes.loginScreen),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Login",
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: Consumer<WallNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notifier.errorMessage != '') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading data',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: notifier.collegeWallList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final wall = notifier.collegeWallList[index];
              return CollegeWallCard(wall: wall);
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WallNotifier>().getCollegeWalls();
    });
  }
}
