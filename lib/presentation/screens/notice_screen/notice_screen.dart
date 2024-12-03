// Update NoticeItem class
import 'package:flutter/material.dart';

import '../../widgets/notice_card.dart';

final noticeList = [
  const NoticeItem(
    title: 'Mid-term Examination Schedule',
    message: 'The mid-term examinations will begin from next week...',
    time: '2 hours ago',
    category: NoticeCategory.exam,
    isUnread: true,
    attachments: [
      Attachment(
        url: 'https://example.com/timetable.pdf',
        type: AttachmentType.pdf,
        name: 'Exam Timetable.pdf',
        size: '2.3 MB',
      ),
    ],
  ),
  NoticeItem(
    title: 'College Annual Function Photos',
    message: 'Photos from the annual function are now available...',
    time: '5 hours ago',
    category: NoticeCategory.general,
    isUnread: true,
    attachments: [
      for (int i = 1; i <= 6; i++)
        Attachment(
          url: 'https://picsum.photos/500/300?random=$i',
          type: AttachmentType.image,
        ),
    ],
  ),
];

class Attachment {
  final String url;
  final AttachmentType type;
  final String? name;
  final String? size;

  const Attachment({
    required this.url,
    required this.type,
    this.name,
    this.size,
  });
}

enum AttachmentType {
  image,
  pdf,
  doc,
}

class NoticeAndUpdatesScreen extends StatelessWidget {
  const NoticeAndUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notice & Updates',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            title: 'Today',
            notices: noticeList,
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<NoticeItem> notices,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...notices.map((notice) => NoticeCard(
              notice: notice,
            )),
      ],
    );
  }
}

enum NoticeCategory {
  exam,
  meeting,
  general,
}

class NoticeItem {
  final String title;
  final String message;
  final String time;
  final NoticeCategory category;
  final bool isUnread;
  final List<Attachment>? attachments;

  const NoticeItem({
    required this.title,
    required this.message,
    required this.time,
    required this.category,
    required this.isUnread,
    this.attachments,
  });
}
