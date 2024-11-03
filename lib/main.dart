import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:test/calendar.dart';
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
      home: TaskOverviewPage(),
    );
  }
}

class TaskOverviewPage extends StatefulWidget {
  const TaskOverviewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskOverviewPageState createState() => _TaskOverviewPageState();
}

class _TaskOverviewPageState extends State<TaskOverviewPage> {
  List<String> tasks = [
    'Design application Flutter',
    'Meeting avec l\'équipe',
    'Révision des spécifications'
  ];
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
    int completedTasks = 5;
    int pendingTasks = 10;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            const SizedBox(height: 5),
            _categoryLists(),
            const SizedBox(height: 10),
            taskSummary(completedTasks, pendingTasks),
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

  Widget listView() {
    return (Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return _buildTaskItem(tasks[index], index);
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Action à exécuter lorsqu'on clique sur "Tâches en cours"
                  print('Tâches en cours cliquées');
                },
                child: _buildTaskSummary(
                  const Color(0xFF6C9FEE),
                  completedTasks.toString(),
                  'Tâches en cours',
                ),
              ),
            ),
            _buildTaskSummary(
              const Color(0xFFFFFFFF),
              pendingTasks.toString(),
              "Tâches en attente",
            ),
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

  Widget _searchBar() {
    return Card(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher . . .',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  // Widget _buildTaskItem() {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(vertical: 3),
  //     child: ListTile(
  //       leading: const Icon(Icons.circle, color: Colors.grey, size: 12),
  //       title: const Text(
  //         'Design application Flutter',
  //         style: TextStyle(fontSize: 10),
  //       ),
  //       subtitle: const Text('24-10-2024   19:20'),
  //       trailing: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Chip(
  //             label: const Text("Travail", style: TextStyle(fontSize: 10)),
  //             backgroundColor: Colors.green[100],
  //             labelStyle: const TextStyle(color: Colors.green),
  //             padding: const EdgeInsets.symmetric(horizontal: 0, vertical: -5),
  //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           ),
  //           const SizedBox(width: 4),
  //           const Icon(Icons.flag, color: Colors.red, size: 20),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildTaskItem(String task, int index) {
    return SwipeActionCell(
      key: ValueKey(task),
      trailingActions: [
        SwipeAction(
          // title: "Modifier",
          color: Colors.blue,
          // icon: Icons.edit,
          icon: const Icon(Icons.edit, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            await handler(false);
            print("Modifier la tâche : $task");
          },
        ),
        SwipeAction(
          // title: "Supprimer",
          color: Colors.red,
          icon: const Icon(Icons.delete, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            await handler(true);
            setState(() {
              tasks.removeAt(index);
            });
          },
        ),
      ],
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: const Icon(Icons.circle, color: Colors.grey, size: 12),
          title: Text(
            task,
            style: const TextStyle(fontSize: 10),
          ),
          subtitle: const Text('24-10-2024   19:20'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Chip(
                label: const Text("Travail", style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.green[100],
                labelStyle: const TextStyle(color: Colors.green),
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: -5),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.flag, color: Colors.red, size: 20),
            ],
          ),
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

  Widget _buildTaskSummary(Color bgColor, String count, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor, // Utilisation du paramètre de type Color
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
          Text(
            count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
              ),
            );
          },
        );
      },
    );
  }
}
