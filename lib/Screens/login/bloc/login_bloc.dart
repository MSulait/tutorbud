import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Auth.dart';

part 'login_event.dart';
part 'login_state.dart';

final auth = Auth();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<JoinNowButtonClickedEvent>(joinNowButtonClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<PasswordHideButtonClickedEvent>(passwordHideButtonClickedEvent);
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadedSuccessfulState(hide: true));
  }

  FutureOr<void> joinNowButtonClickedEvent(
      JoinNowButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(NavigatetoSignUpState());
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) {
    auth.signIn(event.context, event.email, event.password);
  }

  FutureOr<void> passwordHideButtonClickedEvent(
      PasswordHideButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadedSuccessfulState(hide: !event.hide));
  }
}
