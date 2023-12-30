import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_bud/Models/studentInfoModel.dart';

abstract class StudentRepository {
  setStudentInfo(Studentinfo studentinfo);
  Future<Studentinfo?> getStudentInfo(String studentId);
}

class FirebaseStudentRepository implements StudentRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<Studentinfo> getStudentInfo(String studentId) async {
    final DocumentSnapshot<Map<String, dynamic>> studentDoc =
        await db.collection("Student Information").doc(studentId).get();

    return Studentinfo.fromJson(studentDoc.data()!);
  }

  @override
  setStudentInfo(Studentinfo studentinfo) async {
    await db
        .collection("Student Information")
        .doc(studentinfo.id)
        .set(studentinfo.toJson());
  }
}
