import 'package:flutter_test/flutter_test.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';

void main() {
  group('Teacherinfo Tests', () {
    late Teacherinfo model;

    setUp(() {
      model = Teacherinfo(
        age: '30',
        qualification: 'Master of Arts',
        subjects: ['Math', 'Science'],
        id: 'teacher123',
        description: 'Experienced teacher with a passion for education.',
        phoneNumber: '9876543210',
      );
    });

    test('fromJson() should create a Teacherinfo instance from JSON', () {
      final json = {
        'age': '30',
        'qualification': 'Master of Arts',
        'subjects': ['Math', 'Science'],
        'id': 'teacher123',
        'description': 'Experienced teacher with a passion for education.',
        'phoneNumber': '9876543210',
      };

      final result = Teacherinfo.fromJson(json);

      expect(result, isA<Teacherinfo>());
      expect(result.age, '30');
      expect(result.qualification, 'Master of Arts');
      expect(result.subjects, ['Math', 'Science']);
      expect(result.id, 'teacher123');
      expect(result.description,
          'Experienced teacher with a passion for education.');
      expect(result.phoneNumber, '9876543210');
    });

    test('toJson() should convert a Teacherinfo instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['age'], '30');
      expect(result['qualification'], 'Master of Arts');
      expect(result['subjects'], ['Math', 'Science']);
      expect(result['id'], 'teacher123');
      expect(result['description'],
          'Experienced teacher with a passion for education.');
      expect(result['phoneNumber'], '9876543210');
    });
  });
}
