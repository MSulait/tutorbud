import 'package:flutter/material.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';

class bottomNavigationBar extends StatelessWidget {
  final int index;
  final HomeBloc homeBloc;
  final String userType;
  const bottomNavigationBar(
      {super.key,
      required this.index,
      required this.homeBloc,
      required this.userType});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreenAccent,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.greenAccent),
        BottomNavigationBarItem(
            icon: const Icon(Icons.class_outlined),
            label: 'Meeting Requests',
            backgroundColor: Colors.greenAccent),
        BottomNavigationBarItem(
            icon: const Icon(Icons.account_box),
            label: "Users",
            backgroundColor: Colors.greenAccent)
      ],
      selectedItemColor:  Colors.green,
      currentIndex: index,
      onTap: (value) {
        switch (value) {
          case 0:
            homeBloc.add(BottomNavigationBarItemHomeClickedEvent());
            break;
          case 1:
            homeBloc.add(BottomNavigationBarItemMeetingsClickedEvent());
            break;
          case 2:
            if (userType == "Student") {
              homeBloc.add(BottomNavigationBarItemTeachersClickedEvent());
            }
            else{
              homeBloc.add(BottomNavigationBarItemStudentsClickedEvent());
            }
        }
      },
    );
  }
}
