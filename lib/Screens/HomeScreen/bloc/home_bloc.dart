import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_bud/Repositories/userRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tutor_bud/Models/userModel.dart';

import '../../../Utils/constants.dart';
part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<BottomNavigationBarItemHomeClickedEvent>(
        bottomNavigationBarItemHomeClickedEvent);

    on<BottomNavigationBarItemMeetingsClickedEvent>(
        bottomNavigationBarItemMeetingsClickedEvent);

    on<BottomNavigationBarItemTeachersClickedEvent>(
        bottomNavigationBarItemTeachersClickedEvent);

    on<BottomNavigationBarItemStudentsClickedEvent>(
        bottomNavigationBarItemStudentsClickedEvent);

    on<LearnButtonClickedEvent>(learnButtonClickedEvent);

    on<ListItemClickedEvent>(listItemClickedEvent);

    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);

    on<ProfileButtonClickedEvent>(profileButtonClickedEvent);

  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    await Userrepo.userRepo.getUser(event.id);

    if (Userrepo.userRepo.User.UserType == "Teacher") {
      List<user> students = await Userrepo.userRepo.fetchStudentList();




    } else {
      List<user> teachers = await Userrepo.userRepo.fetchTeacherList();




    }
  }

  Future<FutureOr<void>> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    if (Userrepo.userRepo.User.UserType == "Teacher") {
      List<user> students = await Userrepo.userRepo.fetchStudentList();



    } else {
      List<user> teachers = await Userrepo.userRepo.fetchTeacherList();


    }
  }

  Future<FutureOr<void>> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(1));

  }

  Future<FutureOr<void>> bottomNavigationBarItemTeachersClickedEvent(
      BottomNavigationBarItemTeachersClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(2));
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    emit(HomeLoadedState(2, teachers, Userrepo.userRepo.User, const [],
        const []));
  }

  Future<FutureOr<void>> bottomNavigationBarItemStudentsClickedEvent(
      BottomNavigationBarItemStudentsClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(2));
    List<user> students = await Userrepo.userRepo.fetchStudentList();
    emit(HomeLoadedState(2, const [], Userrepo.userRepo.User, const [], students));
  }

  FutureOr<void> learnButtonClickedEvent(
      LearnButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToLearnScreenState(
        id: event.studentId,
        studentName: event.studentName,
        imagepath: event.imagepath));
  }

  FutureOr<void> listItemClickedEvent(
      ListItemClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToListProfileScreenState(
        id: event.id,
        imagepath: event.imagepath,
        fullname: event.fullname,
        userType: event.userType));
  }



  Future<FutureOr<void>> signOutButtonClickedEvent(
      SignOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    Future.delayed(const Duration(seconds: 1), () async {
      await FirebaseAuth.instance.signOut();
    });
  }

  FutureOr<void> profileButtonClickedEvent(
      ProfileButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToProfileScreenState(User: event.User));
  }

}
