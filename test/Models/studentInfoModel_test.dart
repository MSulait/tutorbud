import 'package:flutter_test/flutter_test.dart';
import 'package:tutor_bud/Models/studentInfoModel.dart';

void main() {
  group('Studentinfo Tests', () {
    late Studentinfo model;

    setUp(() {
      model = Studentinfo(
        age: '20',
        qualification: 'Bachelor of Science',
        id: 'student123',
        description: 'I am a dedicated student.',
        phoneNumber: '1234567890',
      );
    });

    test('fromJson() should create a Studentinfo instance from JSON', () {
      final json = {
        'age': '20',
        'qualification': 'Bachelor of Science',
        'id': 'student123',
        'description': 'I am a dedicated student.',
        'phoneNumber': '1234567890',
      };

      final result = Studentinfo.fromJson(json);

      expect(result, isA<Studentinfo>());
      expect(result.age, '20');
      expect(result.qualification, 'Bachelor of Science');
      expect(result.id, 'student123');
      expect(result.description, 'I am a dedicated student.');
      expect(result.phoneNumber, '1234567890');
    });

    test('toJson() should convert a Studentinfo instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['age'], '20');
      expect(result['qualification'], 'Bachelor of Science');
      expect(result['id'], 'student123');
      expect(result['description'], 'I am a dedicated student.');
      expect(result['phoneNumber'], '1234567890');
    });
  });
}
