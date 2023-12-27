import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Auth.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Widgets/loginbutton.dart';
import 'package:tuition_app_project/Screens/signUp/signUp.dart';

import '../../Widgets/textFormField.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = Auth();
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    loginBloc.add(LoginInitialEvent());
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/12188678_4907157.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          listenWhen: (previous, current) => current is LoginActionState,
          buildWhen: (previous, current) => current is! LoginActionState,
          listener: (context, state) {
            if (state is NavigatetoSignUpState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoadedSuccessfulState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(100, 5, 5, 5),
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
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 50,
                              right: 50,
                              top: 80,
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              obscureText: false,
                              validator: (value) {
                                // Validation logic here
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 50,
                              right: 50,
                              top: 20,
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              obscureText: true,
                              validator: (value) {
                                // Validation logic here
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 50,
                              right: 50,
                              top: 250,
                            ),
                            child: login_button(
                              formkey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                              loginBloc: loginBloc,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 290,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    loginBloc.add(JoinNowButtonClickedEvent());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
