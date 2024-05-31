// lib/backend/marks_calculator.dart
class MarksCalculator {
  // Calculate the total marks based on the given marks
  double calculateTotalMarks(Map<String, int> marks) {
    int inClassTests = marks['ic1']! +
        marks['ic2']! +
        marks['ic3']! +
        marks['ic4']! +
        marks['ic5']!;
    int exams = marks['ex1']! + marks['ex2']!;
    double total = inClassTests * 0.05 +
        marks['cw2']! * 0.25 +
        marks['cw1']! * 0.20 +
        exams * 0.15;
    return total;
  }

  // Determine the message based on the total marks
  String getMessage(double totalMarks) {
    if (totalMarks >= 40) {
      return "Congratulations, you have passed in the first attempt!";
    } else {
      return "You need to hang around in July and do another assessment.";
    }
  }
}
