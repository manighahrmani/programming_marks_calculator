// lib/ui/home_page.dart
import 'package:flutter/material.dart';
import '../backend/marks_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, TextEditingController> _controllers = {
    'In-class test 1': TextEditingController(),
    'In-class test 2': TextEditingController(),
    'In-class test 3': TextEditingController(),
    'In-class test 4': TextEditingController(),
    'In-class test 5': TextEditingController(),
    'Coursework 1': TextEditingController(),
    'Coursework 2': TextEditingController(),
    'Exam 1': TextEditingController(),
    'Exam 2': TextEditingController(),
  };

  String _resultMessage = "";

  void _calculateMarks() {
    Map<String, int> marks = {};
    for (final entry in _controllers.entries) {
      int? enteredValue = int.tryParse(entry.value.text);
      if (enteredValue == null) {
        setState(() {
          _resultMessage = 'Mark entered for ${entry.key} is not a number';
        });
        return;
      }
      int mark = enteredValue;
      if (mark < 0 || mark > 100) {
        setState(() {
          _resultMessage =
              'Mark entered for ${entry.key} is not between 0 and 100';
        });
        return;
      }
      marks[entry.key] = mark;
    }

    final MarksCalculator calculator = MarksCalculator();
    final double totalMark = calculator.calculateTotalMarks(marks);
    final String message = calculator.getMessage(totalMark);
    setState(() {
      _resultMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnWidgets = [];
    for (final entry in _controllers.entries) {
      columnWidgets.add(
        TextField(
          controller: entry.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: entry.key,
          ),
        ),
      );
    }
    columnWidgets.add(const SizedBox(height: 20));
    columnWidgets.add(
      ElevatedButton(
        onPressed: _calculateMarks,
        child: const Text('Calculate'),
      ),
    );
    columnWidgets.add(
      Text(
        _resultMessage,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );

    Widget scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('Programming Marks Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: columnWidgets,
        ),
      ),
    );

    return  scaffold;
  }
}
