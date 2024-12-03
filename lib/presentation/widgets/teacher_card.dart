import 'package:flutter/material.dart';

import '../../app/config/size_config.dart';
import '../../core/model/teacher_model.dart';

class TeacherCard extends StatelessWidget {
  final TeacherModel teacherModel;

  const TeacherCard({super.key, required this.teacherModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: SizeConfig.screenWidth * 0.45,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          ],
          stops: const [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      backgroundImage: teacherModel.user.avatar != null
                          ? NetworkImage(teacherModel.user.avatar!)
                          : null,
                      child: teacherModel.user.avatar == null
                          ? Icon(Icons.person,
                              color: theme.colorScheme.primary, size: 28)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        teacherModel.user.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teacherModel.subjects?.first.name ?? "N/A",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
}

class TeacherInfo extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subject;

  const TeacherInfo({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 30,
        ),
        const SizedBox(height: 8),
        Text(name),
        Text(subject),
      ],
    );
  }
}
