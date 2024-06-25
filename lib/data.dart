import 'dart:io';
import 'package:csv/csv.dart';

// This function is asynchronous because it reads from a file.
// Hence it returns a Future object that will contain the assessment weights.
Future<Map<String, double>> loadAssessmentWeights() async {
  // You can use '../' to go up one directory from the current file.
  String pathToCsv = 'assessment_weights.csv';
  File file = File(pathToCsv);
  String csvString = await file.readAsString();
  List<List<String>> rows = const CsvToListConverter().convert(csvString);

  // Skip the first row (header) and convert each row to a map entry.
  rows = rows.skip(1).toList();

  Map<String, double> assessmentWeights = {};

  for (List<String> row in rows) {
    String assessmentName = row[0];
    double weight = double.parse(row[1]);
    assessmentWeights[assessmentName] = weight;
  }

  return assessmentWeights;
}

const Map<String, double> assessmentWeights = {
  '(Item 1) In-class test 1': 0.05,
  '(Item 2) In-class test 2': 0.05,
  '(Item 3) Coursework 1': 0.20,
  '(Item 4) Exam 1': 0.15,
  '(Item 5) In-class test 3': 0.05,
  '(Item 6) Coursework 2': 0.25,
  '(Item 7) In-class test 4': 0.05,
  '(Item 8) In-class test 5': 0.05,
  '(Item 9) Exam 2': 0.15,
};