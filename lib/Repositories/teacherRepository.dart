import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';

abstract class TeacherRepository {
  setTeacherInfo(Teacherinfo teacher);
  Future<Teacherinfo?> getTeacher(String teacherId);
  Future<List<Teacherinfo>> fetchTeacherInfoListBySubject(String subject);
}

class FirebaseTeacherRepository implements TeacherRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<Teacherinfo> getTeacher(String teacherId) async {
    final DocumentSnapshot<Map<String, dynamic>> teacherDoc =
        await db.collection("Teacher Information").doc(teacherId).get();

    return Teacherinfo.fromJson(teacherDoc.data()!);
  }

  @override
  Future<List<Teacherinfo>> fetchTeacherInfoListBySubject(
      String subject) async {
    List<Teacherinfo> teachersInfo = [];
    final QuerySnapshot result =
        await db.collection("Teacher Information").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();

    for (var element in documents) {
      final Teacherinfo teacherInfo = Teacherinfo.fromJson(element.data()!);
      for (int i = 0; i < teacherInfo.subjects.length; i++) {
        if (teacherInfo.subjects[i].trim().toLowerCase() == subject) {
          teachersInfo.add(teacherInfo);
          break;
        }
      }
    }

    return teachersInfo;
  }

  @override
  setTeacherInfo(Teacherinfo teacher) async {
    await db
        .collection("Teacher Information")
        .doc(teacher.id)
        .set(teacher.toJson());
  }
}
