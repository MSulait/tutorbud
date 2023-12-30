part of 'findteachers_bloc.dart';

@immutable
abstract class FindteachersEvent {}

class FindTeachersInitialEvent extends FindteachersEvent {
  final String subject;

  FindTeachersInitialEvent({required this.subject});
}

class MeetingRequestButtonClickedEvent extends FindteachersEvent {
  final String teacherId;
  final String studentId;
  final String studentName;
  final String Studentimagepath;
  final String subject;
  final String topic;
  final String note;
  final int teacherIndex;
  final String teacherName;
  final List<bool> teacherRequestSent;
  final List<user> teachers;
  final String teacherImagepath;

  MeetingRequestButtonClickedEvent(
      {required this.teacherId,
      required this.studentId,
      required this.subject,
      required this.topic,
      required this.note,
      required this.teacherIndex,
      required this.teacherRequestSent,
      required this.teachers,
      required this.studentName,
      required this.Studentimagepath,
      required this.teacherName,
      required this.teacherImagepath});
}
