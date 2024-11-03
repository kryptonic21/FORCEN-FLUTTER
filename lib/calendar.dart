import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test/main.dart';
import 'package:test/partials/app_bar.dart';
import 'package:test/partials/bottom_navigation_bar.dart';
import 'package:test/partials/floating_action_button.dart';
import 'package:test/profile.dart';
import 'package:test/taskList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> tasks = [
    'Design application Flutter',
    'Meeting avec l\'équipe',
    'Révision des spécifications'
  ];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  int completedTasks = 5;
  int pendingTasks = 10;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation or other actions here as needed
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TaskOverviewPage()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Tasklist()),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarPage()),
      );
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendrier
            SizedBox(
              width:
                  MediaQuery.of(context).size.width, // Ajustez la largeur ici
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
            listView(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        icon: Icons.add, // Optional icon parameter
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

Widget listView() {
  return (Expanded(
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildTaskItem();
      },
    ),
  ));
}

Widget taskSummary(completedTasks, pendingTasks) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTaskSummary(completedTasks.toString(), "Tâches terminées"),
          _buildTaskSummary(pendingTasks.toString(), "Tâches en attente"),
        ],
      ),
      const SizedBox(height: 8),
      const Text(
        'Tâches en attente',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _categoryLists() {
  return Row(
    children: [
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryChip("Tout", Colors.blue),
              const SizedBox(width: 8), // Espacement entre les chips
              _buildCategoryChip("Travail", Colors.green),
              const SizedBox(width: 8),
              _buildCategoryChip("Personnel", Colors.red),
              const SizedBox(width: 8),
              _buildCategoryChip("Sport", Colors.black),
              const SizedBox(width: 8),
              _buildCategoryChip("Autre", Colors.orange),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildTaskItem() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 3),
    child: ListTile(
      leading: const Icon(Icons.circle, color: Colors.grey, size: 12),
      title: const Text(
        'Design application Flutter',
        style: TextStyle(fontSize: 10),
      ),
      subtitle: const Text('24-10-2024   19:20'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: const Text("Travail", style: TextStyle(fontSize: 10)),
            backgroundColor: Colors.green[100],
            labelStyle: const TextStyle(color: Colors.green),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: -5),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.flag, color: Colors.red, size: 20),
        ],
      ),
    ),
  );
}

Widget _buildCategoryChip(String label, Color color) {
  return Chip(
    label: Text(label),
    backgroundColor: color.withOpacity(0.2),
    labelStyle: TextStyle(color: color),
    padding: const EdgeInsets.all(5),
  );
}

Widget _buildTaskSummary(String count, String label) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(label),
      ],
    ),
  );
}

void _showAddTaskModal(BuildContext context) {
  DateTime? selectedDate;
  Color selectedFlagColor = Colors.grey;
  Color selectedPaletteColor = Colors.grey;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text('Retour', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Logic to save the task
                        Navigator.pop(context);
                      },
                      child: const Text('Enregistrer'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Nom de la tâche',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                _categoryLists(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.calendar_today, size: 24),
                          if (selectedDate != null)
                            Text(
                              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              style: const TextStyle(fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.flag,
                                      color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      selectedFlagColor = Colors.green;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.flag,
                                      color: Colors.yellow),
                                  onPressed: () {
                                    setState(() {
                                      selectedFlagColor = Colors.yellow;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                IconButton(
                                  icon:
                                      const Icon(Icons.flag, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      selectedFlagColor = Colors.red;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child:
                          Icon(Icons.flag, color: selectedFlagColor, size: 24),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                for (var color in [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.red,
                                  Colors.orange,
                                  Colors.purple,
                                  Colors.pink,
                                  Colors.yellow
                                ])
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPaletteColor = color;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.palette,
                          color: selectedPaletteColor, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Description de la tâche',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
