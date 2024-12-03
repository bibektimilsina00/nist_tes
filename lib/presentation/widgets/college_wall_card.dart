import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nist_tes/core/model/college_wall_model.dart';

import '../../app/const/app_assets.dart';
import '../../core/utils/date_time_utils.dart';

class CollegeWallCard extends StatelessWidget {
  final CollegeWallModel wall;
  const CollegeWallCard({super.key, required this.wall});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            _buildHeader(wall, theme),
            const SizedBox(height: 16),
            Text(
              wall.content,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
            if (wall.description != null) ...[
              const SizedBox(height: 12),
              Text(
                wall.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
            if (wall.files != null && wall.files!.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildMediaGrid(wall.files!, theme),
            ],
            const SizedBox(height: 16),
            Divider(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            const SizedBox(height: 12),
            _buildLikeCommentRow(wall, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required ThemeData theme,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
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

  Widget _buildHeader(CollegeWallModel wall, ThemeData theme) {
    return Row(
      children: [
        Container(
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.5),
                  theme.colorScheme.primary.withOpacity(0.2),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.surface,
              child: Image.asset(
                AppAssets.collegeLogo,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posted by Admin',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                timeAgo(wall.createdAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildImageTile(String imageUrl, theme, context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showFullScreenImage(imageUrl, context),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: theme.colorScheme.errorContainer,
              child: Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLikeCommentRow(CollegeWallModel wall, ThemeData theme) {
    return Row(
      children: [
        _buildActionChip(
          icon: FontAwesome.thumbs_up,
          label: '${wall.likeCount ?? 0}',
          theme: theme,
        ),
        const SizedBox(width: 12),
        _buildActionChip(
          icon: FontAwesome.comment,
          label: '0',
          theme: theme,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          style: IconButton.styleFrom(
            backgroundColor:
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaGrid(List<String> files, theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        if (file.endsWith('.pdf')) {
          return _buildPDFTile(file, theme);
        } else {
          return _buildImageTile(file, theme, context);
        }
      },
    );
  }

  Widget _buildPDFTile(String pdfUrl, theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surfaceVariant.withOpacity(0.7),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openPDF(pdfUrl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: theme.colorScheme.primary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'View PDF',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _openPDF(String pdfUrl) {
    // Implement PDF viewer here
  }

  void _showFullScreenImage(String imageUrl, context) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(imageUrl),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
