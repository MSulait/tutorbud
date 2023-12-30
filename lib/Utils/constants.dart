import 'package:tutor_bud/Repositories/studentRepository.dart';
import 'package:tutor_bud/Repositories/teacherRepository.dart';
import 'package:tutor_bud/Repositories/userRepository.dart';
import 'package:uuid/uuid.dart';

class Userrepo{
  static final FirebaseUserRepository userRepo = FirebaseUserRepository();
}


class StudentInfoRepo{
  static final FirebaseStudentRepository studentInfoRepo = FirebaseStudentRepository();
}

class TeacherInfoRepo{
  static final FirebaseTeacherRepository teacherInfoRepo = FirebaseTeacherRepository();
}

class IDgenerator{
  static const uuid = Uuid();
}