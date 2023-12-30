part of 'page2_bloc.dart';

@immutable
abstract class Page2Event {}

class Page2InitialEvent extends Page2Event {}

class SignUpbuttonTeacherClickedEvent extends Page2Event {
  final Teacherinfo teacher;

  SignUpbuttonTeacherClickedEvent({required this.teacher});
}

class SignUpbuttonStudentClickedEvent extends Page2Event {
  final Studentinfo studentinfo;

  SignUpbuttonStudentClickedEvent({required this.studentinfo});
}
