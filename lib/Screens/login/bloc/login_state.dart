part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedSuccessfulState extends LoginState {
  final bool hide;

  LoginLoadedSuccessfulState({required this.hide});
}

class NavigatetoSignUpState extends LoginActionState {}
