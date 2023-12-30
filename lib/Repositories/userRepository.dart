import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  getUser(String userId);
  Future<List<user>> fetchTeacherList();
  Future<List<user>> fetchStudentList();
}

class FirebaseUserRepository implements UserRepository {
  final db = FirebaseFirestore.instance;
  late user User;

  @override
  setuser(user User) async {
    await db.collection("Users").doc(User.id).set(User.toJson());

    if (User.UserType == "Student") {
      await db.collection("Students").doc(User.id).set(User.toJson());
    } else {
      await db.collection("Teachers").doc(User.id).set(User.toJson());
    }
  }

  @override
  getUser(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
    await db.collection("Users").doc(userId).get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      if (userData != null) {
        User = user.fromJson(userData);
      } else {
        // Handle the case where userData is null
        User = user(
          first_name: 'Sulait',
          last_name: 'Sufian',
          email: 'sulaitsufian@gmail.com',
          id: userId,
          ProfileImagePath: 'none',
          UserType: 'teacher',

        );
      }
    } else {

      User = user(
        first_name: 'Sulait',
        last_name: 'Sufian',
        email: 'sulaitsufian@gmail.com',
        id: userId,
        ProfileImagePath: 'none',
        UserType: 'teacher',

      );
    }
  }

  @override
  Future<List<user>> fetchTeacherList() async {
    List<user> teachers = [];
    final QuerySnapshot result = await db.collection("Teachers").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
    result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      teachers.add(user.fromJson(element.data()!));
    }
    return teachers;
  }

  @override
  Future<List<user>> fetchStudentList() async {
    List<user> students = [];
    final QuerySnapshot result = await db.collection("Students").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
    result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      students.add(user.fromJson(element.data()!));
    }
    return students;
  }
}
