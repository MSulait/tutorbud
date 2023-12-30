part of 'findteachers_bloc.dart';

@immutable
abstract class FindteachersState {}

abstract class FindteachersActionState extends FindteachersState {}

class FindteachersInitial extends FindteachersState {}

class FindTeachersLoadingState extends FindteachersState {}

class FindTeachersLoadedSuccessState extends FindteachersState {
  final List<user> teachers;
  final List<bool> teacherRequestSent;
  final List<double> teacherRatings;

  FindTeachersLoadedSuccessState(
      {required this.teachers, required this.teacherRequestSent, required this.teacherRatings});
}

class FindTeachersErrorState extends FindteachersState {
  final String message;

  FindTeachersErrorState({required this.message});
}
