import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/core/notifiers/wall_notifier.dart';
import 'package:nist_tes/presentation/widgets/college_wall_card.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import 'widgets/notice_section.dart';
import 'widgets/section_title.dart';
import 'widgets/teacher_section.dart';

// DashboardScreen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome to NIST College',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const TeachersSection(),
              const SizedBox(height: 24),
              SectionTitle(
                title: 'College Wall',
                onViewAll: () {
                  context.push(AppRoutes.collegeWallScreen);
                },
              ),
              const SizedBox(height: 16),
              Consumer<WallNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (notifier.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        'Error loading wall posts',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    );
                  }

                  if (notifier.collegeWallList.isEmpty) {
                    return Center(
                      child: Text(
                        'No posts available',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }

                  return CollegeWallCard(
                    wall: notifier.collegeWallList.first,
                  );
                },
              ),
              const SizedBox(height: 24),
              SectionTitle(
                title: 'Notice Updates',
                onViewAll: () {
                  context.push(AppRoutes.noticeScreen);
                },
              ),
              const SizedBox(height: 16),
              const NoticeUpdatesSection(),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }
}
