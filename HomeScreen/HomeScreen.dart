import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Screens/ProfileScreen/profileScreen.dart';
import 'package:tuition_app_project/Screens/userListProfileScreen/userListProfileScreen.dart';
import 'package:tuition_app_project/Widgets/HomeScreenStudent.dart';
import 'package:tuition_app_project/Widgets/HomeScreenTeacher.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenStudent.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenTeacher.dart';
import 'package:tuition_app_project/Widgets/UsersScreen.dart';
import 'package:tuition_app_project/Widgets/bottomNavigationBar.dart';
import '../LearnScreen/learnScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    homeBloc.add(HomeInitialEvent(FirebaseAuth.instance.currentUser!.uid));
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeNavigateToLearnScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => learnScreen(
                        studentId: state.id,
                        studentName: state.studentName,
                        studentPicturePath: state.imagepath,
                      )));
        } else if (state is HomeNavigateToListProfileScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => userListProfileScreen(
                      id: state.id,
                      fullname: state.fullname,
                      imagepath: state.imagepath,
                      userType: state.userType)));
        } else if (state is HomeNavigateToProfileScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => profileScreen(User: state.User)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Scaffold(
            backgroundColor: Colors.cyan[100],
            bottomNavigationBar: bottomNavigationBar(
                index: state.selectedIndex,
                homeBloc: homeBloc,
                userType: "Users"),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadedState) {
          switch (state.selectedIndex) {
            case 0:
              {
                if (state.User.UserType == "Student") {
                  return HomeScreenStudent(
                      homeBloc: homeBloc,
                      User: state.User,
                      bottomNavigationBarIndex: state.selectedIndex,
                      acceptedMeetings: state.acceptedMeetings,
                      teachers: state.Teachers);
                } else {
                  return HomeScreenTeacher(
                      homeBloc: homeBloc,
                      User: state.User,
                      bottomNavigationBarIndex: state.selectedIndex,
                      acceptedMeetings: state.acceptedMeetings,
                      students: state.Students);
                }
              }

            case 1:
              {
                if (state.User.UserType == "Student") {
                  return MeetingsScreenStudent(
                      homeBloc: homeBloc,
                      bottomNavigationBarIndex: state.selectedIndex,
                      meetingHistory: state.meetingHistory);
                } else {
                  return MeetingsScreenTeacher(
                      homeBloc: homeBloc,
                      bottomNavigationBarIndex: state.selectedIndex,
                      meetingRequests: state.meetingRequests);
                }
              }
            case 2:
              {
                return usersScreen(homeBloc: homeBloc, state: state);
              }
            default:
              {
                //statements;
                return Scaffold(
                  backgroundColor: Colors.cyan[100],
                  body: const Center(
                      child: Text(
                    "Something went wrong",
                    style: TextStyle(fontSize: 20),
                  )),
                );
              }
          }
        } else {
          return Container();
        }
      },
    );
  }
}
