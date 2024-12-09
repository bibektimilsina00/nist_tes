import 'package:flutter/material.dart';
import 'package:nist_tes/core/notifiers/college_wall/wall_notifier.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/auth/auth_notifier.dart';
import '../../widgets/appbar/logged_out_appbar.dart';
import 'widgets/wall_post_card.dart';

class CollegeWallScreen extends StatefulWidget {
  const CollegeWallScreen({super.key});

  @override
  State<CollegeWallScreen> createState() => _CollegeWallScreenState();
}

class _CollegeWallScreenState extends State<CollegeWallScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<AuthenticationNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading) AppBar();
            if (!notifier.isLoggedIn) {
              return const LoggedOutAppBar();
            }
            return AppBar(
              title: Text(
                'College Wall',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Create post',
                ),
              ],
            );
          },
        ),
      ),
      body: Consumer<WallNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading && notifier.walls.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notifier.error.isNotEmpty && notifier.walls.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notifier.error,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonal(
                    onPressed: notifier.refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: notifier.refresh,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: notifier.walls.length + 1,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index == notifier.walls.length) {
                  if (notifier.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                }

                return WallPostCard(post: notifier.walls[index]);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WallNotifier>().getCollegeWalls();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<WallNotifier>().loadMore();
    }
  }
}
