import 'package:flutter/material.dart';
import 'package:test/partials/Listview.dart';
import 'package:test/partials/categorylists.dart';

class Tasklist extends StatefulWidget {
  const Tasklist({super.key});

  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  int completedTasks = 10;
  int pendingTasks = 5;
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
    'Révision des spécifications'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBar(),
          const SizedBox(height: 5),
          const Categorylists(),
          const SizedBox(height: 10),
          // Tasksummary(completedTasks, pendingTasks),
          Listviews(tasks),
        ],
      ),
    );
  }
}
