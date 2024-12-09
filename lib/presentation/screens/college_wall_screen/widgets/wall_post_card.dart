import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:nist_tes/core/model/college_wall_model.dart';
import 'package:nist_tes/core/utils/file_utils.dart';
import 'package:nist_tes/presentation/widgets/network_image_widget.dart';

import '../../../../app/enum/enum.dart';
import '../../../widgets/media_carousel.dart';

class MediaContent extends StatelessWidget {
  final List<String> media;

  const MediaContent({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
        itemCount: media.length,
        itemBuilder: (context, index) {
          final item = media[index];
          return GestureDetector(
            onTap: () => _showFullScreenMedia(context, item),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: getFileType(item) == MediaType.image
                  ? NetworkImageWidget(
                      imageUrl: item,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _showFullScreenMedia(BuildContext context, String media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenMedia(media: media),
      ),
    );
  }
}

class WallPostCard extends StatefulWidget {
  final CollegeWallModel post;

  const WallPostCard({super.key, required this.post});

  @override
  State<WallPostCard> createState() => _WallPostCardState();
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final ThemeData theme;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WallPostCardState extends State<WallPostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeController;
  bool _isLiked = false;
  int _currentMediaIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            if (widget.post.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  widget.post.content,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                  ),
                ),
              ),
            if (widget.post.files?.isNotEmpty ?? false)
              Stack(
                alignment: Alignment.center,
                children: [
                  MediaCarousel(
                    media: widget.post.files ?? [],
                    onPageChanged: (index) {
                      setState(() => _currentMediaIndex = index);
                    },
                  ),
                  ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: _likeController,
                      curve: Curves.easeOutBack,
                    )),
                    child: Icon(
                      Icons.favorite,
                      color: theme.colorScheme.primary,
                      size: 100,
                    ),
                  ),
                  if ((widget.post.files?.length ?? 0) > 1)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentMediaIndex + 1}/${widget.post.files?.length ?? 0}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  LikeButton(
                    size: 24,
                    isLiked: _isLiked,
                    likeCount: widget.post.likeCount,
                    countBuilder: (count, isLiked, text) {
                      return Text(
                        text,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: isLiked
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                    likeBuilder: (isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: 24,
                      );
                    },
                    onTap: (isLiked) async {
                      setState(() => _isLiked = !isLiked);
                      return !isLiked;
                    },
                  ),
                  const SizedBox(width: 16),
                  // _ActionButton(
                  //   icon: Icons.comment_outlined,
                  //   label: '${widget.post.likeCount} Comments',
                  //   onPressed: () {},
                  //   theme: theme,
                  // ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surfaceContainerHighest
                          .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.5),
                  theme.colorScheme.primary.withOpacity(0.2),
                ],
              ),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                widget.post.profileImageUrl ??
                    'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nist College",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Admin",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getTimeAgo(widget.post.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _handleDoubleTap() {
    setState(() {
      _isLiked = true;
    });
    _likeController.forward().then((_) => _likeController.reverse());
  }
}
