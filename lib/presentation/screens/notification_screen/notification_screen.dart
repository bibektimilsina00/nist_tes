import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool isUnread;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isUnread,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mark_email_read_outlined),
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildSection(
            title: 'Today',
            notifications: [
              const NotificationItem(
                title: 'New Assignment Posted',
                message: 'Operating Systems assignment due next week',
                time: '2 hours ago',
                type: NotificationType.assignment,
                isUnread: true,
              ),
              const NotificationItem(
                title: 'Attendance Update',
                message: 'Your attendance is below 75% in Database Management',
                time: '5 hours ago',
                type: NotificationType.warning,
                isUnread: true,
              ),
            ],
            theme: theme,
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Yesterday',
            notifications: [
              const NotificationItem(
                title: 'Exam Schedule Updated',
                message: 'Mid-term examination schedule has been published',
                time: '1 day ago',
                type: NotificationType.exam,
                isUnread: false,
              ),
            ],
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<NotificationItem> notifications,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...notifications.map((notification) => _NotificationCard(
              notification: notification,
              theme: theme,
            )),
      ],
    );
  }
}

enum NotificationType {
  assignment,
  exam,
  warning,
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final ThemeData theme;

  const _NotificationCard({
    required this.notification,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getTypeColor(notification.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(notification.type),
                    color: _getTypeColor(notification.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: notification.isUnread
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (notification.isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification.time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Colors.blue;
      case NotificationType.exam:
        return Colors.purple;
      case NotificationType.warning:
        return Colors.orange;
    }
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Icons.assignment_outlined;
      case NotificationType.exam:
        return Icons.quiz_outlined;
      case NotificationType.warning:
        return Icons.warning_amber_outlined;
    }
  }
}
