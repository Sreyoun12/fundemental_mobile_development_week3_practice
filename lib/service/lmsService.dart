import '../model/Student.dart';
import '../model/Course_result.dart';
import '../model/Course.dart';

class LmsService {
  List<Student> students = [];
  List<Course> courses = [];
  Map<Course, List<Student>> enrollStudents = {};
  List<CourseResult> results = [];

  //---------------------------------------------------------------
  //                        Create course
  //---------------------------------------------------------------
  void createCourse({required String courseID, required String courseName}) {
    Course? c = isCourseExist(courseID);
    if (c != null) {
      throw Exception("Course $c already exist!");
    }
    //if not create it and add it to list
    c = Course(ID: courseID, name: courseName);
    courses.add(c);
  }

  //-----------------------------------------------------------------
  //                     Add student to the system
  //-----------------------------------------------------------------
  void addStudent({required String studentID, required String studentName}) {
    Student? student = isStudentExist(studentID);
    // Check if student exist
    if (student != null) {
      throw Exception("Student $student alreay exist!");
    }
    student = Student(ID: studentID, name: studentName);
    students.add(student);
  }

  //---------------------------------------------------------------------
  //                        add student to the course
  //---------------------------------------------------------------------
  void enrollStudent({required String courseID, required String studentID}) {
    //check student existing
    Student? s = isStudentExist(studentID);
    if (s == null) {
      throw Exception("Student $s does not exist!");
    }

    //check course existing
    Course? c = isCourseExist(courseID);
    if (c == null) {
      throw Exception("Course $c does not exist!");
    }
    enrollStudents.putIfAbsent(c, () => []);
    enrollStudents[c]!.add(s);
  }

  //--------------------------------------------------------------------
  //                    Add score for a student and a course
  //--------------------------------------------------------------------
  void addScore(
      {required int score, required Student student, required Course course}) {
    //check student existing
    Student? s = isStudentExist(student.ID);
    if (s == null) {
      throw Exception("Student $student does not exist!");
    }

    //check course existing
    Course? c = isCourseExist(course.ID);
    if (c == null) {
      throw Exception("Course $course does not exist!");
    }
    //check if student enroll in the course
    bool enrollStudent = isStudentEnrolled(
      course,
      student,
    );
    if (!enrollStudent) {
      throw Exception("Student does not enrolled in the course!");
    }
    CourseResult result = CourseResult(student: s, course: c, score: score);
    results.add(result);
  }

  //-----------------------------------------------------------------
  //                    Remove Student
  //-----------------------------------------------------------------
  void removeStudent({required String studentID}) {
    Student? s = isStudentExist(studentID);
    if (s == null) {
      throw Exception("Student $s does not exist");
    }

    for (List<Student> e in enrollStudents.values) {
      e.removeWhere((s) => s.ID == studentID);
    }

    results.removeWhere((r) => r.student.ID == studentID);
    students.removeWhere((s) => s.ID == studentID);
  }

  //-----------------------------------------------------------------
  //                         Helper function
  //-----------------------------------------------------------------
  //check if student exist
  Student? isStudentExist(String studentID) {
    for (Student s in students) {
      if (s.ID == studentID) {
        return s;
      }
    }
    return null;
  }

  //check if course exist
  Course? isCourseExist(String courseID) {
    for (Course c in courses) {
      if (c.ID == courseID) {
        return c;
      }
    }
    return null;
  }

  //check if student enroll in that course
  bool isStudentEnrolled(
    Course course,
    Student student,
  ) {
    for (Course c in enrollStudents.keys) {
      if (c.ID == course.ID) {
        List<Student> students = enrollStudents[c]!;

        for (Student s in students) {
          if (s.ID == student.ID) {
            return true;
          }
        }

        return false;
      }
    }

    return false;
  }
}
