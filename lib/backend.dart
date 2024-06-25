import 'data.dart';

Future<double> calculateTotalMarks(Map<String, int> marks) async{
  double total = 0;
  Map<String, double> assessmentWeights = await loadAssessmentWeights();
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
