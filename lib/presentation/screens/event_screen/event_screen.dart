import 'package:flutter/material.dart';
import 'package:nist_tes/presentation/screens/event_screen/event_card.dart';
import 'package:table_calendar/table_calendar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Map<DateTime, List<String>> selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  titleTextStyle: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  rightChevronIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                ),
                calendarStyle: CalendarStyle(
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  todayDecoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  weekendDecoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  outsideDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  defaultTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    letterSpacing: 0.1,
                  ),
                  selectedTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                  todayTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                  weekendTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.error,
                    letterSpacing: 0.1,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                  weekendStyle: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                daysOfWeekHeight: 32,
                weekNumbersVisible: false,
                eventLoader: _getEventsForDay,
                weekendDays: const [DateTime.saturday],
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => _selectedDay == day,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Upcoming Events',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  ...List.generate(10, (index) => const EventCard()),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
  }

  List<String> _getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }
}
