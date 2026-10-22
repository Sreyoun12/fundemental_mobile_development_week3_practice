import '../lib/service/lmsService.dart';
import 'package:test/test.dart';

void main() {
  test('creates a student ', () {
    LmsService service = LmsService();

    // Add student
    service.addStudent(studentID: "S1", studentName: "Ronan");
    expect(service.students.first.ID, "S1");

    // Remove student
    // service.removeStudent(studentId: "S1");
    // expect(service.students.isEmpty, true);
  });

  test('create new course', () {
    LmsService service = LmsService();
    service.createCourse(courseID: "C1", courseName: "Mobile Development");
    expect(service.courses.first.ID, "C1");
  });

  test('Enroll student to the course', () {
    LmsService service = LmsService();
    service.createCourse(courseID: "C1", courseName: "Software Engineering");
    service.addStudent(studentID: "S1", studentName: "Mina");
    service.enrollStudent(courseID: "C1", studentID: "S1");
    expect(service.enrollStudents.containsKey(service.courses.first), isTrue);
  });

  test('Add score to student', () {
    LmsService service = LmsService();
    service.createCourse(courseID: "C1", courseName: "Software Engineering");
    service.addStudent(studentID: "S1", studentName: "Mina");
    service.enrollStudent(courseID: "C1", studentID: "S1");
    service.addScore(
        score: 70,
        student: service.students.first,
        course: service.courses.first);
    expect(service.results.first.score, 70);
  });

  test('Remove student from lms', () {
    LmsService service = LmsService();
    service.createCourse(courseID: "C1", courseName: "Software Engineering");
    service.addStudent(studentID: "S1", studentName: "Mina");
    service.enrollStudent(courseID: "C1", studentID: "S1");
    service.addScore(
        score: 70,
        student: service.students.first,
        course: service.courses.first);
    service.removeStudent(studentID: "S1");
    expect(service.students, isEmpty);
  });
}
