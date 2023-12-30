part of 'my_profile_bloc.dart';

@immutable
abstract class MyProfileEvent {}

class MyProfileInitialEvent extends MyProfileEvent {
  final user User;

  MyProfileInitialEvent(this.User);
}
