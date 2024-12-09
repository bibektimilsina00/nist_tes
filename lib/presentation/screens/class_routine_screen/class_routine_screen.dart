import 'package:flutter/material.dart';
import 'package:nist_tes/core/notifiers/routine/routine_notifier.dart';
import 'package:nist_tes/core/notifiers/subject/subject_notifier.dart';
import 'package:nist_tes/presentation/screens/class_routine_screen/widgets/routine_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/shimmers/routine_day_shimmer.dart';

class ClassRoutineScreen extends StatelessWidget {
  const ClassRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
              padding: const EdgeInsets.all(16),
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
                          Icons.book_outlined,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Subjects with codes",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<SubjectNotifier>(
                    builder: (context, notifier, child) {
                      final sortedSubjects = List.from(notifier.subjects)
                        ..sort((a, b) {
                          int aLength = (a.name + a.subjectCode).length;
                          int bLength = (b.name + b.subjectCode).length;
                          return aLength.compareTo(bLength);
                        });

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: sortedSubjects.map((subject) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        theme.colorScheme.surface,
                                        theme
                                            .colorScheme.surfaceContainerHighest
                                            .withOpacity(0.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: theme.colorScheme.outlineVariant
                                          .withOpacity(0.5),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            theme.shadowColor.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.book_outlined,
                                          size: 16,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          subject.name,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.1,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          subject.subjectCode,
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer<RoutineNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ShimmerRoutineDay(),
                  childCount: 5,
                ),
              );
            }

            if (notifier.routines.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No routines available',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RoutineDay(
                    day: notifier.routines[index].name.toUpperCase(),
                    routineList: notifier.routines[index].routineDetails,
                  ),
                ),
                childCount: notifier.routines.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
