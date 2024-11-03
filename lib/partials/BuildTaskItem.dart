import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

// ignore: camel_case_types
class BuildTaskItem extends StatefulWidget {
  final List tasks; // Ajout du paramètre
  final String task; // Ajout du paramètre
  final int index; // Ajout du paramètre

  const BuildTaskItem(this.tasks, this.task, this.index,
      {super.key}); // Initialisation des paramètres

  @override
  State<BuildTaskItem> createState() => _BuildTaskItemState();
}

// ignore: camel_case_types
class _BuildTaskItemState extends State<BuildTaskItem> {
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ValueKey(widget.tasks),
      trailingActions: [
        SwipeAction(
          // title: "Modifier",
          color: Colors.blue,
          // icon: Icons.edit,
          icon: const Icon(Icons.edit, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            await handler(false);
            // print("Modifier la tâche : $task");
          },
        ),
        SwipeAction(
          // title: "Supprimer",
          color: Colors.red,
          icon: const Icon(Icons.delete, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            await handler(true);
            setState(() {
              widget.tasks.removeAt(widget.index);
            });
          },
        ),
      ],
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: const Icon(Icons.circle, color: Colors.grey, size: 12),
          title: Text(
            widget.task,
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
}
