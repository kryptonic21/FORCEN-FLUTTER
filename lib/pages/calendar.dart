import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test/partials/Listview.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> tasks = [
    'Design application Flutter',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Révision des spécifications'
  ];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  int completedTasks = 5;
  int pendingTasks = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendrier
          SizedBox(
            width: MediaQuery.of(context).size.width, // Ajustez la largeur ici
            height: 350, // Ajustez la hauteur ici
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Listviews(tasks),
        ],
      ),
    );
  }
}
