import 'Student.dart';

class Course {
  String ID;
  String name;
  late List<Student> students;

  Course({required this.ID, required this.name});
}
