class MarksCalculator {
  double calculateTotalMarks(Map<String, int> marks) {
    int inClassTests = marks['In-class test 1']! +
        marks['In-class test 2']! +
        marks['In-class test 3']! +
        marks['In-class test 4']! +
        marks['In-class test 5']!;
    int exams = marks['Exam 1']! + marks['Exam 2']!;
    double total = inClassTests * 0.05 +
        marks['Coursework 2']! * 0.25 +
        marks['Coursework 1']! * 0.20 +
        exams * 0.15;
    return total;
  }

  String getMessage(double totalMarks) {
    if (totalMarks >= 40) {
      return "Congratulations, you have passed in the first attempt!";
    } else {
      return "You need to hang around in July and do another assessment.";
    }
  }
}
