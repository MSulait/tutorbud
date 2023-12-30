part of 'learn_bloc.dart';

@immutable
abstract class LearnEvent {}

class LearnInitialEvent extends LearnEvent {
}

class FindTeacherButtonClickedEvent extends LearnEvent {
  final String studentId;
  final String studentName;
  final String imagepath;
  final String subject;
  final String topic;
  final String note;

  FindTeacherButtonClickedEvent({required this.studentId, required this.imagepath, required this.studentName,required this.subject, required this.topic, required this.note});
}
