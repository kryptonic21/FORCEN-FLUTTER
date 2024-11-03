import 'package:flutter/material.dart';
import 'package:test/partials/categorychip.dart';

class Categorylists extends StatefulWidget {
  const Categorylists({super.key});

  @override
  State<Categorylists> createState() => CategorylistsState();
}

class CategorylistsState extends State<Categorylists> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Categorychip("Tout", Colors.blue),
                SizedBox(width: 8), // Espacement entre les chips
                Categorychip("Travail", Colors.green),
                SizedBox(width: 8),
                Categorychip("Personnel", Colors.red),
                SizedBox(width: 8),
                Categorychip("Sport", Colors.black),
                SizedBox(width: 8),
                Categorychip("Autre", Colors.orange),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
