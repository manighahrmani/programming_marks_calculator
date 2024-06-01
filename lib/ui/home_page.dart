// lib/ui/home_page.dart
import 'package:flutter/material.dart';
import '../backend/marks_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ic1Controller = TextEditingController();
  final TextEditingController _ic2Controller = TextEditingController();
  final TextEditingController _ic3Controller = TextEditingController();
  final TextEditingController _ic4Controller = TextEditingController();
  final TextEditingController _ic5Controller = TextEditingController();
  final TextEditingController _cw1Controller = TextEditingController();
  final TextEditingController _cw2Controller = TextEditingController();
  final TextEditingController _ex1Controller = TextEditingController();
  final TextEditingController _ex2Controller = TextEditingController();

  String _resultMessage = "";

  void _calculateMarks() {
    final marks = {
      'In-class test 1': int.tryParse(_ic1Controller.text) ?? 0,
      'In-class test 2': int.tryParse(_ic2Controller.text) ?? 0,
      'In-class test 3': int.tryParse(_ic3Controller.text) ?? 0,
      'In-class test 4': int.tryParse(_ic4Controller.text) ?? 0,
      'In-class test 5': int.tryParse(_ic5Controller.text) ?? 0,
      'Coursework 1': int.tryParse(_cw1Controller.text) ?? 0,
      'Coursework 2': int.tryParse(_cw2Controller.text) ?? 0,
      'Exam 1': int.tryParse(_ex1Controller.text) ?? 0,
      'Exam 2': int.tryParse(_ex2Controller.text) ?? 0,
    };
    final calculator = MarksCalculator();
    final totalMarks = calculator.calculateTotalMarks(marks);
    final message = calculator.getMessage(totalMarks);
    setState(() {
      _resultMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programming Marks Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_ic1Controller, 'In-class test 1'),
            _buildTextField(_ic2Controller, 'In-class test 2'),
            _buildTextField(_ic3Controller, 'In-class test 3'),
            _buildTextField(_ic4Controller, 'In-class test 4'),
            _buildTextField(_ic5Controller, 'In-class test 5'),
            _buildTextField(_cw1Controller, 'Coursework 1'),
            _buildTextField(_cw2Controller, 'Coursework 2'),
            _buildTextField(_ex1Controller, 'Exam 1'),
            _buildTextField(_ex2Controller, 'Exam 2'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateMarks,
              child: const Text('Calculate'),
            ),
            Text(
              _resultMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
