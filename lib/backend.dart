import 'data.dart';

// This function calculates the total marks using the assessment weights.
// It takes a map of marks as input and returns the total marks as a Future<double>.
Future<double> calculateTotalMarks(Map<String, int> marks) async {
  // Load the assessment weights from the CSV file
  Map<String, double> assessmentWeights = await loadAssessmentWeights();

  // Initialize total marks to 0
  double total = 0;

  // Calculate the total marks using the weights
  for (final entry in assessmentWeights.entries) {
    total += (marks[entry.key] ?? 0) * entry.value;
  }

  return total;
}

// This function retrieves a list of assessment names for the frontend to use as input fields.
// It returns a Future<List<String>> containing the assessment names.
Future<List<String>> getAssessmentNames() async {
  Map<String, double> assessmentWeights = await loadAssessmentWeights();
  List<String> assessmentNames = [];
  for (var entry in assessmentWeights.entries) {
    // The keys of the map are the assessment names.
    assessmentNames.add(entry.key);
  }
  return assessmentNames;
}

// This function returns a message based on the total marks.
String getMessage(double totalMarks) {
  if (totalMarks >= 40) {
    return "Congratulations, you have passed in the first attempt!";
  } else {
    return "You need to hang around in July and do another assessment.";
  }
}
