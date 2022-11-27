import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final today = DateTime.now().toLocal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
        child: TableCalendar(
          focusedDay: today,
          firstDay: DateTime.utc(2020, 1, 1, 0, 0, 0),
          lastDay: DateTime.utc(2030, 12, 31, 23, 59, 59),
          rowHeight: 50,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          //onDaySelected: ,
        ),
      ),
    );
  }
}
