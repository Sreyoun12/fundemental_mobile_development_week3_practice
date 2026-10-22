import 'Student.dart';
import 'Course.dart';

class CourseResult {
  Student student;
  Course course;
  int score;

  CourseResult({required this.student, required this.course, this.score = 0});
}
