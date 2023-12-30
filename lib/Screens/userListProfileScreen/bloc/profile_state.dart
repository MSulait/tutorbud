part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

abstract class ProfileActionState extends ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String fullname;
  final String imagepath;
  final String age;
  final String qualification;
  final List<String>? subjects;
  final String description;
  final double initialRating;
  final String phoneNumber;

  ProfileLoadedState(
      {required this.fullname,
      required this.imagepath,
      required this.age,
      required this.qualification,
      required this.subjects,
      required this.description,
      required this.initialRating,
      required this.phoneNumber});
}
