import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Models/studentInfoModel.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';
import 'package:tutor_bud/Utils/constants.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
  }

  FutureOr<void> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    if (event.userType == "Teacher") {
      Teacherinfo teacherinfo =
          await TeacherInfoRepo.teacherInfoRepo.getTeacher(event.id);
      emit(ProfileLoadedState(
          fullname: event.fullname,
          imagepath: event.imagepath,
          age: teacherinfo.age,
          qualification: teacherinfo.qualification,
          subjects: teacherinfo.subjects,
          description: teacherinfo.description,
          initialRating: 0,
          phoneNumber: teacherinfo.phoneNumber));
    } else {
      Studentinfo studentinfo =
          await StudentInfoRepo.studentInfoRepo.getStudentInfo(event.id);
      emit(ProfileLoadedState(
          fullname: event.fullname,
          imagepath: event.imagepath,
          age: studentinfo.age,
          qualification: studentinfo.qualification,
          subjects: const [],
          description: studentinfo.description,
          initialRating: event.initialRating,
          phoneNumber: studentinfo.phoneNumber));
    }
  }

  }

