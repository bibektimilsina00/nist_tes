import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/routine_model.dart';

class RoutineDay extends StatelessWidget {
  final String day;
  final List<RoutineDetailModel> routineList;

  const RoutineDay({super.key, required this.day, required this.routineList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            day,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calendar_today,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                  },
                  children: [
                    _buildTableHeader(theme),
                    ...routineList
                        .map((routine) => _buildTableRow(routine, theme)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(String time) {
    final parsedTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('HH:mm').format(parsedTime);
  }

  Widget _buildDataCell(String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.1,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildHeaderCell(IconData icon, String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableHeader(ThemeData theme) {
    return TableRow(
      children: [
        _buildHeaderCell(Icons.timer_outlined, 'Duration', theme),
        _buildHeaderCell(Icons.book_outlined, 'Subject', theme),
        _buildHeaderCell(Icons.person_outline, 'Teacher', theme),
      ],
    );
  }

  TableRow _buildTableRow(RoutineDetailModel routine, ThemeData theme) {
    return TableRow(
      children: [
        _buildDataCell(
            '${formatTime(routine.startTime)} - ${formatTime(routine.endTime)}',
            theme),
        _buildDataCell(routine.subject.subjectCode, theme),
        _buildDataCell(routine.subject.teacher?.user.name ?? "N/A", theme),
      ],
    );
  }
}
