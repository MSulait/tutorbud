import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Utils/constants.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<DropDownValueChangedEvent>(dropDownValueChangedEvent);
    on<ImagePickerEvent>(imagePickerEvent);
    on<BackArrowIconClickedEvent>(backArrowIconClickedEvent);
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignUpHideButtonClickedEvent>(signUpHideButtonClickedEvent);
  }

  FutureOr<void> signUpInitialEvent(
      SignUpInitialEvent event, Emitter<SignUpState> emit) {
    emit(SignUpLoadingState());
    emit(SignUpLoadedSuccessfulState(
        selectedValue: event.selectedValue, image: "", hide: event.hide));
  }

  FutureOr<void> dropDownValueChangedEvent(
      DropDownValueChangedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpLoadedSuccessfulState(
        selectedValue: event.selectedValue,
        image: event.image,
        hide: event.hide));
  }

  FutureOr<void> imagePickerEvent(
      ImagePickerEvent event, Emitter<SignUpState> emit) async {
    final imagePicker = ImagePicker();
    final XFile? PickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (PickedImage != null) {
      var path = PickedImage.path;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageReference =
          storage.ref().child('Profile Pictures/${IDgenerator.uuid.v4()}');
      final UploadTask uploadTask = storageReference.putFile(File(path));
      await uploadTask.whenComplete(() async {
        String downloadUrl = await storageReference.getDownloadURL();
        emit(SignUpLoadedSuccessfulState(
            selectedValue: event.selectedValue,
            image: downloadUrl,
            hide: event.hide));
      });
    } else {
      emit(SignUpLoadedSuccessfulState(
          selectedValue: event.selectedValue, image: "", hide: event.hide));
    }
  }

  FutureOr<void> backArrowIconClickedEvent(
      BackArrowIconClickedEvent event, Emitter<SignUpState> emit) {
    Navigator.pop(event.context);
    emit(NavigateToLoginScreenState());
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) {
    auth.signUp(event.context, event.email, event.password, event.firstName,
        event.lastName, event.imagePath, event.userType);
  }


  FutureOr<void> signUpHideButtonClickedEvent(
      SignUpHideButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpLoadedSuccessfulState(
        hide: !event.hide,
        image: event.image,
        selectedValue: event.selectedValue));
  }
}
