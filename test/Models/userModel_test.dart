import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tutor_bud/Models/userModel.dart';

void main() {
  group('User Tests', () {
    late user model;

    setUp(() {
      model = user(
        first_name: 'John',
        last_name: 'Doe',
        email: 'johndoe@example.com',
        id: 'user123',
        ProfileImagePath: '/path/to/profile/image.jpg',
        UserType: 'Teacher',
      );
    });

    test('fromJson() should create a User instance from JSON', () {
      final json = {
        'Firstname': 'John',
        'LastName': 'Doe',
        'email': 'johndoe@example.com',
        'id': 'user123',
        'ProfileImagePath': '/path/to/profile/image.jpg',
        'UserType': 'Teacher',
      };

      final result = user.fromJson(json);

      expect(result, isA<user>());
      expect(result.first_name, 'John');
      expect(result.last_name, 'Doe');
      expect(result.email, 'johndoe@example.com');
      expect(result.id, 'user123');
      expect(result.ProfileImagePath, '/path/to/profile/image.jpg');
      expect(result.UserType, 'Teacher');
    });

    test('toJson() should convert a User instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['Firstname'], 'John');
      expect(result['LastName'], 'Doe');
      expect(result['email'], 'johndoe@example.com');
      expect(result['id'], 'user123');
      expect(result['ProfileImagePath'], '/path/to/profile/image.jpg');
      expect(result['UserType'], 'Teacher');
    });
  });
}
