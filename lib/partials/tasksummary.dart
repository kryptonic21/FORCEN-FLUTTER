import 'package:flutter/material.dart';
import 'package:test/partials/buildtasksummary.dart';

// ignore: camel_case_types
class Tasksummary extends StatefulWidget {
  final int completedTasks; // Ajout du paramètre label
  final int pendingTasks; // Ajout du paramètre color

  const Tasksummary(this.completedTasks, this.pendingTasks,
      {super.key}); // Initialisation des paramètres

  @override
  State<Tasksummary> createState() => _TasksummaryState();
}

// ignore: camel_case_types
class _TasksummaryState extends State<Tasksummary> {
  @override
  Widget build(BuildContext context) {
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
                  // print('Tâches en cours cliquées');
                },
                child: Buildtasksummary(
                  const Color(0xFF6C9FEE),
                  widget.completedTasks.toString(),
                  'Tâches en cours',
                ),
              ),
            ),
            Buildtasksummary(
              const Color(0xFFFFFFFF),
              widget.pendingTasks.toString(),
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
}
