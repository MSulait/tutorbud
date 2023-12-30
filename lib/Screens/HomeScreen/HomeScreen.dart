import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_bud/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tutor_bud/Screens/ProfileScreen/profileScreen.dart';
import 'package:tutor_bud/Screens/userListProfileScreen/userListProfileScreen.dart';
import 'package:tutor_bud/Widgets/HomeScreenStudent.dart';
import 'package:tutor_bud/Widgets/HomeScreenTeacher.dart';
import 'package:tutor_bud/Widgets/UsersScreen.dart';
import 'package:tutor_bud/Widgets/bottomNavigationBar.dart';
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
            backgroundColor: Colors.white,
            bottomNavigationBar: bottomNavigationBar(
              index: state.selectedIndex,
              homeBloc: homeBloc,
              userType: "Users",
            ),
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
                    teachers: state.Teachers,
                  );
                } else {
                  return HomeScreenTeacher(
                    homeBloc: homeBloc,
                    User: state.User,
                    bottomNavigationBarIndex: state.selectedIndex,
                    students: state.Students,
                  );
                }
              }

            case 1:
              {
                return usersScreen(homeBloc: homeBloc, state: state);
              }
            default:
              {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: const Center(
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
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
