part of 'page2_bloc.dart';

@immutable
abstract class Page2State {}

abstract class Page2ActionState extends Page2State {}

class Page2Initial extends Page2State {}

class Page2LoadingState extends Page2State {}

class Page2LoadedState extends Page2State {}

class NavigateToLoginPageState extends Page2ActionState {}
