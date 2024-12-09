import 'package:flutter/material.dart';

class Assignment {
  final String title;
  final String description;
  final DateTime dueDate;
  final AssignmentStatus status;
  final List<AttachmentData> attachments;
  final String subject;
  final String teacherName;

  Assignment({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.attachments,
    required this.subject,
    required this.teacherName,
  });
}

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({
    super.key,
  });

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

enum AssignmentStatus {
  pending,
  submitted,
  graded,
  overdue,
}

class AttachmentData {
  final String name;
  final String url;
  final AttachmentType type;
  final String? size;

  AttachmentData({
    required this.name,
    required this.url,
    required this.type,
    this.size,
  });
}

enum AttachmentType {
  image,
  pdf,
  doc,
}

enum UserRole {
  student,
  teacher,
}

class _AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final UserRole userRole;

  const _AssignmentCard({
    required this.assignment,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        assignment.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildStatusChip(assignment.status, theme),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  assignment.subject,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  assignment.description,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due ${_formatDate(assignment.dueDate)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      assignment.teacherName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (assignment.attachments.isNotEmpty)
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: assignment.attachments.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final attachment = assignment.attachments[index];
                  return _AttachmentTile(attachment: attachment, theme: theme);
                },
              ),
            ),
          const SizedBox(height: 8),
          if (userRole == UserRole.student &&
              assignment.status == AssignmentStatus.pending)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Submit Assignment'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(AssignmentStatus status, ThemeData theme) {
    final (color, label) = switch (status) {
      AssignmentStatus.pending => (theme.colorScheme.primary, 'Pending'),
      AssignmentStatus.submitted => (theme.colorScheme.tertiary, 'Submitted'),
      AssignmentStatus.graded => (theme.colorScheme.secondary, 'Graded'),
      AssignmentStatus.overdue => (theme.colorScheme.error, 'Overdue'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final userRole = UserRole.teacher;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assignments',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      floatingActionButton: userRole == UserRole.teacher
          ? FloatingActionButton.extended(
              onPressed: () {
                // Show create assignment dialog/screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Assignment'),
            )
          : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAssignmentList(false, theme),
          _buildAssignmentList(true, theme),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildAssignmentList(bool isCompleted, ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) => _AssignmentCard(
        assignment: Assignment(
          title: 'Database Assignment #${index + 1}',
          description:
              'Complete the following questions and submit your answers...',
          dueDate: DateTime.now().add(const Duration(days: 7)),
          status:
              isCompleted ? AssignmentStatus.graded : AssignmentStatus.pending,
          attachments: [
            AttachmentData(
              name: 'Assignment.pdf',
              url: 'https://example.com/assignment.pdf',
              type: AttachmentType.pdf,
              size: '2.3 MB',
            ),
            AttachmentData(
              name: 'Reference Image',
              url: 'https://picsum.photos/200',
              type: AttachmentType.image,
            ),
          ],
          subject: 'Database Management',
          teacherName: 'Dr. John Doe',
        ),
        userRole: userRole,
      ),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  final AttachmentData attachment;
  final ThemeData theme;

  const _AttachmentTile({
    required this.attachment,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getAttachmentIcon(attachment.type),
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  attachment.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (attachment.size != null)
                  Text(
                    attachment.size!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined),
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  IconData _getAttachmentIcon(AttachmentType type) {
    return switch (type) {
      AttachmentType.image => Icons.image_outlined,
      AttachmentType.pdf => Icons.picture_as_pdf_outlined,
      AttachmentType.doc => Icons.description_outlined,
    };
  }
}
