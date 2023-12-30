part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {
  final String id;
  final String imagepath;
  final String fullname;
  final String userType;
  final double initialRating;
  ProfileInitialEvent(
      {required this.id,
      required this.imagepath,
      required this.fullname,
      required this.userType,
      required this.initialRating});
}

class NewRatingEvent extends ProfileEvent {
  final double rating;
  final String userId;
  final String imagepath;
  final String fullname;
  final String age;
  final String qualification;
  final List<String>? subjects;
  final String description;
  final double initialRating;
  final String phoneNumber;
  NewRatingEvent(
      {required this.rating,
      required this.userId,
      required this.imagepath,
      required this.fullname,
      required this.age,
      required this.qualification,
      required this.subjects,
      required this.description,
      required this.initialRating,
      required this.phoneNumber});
}
