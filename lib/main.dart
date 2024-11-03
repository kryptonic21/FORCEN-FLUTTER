import 'package:flutter/material.dart';
import 'package:test/pages/calendar.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/tasklist.dart';
import 'package:test/partials/app_bar.dart';
import 'package:test/partials/categorylists.dart';
import 'package:test/partials/floating_action_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: [
          const HomePage(),
          const Tasklist(),
          const CalendarPage(),
          const ProfileScreen()
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acceuil'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Taches'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Agenda'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          onTap: (index) => setCurrentIndex(index),
        ),
        floatingActionButton: Builder(
          builder: (context) => CustomFloatingActionButton(
            onPressed: () {
              _showAddTaskModal(context);
            },
            icon: Icons.add,
          ),
        ),
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
        return Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
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
                    const Categorylists(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      icon: const Icon(Icons.flag,
                                          color: Colors.red),
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
                          child: Icon(Icons.flag,
                              color: selectedFlagColor, size: 24),
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
