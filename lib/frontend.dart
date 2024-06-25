import 'package:flutter/material.dart';
import 'backend.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double>? _assessmentWeights = {};
  final Map<String, TextEditingController> _controllers = {};
  String _resultMessage = "";

  // `initState` is the first method called when a stateful widget is created.
  // It initializes the state variables or performs startup tasks. In our case:
  // We call `_loadData` to load the assessment weights from the CSV file and
  // set it to the value of the `_assessmentWeights` instance variable.
  @override
  void initState() {
    // This call to `super.initState()` is necessary by default.
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Map<String, double> weights = await loadAssessmentWeights();
    // `setState` is called to update the state of instance variables.
    setState(() {
      _assessmentWeights = weights;
      for (String assessment in _assessmentWeights!.keys) {
        _controllers[assessment] = TextEditingController();
      }
    });
  }

  Future<void> _calculateMarks() async {
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

    final double totalMark = await calculateTotalMarks(marks);
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
        // The event handler for the button is the `_calculateMarks` function.
        // Since it is an asynchronous function, the event handler is an `async`
        // lambda function that does not take any parameters (hence `()`).
        // The lambda function then `await`s the result of `_calculateMarks`.
        onPressed: () async => await _calculateMarks(),
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
