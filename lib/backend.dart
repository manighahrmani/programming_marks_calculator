import 'data.dart';

double calculateTotalMarks(Map<String, int> marks) {
  double total = 0;
  for (final entry in assessmentWeights.entries) {
    total += marks[entry.key]! * entry.value;
  }
  return total;
}

String getMessage(double totalMarks) {
  if (totalMarks >= 40) {
    return "Congratulations, you have passed in the first attempt!";
  } else {
    return "You need to hang around in July and do another assessment.";
  }
}