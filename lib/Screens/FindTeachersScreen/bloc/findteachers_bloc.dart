import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Models/teacherInfoModel.dart';
import 'package:tutor_bud/Models/userModel.dart';
import 'package:tutor_bud/Utils/constants.dart';

part 'findteachers_event.dart';
part 'findteachers_state.dart';

class FindteachersBloc extends Bloc<FindteachersEvent, FindteachersState> {
  FindteachersBloc() : super(FindteachersInitial()) {
    on<FindTeachersInitialEvent>(findTeachersInitialEvent);
  }

  FutureOr<void> findTeachersInitialEvent(
      FindTeachersInitialEvent event, Emitter<FindteachersState> emit) async {
    emit(FindTeachersLoadingState());
    List<user> teacherslist = [];
    
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    List<Teacherinfo> teachersinfo = await TeacherInfoRepo.teacherInfoRepo
        .fetchTeacherInfoListBySubject(event.subject);
    if (teachersinfo.isEmpty) {
      emit(FindTeachersErrorState(message: "No teachers found"));
    } else {
      for (int i = 0; i < teachers.length; i++) {
        for (int j = 0; j < teachersinfo.length; j++) {
          if (teachers[i].id == teachersinfo[j].id) {
            teacherslist.add(teachers[i]);
            break;
          }
        }
      }
      List<bool> teacherRequestSent =
          List.generate(teacherslist.length, (index) => false);
      List<double> teacherRatings = [];

      emit(FindTeachersLoadedSuccessState(
          teachers: teacherslist, teacherRequestSent: teacherRequestSent, teacherRatings: teacherRatings));
    }
  }

}
