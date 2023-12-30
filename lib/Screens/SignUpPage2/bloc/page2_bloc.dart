import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Models/studentInfoModel.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';
import 'package:tutor_bud/Utils/constants.dart';

part 'page2_event.dart';
part 'page2_state.dart';

class Page2Bloc extends Bloc<Page2Event, Page2State> {
  Page2Bloc() : super(Page2Initial()) {
    on<Page2InitialEvent>(page2InitialEvent);
    on<SignUpbuttonTeacherClickedEvent>(signUpbuttonTeacherClickedEvent);
    on<SignUpbuttonStudentClickedEvent>(signUpbuttonStudentClickedEvent);
  }

  FutureOr<void> page2InitialEvent(
      Page2InitialEvent event, Emitter<Page2State> emit) {
    emit(Page2LoadingState());
    emit(Page2LoadedState());
  }

  FutureOr<void> signUpbuttonTeacherClickedEvent(
      SignUpbuttonTeacherClickedEvent event, Emitter<Page2State> emit) async {
    emit(Page2LoadingState());
    TeacherInfoRepo.teacherInfoRepo.setTeacherInfo(event.teacher);
    Future.delayed(const Duration(seconds: 1));
    emit(NavigateToLoginPageState());
  }

  Future<FutureOr<void>> signUpbuttonStudentClickedEvent(SignUpbuttonStudentClickedEvent event, Emitter<Page2State> emit) async {
    
    await StudentInfoRepo.studentInfoRepo.setStudentInfo(event.studentinfo);
    emit(Page2LoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(NavigateToLoginPageState());
    });
    
    
  }
}
