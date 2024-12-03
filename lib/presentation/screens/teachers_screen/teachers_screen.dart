import 'package:flutter/material.dart';
import 'package:nist_tes/presentation/screens/teachers_screen/widgets/teacher_detail_card.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/teacher_notifier.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.school_outlined,
                          size: 24,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Teachers',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Meet our experienced faculty members',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer<TeacherNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (notifier.teacherList.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No teachers available',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList.builder(
                itemBuilder: (context, index) {
                  return TeacherDetailCard(
                    teacher: notifier.teacherList[index],
                  );
                },
                itemCount: notifier.teacherList.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
