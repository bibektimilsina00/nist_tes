import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/presentation/screens/event_screen/event_card.dart';
import 'package:nist_tes/presentation/widgets/appbar/home_appbar.dart';
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

  // Example holiday and event data
  final Map<DateTime, List<String>> holidays = {
    DateTime.utc(2022, 2, 14): ['Valentine\'s Day'],
  };

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const HomeAppBar(),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar(
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                defaultDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                weekendDecoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                disabledDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                outsideDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                defaultTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 18),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        'Events',
                        style: AppStyles.cardTitle,
                      ),
                    ),
                    ...List.generate(10 ?? 0, (index) {
                      return const EventCard();
                    }),
                  ],
                ),
              ),
            ],
          ),
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
