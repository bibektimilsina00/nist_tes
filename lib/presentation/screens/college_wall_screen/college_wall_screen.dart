import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CollegeWallScreen extends StatelessWidget {
  const CollegeWallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => _WallPostCard(
          post: WallPost(
            author: const PostAuthor(
              name: 'John Doe',
              avatar: 'https://picsum.photos/200',
              role: 'Student',
            ),
            content: 'This is a sample post with multiple media...',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            media: [
              const PostMedia(
                type: MediaType.image,
                url: 'https://picsum.photos/800/400?random=1',
              ),
              const PostMedia(
                type: MediaType.image,
                url: 'https://picsum.photos/800/400?random=2',
              ),
              const PostMedia(
                type: MediaType.pdf,
                url: 'sample.pdf',
                name: 'Document.pdf',
                size: '2.3 MB',
              ),
            ],
            likes: 42,
            comments: 8,
            isLiked: false,
          ),
        ),
      ),
    );
  }
}

enum MediaType {
  image,
  video,
  pdf,
}

class PostAuthor {
  final String name;
  final String avatar;
  final String role;

  const PostAuthor({
    required this.name,
    required this.avatar,
    required this.role,
  });
}

class PostMedia {
  final MediaType type;
  final String url;
  final String? name;
  final String? size;

  const PostMedia({
    required this.type,
    required this.url,
    this.name,
    this.size,
  });
}

// Models
class WallPost {
  final PostAuthor author;
  final String content;
  final DateTime timestamp;
  final List<PostMedia> media;
  final int likes;
  final int comments;
  final bool isLiked;

  const WallPost({
    required this.author,
    required this.content,
    required this.timestamp,
    required this.media,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });
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

class _FullScreenMedia extends StatelessWidget {
  final PostMedia media;

  const _FullScreenMedia({required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: media.type == MediaType.image
              ? Image.network(media.url)
              : const Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

class _MediaCarousel extends StatelessWidget {
  final List<PostMedia> media;
  final ValueChanged<int>? onPageChanged;

  const _MediaCarousel({
    required this.media,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        itemCount: media.length,
        itemBuilder: (context, index) {
          final item = media[index];
          return _MediaItem(media: item);
        },
      ),
    );
  }
}

class _MediaContent extends StatelessWidget {
  final List<PostMedia> media;

  const _MediaContent({required this.media});

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
              child: item.type == MediaType.image
                  ? Image.network(
                      item.url,
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

  void _showFullScreenMedia(BuildContext context, PostMedia media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenMedia(media: media),
      ),
    );
  }
}

class _MediaItem extends StatelessWidget {
  final PostMedia media;

  const _MediaItem({required this.media});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (media.type == MediaType.pdf) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              media.name ?? 'Document',
              style: theme.textTheme.titleMedium,
            ),
            if (media.size != null)
              Text(
                media.size!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showFullScreenMedia(context, media),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: media.type == MediaType.image
            ? Image.network(
                media.url,
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
  }

  void _showFullScreenMedia(BuildContext context, PostMedia media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenMedia(media: media),
      ),
    );
  }
}

class _WallPostCard extends StatefulWidget {
  final WallPost post;

  const _WallPostCard({required this.post});

  @override
  State<_WallPostCard> createState() => _WallPostCardState();
}

class _WallPostCardState extends State<_WallPostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeController;
  bool _isLiked = false;
  int _currentMediaIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
          if (widget.post.media.isNotEmpty)
            GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _MediaCarousel(
                    media: widget.post.media,
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
                  if (widget.post.media.length > 1)
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
                          '${_currentMediaIndex + 1}/${widget.post.media.length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                LikeButton(
                  size: 24,
                  isLiked: _isLiked,
                  likeCount: widget.post.likes,
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
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: '${widget.post.comments}',
                  onPressed: () {},
                  theme: theme,
                ),
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
    _isLiked = widget.post.isLiked;
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
              backgroundImage: NetworkImage(widget.post.author.avatar),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.author.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.post.author.role,
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
                      _getTimeAgo(widget.post.timestamp),
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
