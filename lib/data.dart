import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

// This function reads the assessment weights from a CSV file in the assets.
// It returns a Future object that will contain a map of assessment names and their weights.
Future<Map<String, double>> loadAssessmentWeights() async {
  // Path to the CSV file within the assets
  const String pathToCsv = 'assets/assessment_weights.csv';

  try {
    String csvString = await rootBundle.loadString(pathToCsv);
    List<String> lines = csvString.split('\n');

    // Ensure there are enough lines (at least one header and one data line)
    if (lines.length < 2) {
      throw Exception("CSV file doesn't have enough lines.");
    }

    // Skip the first line (header) and parse the remaining lines
    List<List<dynamic>> rows = [];
    for (int i = 1; i < lines.length; i++) {
      String line = lines[i].trim();
      // Convert the line to a list of lists (each inner list represents a row)
      List<List<dynamic>> convertedRows =
          const CsvToListConverter().convert(line);
      // Extract the first row from the converted rows
      List<dynamic> row = convertedRows.first;

      rows.add(row);
    }

    Map<String, double> assessmentWeights = {};
    for (List<dynamic> row in rows) {
      if (row.length < 2) {
        // Skip invalid rows
        continue;
      }

      String assessmentName = row[0].toString().trim();
      double weight = double.parse(row[1].toString().trim());
      assessmentWeights[assessmentName] = weight;
    }

    return assessmentWeights;
  } catch (e) {
    // Print error message and return an empty map if an error occurs
    print('Error loading CSV: $e');
    return {};
  }
}
