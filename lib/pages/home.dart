import 'package:flutter/material.dart';
import 'package:test/partials/Listview.dart';
import 'package:test/partials/categorylists.dart';
import 'package:test/partials/tasksummary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tasks = [
    'Design application Flutters',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Meeting avec l\'équipe',
    'Révision des spécifications'
  ];

  @override
  Widget build(BuildContext context) {
    int completedTasks = 5;
    int pendingTasks = 10;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBar(),
          const SizedBox(height: 5),
          const Categorylists(),
          const SizedBox(height: 10),
          Tasksummary(completedTasks, pendingTasks),
          Listviews(tasks),
        ],
      ),
    );
  }
}
