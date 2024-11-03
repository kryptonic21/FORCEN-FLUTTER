import 'package:flutter/material.dart';
import 'package:test/partials/BuildTaskItem.dart';

// ignore: camel_case_types
class Listviews extends StatefulWidget {
  final List tasks; // Ajout du paramètre

  const Listviews(this.tasks, {super.key}); // Initialisation des paramètres

  @override
  State<Listviews> createState() => _ListviewsState();
}

// ignore: camel_case_types
class _ListviewsState extends State<Listviews> {
  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return BuildTaskItem(widget.tasks, widget.tasks[index], index);
        },
      ),
    ));
  }
}
