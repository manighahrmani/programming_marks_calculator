import 'package:flutter/material.dart';
import 'backend.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This map stores TextEditingControllers for each assessment
  final Map<String, TextEditingController> _controllers = {};
  String _resultMessage = "";
  bool _isLoading = true; // To show a loading indicator while fetching data

  // initState is called when the widget is first created
  // We use it to initialize data that requires asynchronous operations
  @override
  void initState() {
    super.initState();
    _loadAssessmentNames();
  }

  // This function loads the assessment names asynchronously
  Future<void> _loadAssessmentNames() async {
    List<String> assessmentNames = await getAssessmentNames();
    setState(() {
      // Initialize TextEditingControllers for each assessment name
      for (String name in assessmentNames) {
        _controllers[name] = TextEditingController();
      }
      _isLoading = false; // Set loading to false after data is loaded
    });
  }

  // This function calculates the total marks based on user input
  Future<void> _calculateMarks() async {
    Map<String, int> marks = {};

    // Gather marks from the input fields
    for (final entry in _controllers.entries) {
      int mark = int.tryParse(entry.value.text) ?? 0;
      if (mark < 0 || mark > 100) {
        setState(() {
          _resultMessage =
              'Mark entered for ${entry.key} is not between 0 and 100';
        });
        return; // Return early if any mark is invalid
      }
      marks[entry.key] = mark;
    }

    // Calculate total marks and get the message
    final double totalMark = await calculateTotalMarks(marks);
    final String message = getMessage(totalMark);

    // Update the result message
    setState(() {
      _resultMessage = "Your total marks is $totalMark%. $message";
    });
  }

  // dispose is called when the widget is removed from the widget tree
  // We use it to clean up resources like TextEditingControllers
  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // This method builds the UI of the app
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a loading indicator while data is being loaded
      return Scaffold(
        appBar: AppBar(
          title: const Text('Programming Marks Calculator'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Create a list of widgets to display the input fields and button
    final List<Widget> columnWidgets = [];

    // Add a TextField for each assessment
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

    // Add some space after the last TextField
    columnWidgets.add(const SizedBox(height: 20));

    // Add a button to calculate the total marks
    columnWidgets.add(
      ElevatedButton(
        onPressed: _calculateMarks,
        child: const Text('Calculate'),
      ),
    );

    // Add a Text widget to display the result message
    columnWidgets.add(
      Text(
        _resultMessage,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );

    // Return the Scaffold containing the UI
    return Scaffold(
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
  }
}
