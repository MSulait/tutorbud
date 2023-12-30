part of 'learn_bloc.dart';

@immutable
abstract class LearnState {}

abstract class LearnActionState extends LearnState {}

class LearnInitial extends LearnState {}

class LearnLoadingState extends LearnState {}

class LearnLoadedSuccessState extends LearnState {}

class NavigatetoFindTeacherScreenState extends LearnActionState {
  final String studentId;
  final String studentName;
  final String imagepath;
  final String subject;
  final String topic;
  final String note;

  NavigatetoFindTeacherScreenState(
      {required this.studentId,
      required this.subject,
      required this.topic,
      required this.note,
      required this.studentName,
      required this.imagepath});
}
