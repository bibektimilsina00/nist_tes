import 'package:flutter/material.dart';

import '../../app/enum/enum.dart';
import '../../core/utils/file_utils.dart';
import 'network_image_widget.dart';

class FullScreenMedia extends StatelessWidget {
  final String media;

  const FullScreenMedia({super.key, required this.media});

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
          child: getFileType(media) == MediaType.image
              ? NetworkImageWidget(imageUrl: media)
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

class MediaCarousel extends StatelessWidget {
  final List<String> media;
  final ValueChanged<int>? onPageChanged;

  const MediaCarousel({
    super.key,
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

class _MediaItem extends StatelessWidget {
  final String media;

  const _MediaItem({required this.media});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (getFileType(media) == MediaType.pdf) {
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
              'media.name' ?? 'Document',
              style: theme.textTheme.titleMedium,
            ),
            // if (media.size != null)
            Text(
              'media.size!',
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
        child: getFileType(media) == MediaType.image
            ? NetworkImageWidget(imageUrl: media, fit: BoxFit.cover)
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

  void _showFullScreenMedia(BuildContext context, String media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenMedia(media: media),
      ),
    );
  }
}
