part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpInitialEvent extends SignUpEvent {
  final String selectedValue;
  final bool hide;
  SignUpInitialEvent({required this.selectedValue, required this.hide});
}

class DropDownValueChangedEvent extends SignUpEvent {
  final String selectedValue;
  final String image;
  final bool hide;
  DropDownValueChangedEvent(
      {required this.selectedValue, required this.image, required this.hide});
}

class ImagePickerEvent extends SignUpEvent {
  final String selectedValue;
  final bool hide;
  ImagePickerEvent({required this.selectedValue, required this.hide});
}

class BackArrowIconClickedEvent extends SignUpEvent {
  BuildContext context;
  BackArrowIconClickedEvent({required this.context});
}

class SignUpNextButtonClickedEvent extends SignUpEvent {}

class SignUpButtonClickedEvent extends SignUpEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String imagePath;
  final String userType;

  SignUpButtonClickedEvent(
      {required this.context,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.imagePath,
      required this.userType});
}

class SignUpHideButtonClickedEvent extends SignUpEvent {
  final bool hide;
  final String selectedValue;
  final String image;

  SignUpHideButtonClickedEvent(
      {required this.hide, required this.selectedValue, required this.image});
}
