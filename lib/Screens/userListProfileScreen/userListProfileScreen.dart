import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'bloc/profile_bloc.dart';

class userListProfileScreen extends StatelessWidget {
  final String id;
  final String userType;
  final String imagepath;
  final String fullname;

  userListProfileScreen(
      {super.key,
      required this.id,
      required this.imagepath,
      required this.fullname,
      required this.userType});

  final ProfileBloc profileBloc = ProfileBloc();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    profileBloc.add(ProfileInitialEvent(
        id: id,
        imagepath: imagepath,
        fullname: fullname,
        userType: userType,
        initialRating: 0.0));
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
          ),
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
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listenWhen: (previous, current) => current is ProfileActionState,
        buildWhen: (previous, current) => current is! ProfileActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      radius: 60,
                      foregroundImage: NetworkImage(state.imagepath),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    state.fullname,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.qualification,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),

                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text("Phone Number: ${state.phoneNumber}",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 17),
                        )),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text("Age: ${state.age}",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 17),
                        )),
                  ),
                  state.subjects!.isNotEmpty
                      ? ListTile(
                          leading: const Icon(Icons.subject),
                          title: Text(
                            "Subjects: ${state.subjects.toString().substring(1, state.subjects.toString().length - 1)}",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 17),
                            ),
                          ))
                      : const SizedBox(height: 0),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Text("About: ${state.description}",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 17),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: Colors.blue,
                        border: Border.all(
                            color: const Color.fromARGB(255, 3, 66, 102),
                            width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            "Rate Teacher: ",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 17),
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: state.initialRating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              _rating = rating;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              if (state.subjects!.isNotEmpty) {
                                profileBloc.add(NewRatingEvent(
                                    fullname: fullname,
                                    subjects: state.subjects,
                                    age: state.age,
                                    qualification: state.qualification,
                                    description: state.description,
                                    rating: _rating,
                                    userId: id,
                                    imagepath: imagepath,
                                    initialRating: 0.0,
                                    phoneNumber: state.phoneNumber));
                              } else {
                                profileBloc.add(NewRatingEvent(
                                    fullname: fullname,
                                    subjects: const [],
                                    age: state.age,
                                    qualification: state.qualification,
                                    description: state.description,
                                    rating: _rating,
                                    userId: id,
                                    imagepath: imagepath,
                                    initialRating: 0.0,
                                    phoneNumber: state.phoneNumber));
                              }
                            },
                            child: Text(
                              "Submit Rating",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 3, 66, 102),
                                    fontSize: 17),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
