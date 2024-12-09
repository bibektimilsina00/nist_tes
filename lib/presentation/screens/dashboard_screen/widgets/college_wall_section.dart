import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nist_tes/presentation/screens/college_wall_screen/widgets/wall_post_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/notifiers/college_wall/wall_notifier.dart';

class CollegeWallSection extends StatelessWidget {
  const CollegeWallSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<WallNotifier>(
      builder: (context, notifier, child) {
        if (notifier.isLoading && notifier.walls.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (notifier.error.isNotEmpty && notifier.walls.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notifier.error,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: notifier.refresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (notifier.walls.isEmpty) {
          return Center(
            child: Text(
              'No posts available',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }

        return AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifier.walls.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: WallPostCard(
                        post: notifier.walls[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
