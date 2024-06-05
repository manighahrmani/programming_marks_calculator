import 'package:flutter/material.dart';
import '../backend/marks_calculator.dart';
import '../data/assessment_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This syntax is known as "collection-for" in Dart.
  // For more info: https://dart.dev/language/collections#control-flow-operators
  final Map<String, TextEditingController> _controllers = {
    for (var assessment in assessmentWeights.keys)
      assessment: TextEditingController(),
  };

  // Alternatively you can define the map in the initState method:
  //
  // final Map<String, TextEditingController> _controllers = {};
  //
  // @override
  // void initState() {
  //   super.initState();
  //   for (String name in assessmentWeights.keys) {
  //     _controllers[name] = TextEditingController();
  //   }
  // }

  String _resultMessage = "";

  void _calculateMarks() {
    Map<String, int> marks = {};
    for (final entry in _controllers.entries) {
      // If the user enters a non-integer value, the value will be set to 0.
      int mark = int.tryParse(entry.value.text) ?? 0;
      if (mark < 0 || mark > 100) {
        setState(() {
          _resultMessage =
              'Mark entered for ${entry.key} is not between 0 and 100';
        });
        // If the mark is invalid, we return early from the function.
        return;
      }
      marks[entry.key] = mark;
    }

    final double totalMark = calculateTotalMarks(marks);
    final String message = getMessage(totalMark);

    setState(() {
      _resultMessage = "Your total marks is $totalMark%. $message";
    });
  }

  @override
  Widget build(BuildContext context) {
    // We create a list of widgets to be displayed in the column.
    final List<Widget> columnWidgets = [];

    for (final entry in _controllers.entries) {
      // For each entry, we create a TextField widget.
      // Keys are assessment names and values are the TextEditingControllers.
      columnWidgets.add(
        TextField(
          controller: entry.value,
          keyboardType: TextInputType.number,
          // This property is used to customize the appearance of the TextField.
          decoration: InputDecoration(
            labelText: entry.key,
          ),
        ),
      );
    }

    // SizedBox widget adds some space after the last TextField.
    columnWidgets.add(const SizedBox(height: 20));

    columnWidgets.add(
      ElevatedButton(
        // The event handler for the button is the _calculateMarks function.
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
      // Add padding to the body of the scaffold (space around the column).
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: columnWidgets,
        ),
      ),
    );

    return scaffold;
  }
}
