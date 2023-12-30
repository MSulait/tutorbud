import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tutor_bud/Models/userModel.dart';
import 'package:tutor_bud/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tutor_bud/Widgets/sideDrawer.dart';
import 'package:tutor_bud/Widgets/TopRateduserList.dart';
import 'bottomNavigationBar.dart';

class HomeScreenStudent extends StatelessWidget {
  final HomeBloc homeBloc;
  final user User;
  final int bottomNavigationBarIndex;
  final List<user> teachers;
  const HomeScreenStudent({super.key, required this.homeBloc, required this.User, required this.bottomNavigationBarIndex, required this.teachers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(

            child: Row(
              children: [
                Text(
                  'Tutor',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
                Text(
                  'Bud',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.green,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Opacity(
              opacity: 0,
              child: Icon(Icons.transform_sharp),
            ),
          )
        ],
        backgroundColor: Colors.white70,
        elevation: 2,
      ),
      drawer: side_drawer(User: User, homeBloc: homeBloc,),
      bottomNavigationBar:
          bottomNavigationBar(index: bottomNavigationBarIndex, homeBloc: homeBloc, userType: "Student",),
      body: ListView(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            color:  Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "Get Ready to Learn",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                          User.first_name,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.green,
                                fontSize: 25),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 7,
                      ),
                      child: Text(User.last_name,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.green,
                                fontSize: 25),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    text: "Your Scheduled Meetings",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 10),
              child: RichText(
                text: TextSpan(
                    text: "Top Rated Teachers",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: userList(
              teachers: teachers,
              students: const [],
              homebloc: homeBloc,
            ),
          )

        ],
      ),
    );
    
  }
}
