part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class JoinNowButtonClickedEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;
  LoginButtonClickedEvent(
      {required this.context, required this.email, required this.password});
}

class PasswordHideButtonClickedEvent extends LoginEvent {
  final bool hide;

  PasswordHideButtonClickedEvent({required this.hide});
}
