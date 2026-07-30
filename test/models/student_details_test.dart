import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/utils/students_details.dart';

void main() {
  test('student details expose the expected profile values', () {
    expect(StudentDetails.name, 'Rishu Tonk');
    expect(StudentDetails.upNumber, '2286527');
    expect(StudentDetails.initials, 'RT');
    expect(StudentDetails.email, 'up2286527@myport.ac.uk');
  });
}
