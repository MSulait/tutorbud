import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Models/studentInfoModel.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';
import 'package:tutor_bud/Models/userModel.dart';
import 'package:tutor_bud/Utils/constants.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileInitialEvent>(myProfileInitialEvent);
  }

  FutureOr<void> myProfileInitialEvent(MyProfileInitialEvent event, Emitter<MyProfileState> emit) async{

    emit(MyProfileLoadingState());
    if (event.User.UserType == "Student") {
      Studentinfo studentinfo =
          await StudentInfoRepo.studentInfoRepo.getStudentInfo(event.User.id);

      
    }
    else{
      Teacherinfo teacherinfo =
          await TeacherInfoRepo.teacherInfoRepo.getTeacher(event.User.id);
      emit(MyProfileLoadedState(studentinfo: null, teacherinfo: teacherinfo, avgRating: 0,));
    }
  }
}
