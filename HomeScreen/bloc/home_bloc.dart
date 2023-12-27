import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Utils/constants.dart';

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

    on<MeetingRequestTickButtonClickedEvent>(
        meetingRequestTickButtonClickedEvent);

    on<MeetingRequestCrossButtonClickedEvent>(
        meetingRequestCrossButtonClickedEvent);

    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);

    on<ProfileButtonClickedEvent>(profileButtonClickedEvent);

    on<EndMeetingButtonClickedEvent>(endMeetingButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    await Userrepo.userRepo.getUser(event.id);

    if (Userrepo.userRepo.User.UserType == "Teacher") {
      List<user> students = await Userrepo.userRepo.fetchStudentList();

      List<user> topRatedStudents = [];

      for (int i = 0; i < students.length; i++) {
        double avgRating =
            await Userrepo.userRepo.getAvgUserRating(students[i].id);
        if (avgRating >= 4) {
          topRatedStudents.add(students[i]);
        }
      }
      List<meetingAcceptedModel> acceptedMeetings = await MeetingRequestRepo
          .meetingRequestRepo
          .fetchAcceptedMeetingList(event.id, Userrepo.userRepo.User.UserType);
      emit(HomeLoadedState(0, const [], Userrepo.userRepo.User, const [],
          acceptedMeetings, const [], topRatedStudents));
    } else {
      List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
      List<user> topRatedTeachers = [];
      for (int i = 0; i < teachers.length; i++) {
        double avgRating =
            await Userrepo.userRepo.getAvgUserRating(teachers[i].id);
        if (avgRating >= 4) {
          topRatedTeachers.add(teachers[i]);
        }
      }

      List<meetingAcceptedModel> acceptedMeetings = await MeetingRequestRepo
          .meetingRequestRepo
          .fetchAcceptedMeetingList(event.id, Userrepo.userRepo.User.UserType);

      emit(HomeLoadedState(0, topRatedTeachers, Userrepo.userRepo.User,
          const [], acceptedMeetings, const [], const []));
    }
  }

  Future<FutureOr<void>> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    List<meetingAcceptedModel> acceptedMeetings =
        await MeetingRequestRepo.meetingRequestRepo.fetchAcceptedMeetingList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    if (Userrepo.userRepo.User.UserType == "Teacher") {
      List<user> students = await Userrepo.userRepo.fetchStudentList();

      List<user> topRatedStudents = [];

      for (int i = 0; i < students.length; i++) {
        double avgRating =
            await Userrepo.userRepo.getAvgUserRating(students[i].id);
        if (avgRating >= 4) {
          topRatedStudents.add(students[i]);
        }
      }

      emit(HomeLoadedState(0, const [], Userrepo.userRepo.User, const [],
          acceptedMeetings, const [], topRatedStudents));
    } else {
      List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
      List<user> topRatedTeachers = [];
      for (int i = 0; i < teachers.length; i++) {
        double avgRating =
            await Userrepo.userRepo.getAvgUserRating(teachers[i].id);
        if (avgRating >= 4) {
          topRatedTeachers.add(teachers[i]);
        }
      }

      emit(HomeLoadedState(0, topRatedTeachers, Userrepo.userRepo.User,
          const [], acceptedMeetings, const [], const []));
    }
  }

  Future<FutureOr<void>> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(1));
    List<meetingRequestModel> meetingRequests = [];
    List<meetingRequestModel> meetingHistory = [];
    meetingRequests = await MeetingRequestRepo.meetingRequestRepo
        .fetchMeetingRequestList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    meetingHistory = await MeetingRequestRepo.meetingRequestRepo
        .fetchMeetingHistoryList(Userrepo.userRepo.User.id);

    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], meetingHistory, const []));
  }

  Future<FutureOr<void>> bottomNavigationBarItemTeachersClickedEvent(
      BottomNavigationBarItemTeachersClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(2));
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    emit(HomeLoadedState(2, teachers, Userrepo.userRepo.User, const [],
        const [], const [], const []));
  }

  Future<FutureOr<void>> bottomNavigationBarItemStudentsClickedEvent(
      BottomNavigationBarItemStudentsClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(2));
    List<user> students = await Userrepo.userRepo.fetchStudentList();
    emit(HomeLoadedState(2, const [], Userrepo.userRepo.User, const [],
        const [], const [], students));
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

  FutureOr<void> meetingRequestTickButtonClickedEvent(
      MeetingRequestTickButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    await MeetingRequestRepo.meetingRequestRepo
        .deleteMeetingRequest(event.meetingId);
    List<meetingRequestModel> meetingRequests =
        await MeetingRequestRepo.meetingRequestRepo.fetchMeetingRequestList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    meetingAcceptedModel meetingAccepted = meetingAcceptedModel(
      teacherId: event.teacherId,
      studentId: event.studentId,
      studentName: event.studentName,
      meetingId: event.meetingId,
      date: event.date,
      studentimagepath: event.studentimagepath,
      note: event.note,
      subject: event.subject,
      time: event.time,
      topic: event.topic,
      teacherName: event.teacherName,
      teacherimagepath: event.teacherimagepath,
    );
    await MeetingRequestRepo.meetingRequestRepo
        .setAcceptedMeeting(meetingAccepted);
    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], const [], const []));
  }

  Future<FutureOr<void>> meetingRequestCrossButtonClickedEvent(
      MeetingRequestCrossButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    MeetingRequestRepo.meetingRequestRepo.deleteMeetingRequest(event.meetingId);
    List<meetingRequestModel> meetingRequests =
        await MeetingRequestRepo.meetingRequestRepo.fetchMeetingRequestList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], const [], const []));
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

  Future<FutureOr<void>> endMeetingButtonClickedEvent(
      EndMeetingButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    MeetingRequestRepo.meetingRequestRepo
        .deleteAcceptedMeeting(event.meetingId);
    List<meetingAcceptedModel> acceptedMeetings =
        await MeetingRequestRepo.meetingRequestRepo.fetchAcceptedMeetingList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);

    List<user> students = await Userrepo.userRepo.fetchStudentList();

    List<user> topRatedStudents = [];
    for (int i = 0; i < students.length; i++) {
      double avgRating =
          await Userrepo.userRepo.getAvgUserRating(students[i].id);
      if (avgRating >= 2) {
        topRatedStudents.add(students[i]);
      }
    }
    emit(HomeLoadedState(0, const [], Userrepo.userRepo.User, const [],
        acceptedMeetings, const [], topRatedStudents));
  }
}
