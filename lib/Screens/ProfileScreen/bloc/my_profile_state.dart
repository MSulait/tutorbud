part of 'my_profile_bloc.dart';

@immutable
abstract class MyProfileState {}

class MyProfileInitial extends MyProfileState {}

abstract class MyProfileActionState extends MyProfileState {}

class MyProfileInitialState extends MyProfileState {}

class MyProfileLoadingState extends MyProfileState {}

class MyProfileLoadedState extends MyProfileState {
  final Studentinfo? studentinfo;
  final Teacherinfo? teacherinfo;
  final double avgRating;

  MyProfileLoadedState(
      {required this.studentinfo,
      required this.teacherinfo,
      required this.avgRating});
}
