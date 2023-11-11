import 'package:flutter/material.dart';

// خاص بجزء بتع عرض المهمه وحسبه الرقم بتعه
class Counter extends StatelessWidget {
  const Counter(
      {super.key, required this.allTodos, required this.allCompleted});

  final int allTodos;
  final int allCompleted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, bottom: 21),
      child: Text(
        '$allCompleted/$allTodos',
        style: TextStyle(
          fontSize: 44,
          color: allCompleted == allTodos ? Colors.greenAccent : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
