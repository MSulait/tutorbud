part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String id;

  HomeInitialEvent(this.id);
}

class BottomNavigationBarItemHomeClickedEvent extends HomeEvent {}

class BottomNavigationBarItemMeetingsClickedEvent extends HomeEvent {}

class BottomNavigationBarItemTeachersClickedEvent extends HomeEvent {}

class BottomNavigationBarItemStudentsClickedEvent extends HomeEvent {}


class LearnButtonClickedEvent extends HomeEvent {
  final String studentId;
  final String studentName;
  final String imagepath;

  LearnButtonClickedEvent({
    required this.studentId,
    required this.studentName,
    required this.imagepath,
  });
}


class ListItemClickedEvent extends HomeEvent {
  final String id;
  final String imagepath;
  final String fullname;
  final String userType;

  ListItemClickedEvent(
      {required this.id, required this.imagepath, required this.fullname, required this.userType});
}



class SignOutButtonClickedEvent extends HomeEvent {}

class ProfileButtonClickedEvent extends HomeEvent {
  final user User;

  ProfileButtonClickedEvent({
    required this.User,
  });
}

