import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Models/userModel.dart';
import 'Screens/SignUpPage2/signupPage2.dart';
import 'Utils/constants.dart';

class Auth {

  Future signIn(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const AlertDialog(
                  content: Text("No user found for that email.")));
        } else if (e.code == 'wrong-password') {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const AlertDialog(
                  content: Text("Wrong password provided for that user.")));
        }
      }
    }
  }

  Future signUp(
      BuildContext context,
      String email,
      String password,
      String firstName,
      String lastName,
      String imagePath,
      String userType) async {
    bool signedUp = true;
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      signedUp = false;
      Navigator.pop(context);
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const AlertDialog(
                  content: Text("The password provided is too weak.")));
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const AlertDialog(
                  content: Text("The account already exists for that email.")));
        }
      }
    }

    if (signedUp) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      var User = user(
          first_name: firstName,
          last_name: lastName,
          email: email,
          id: id,
          ProfileImagePath: imagePath,
          UserType: userType);
      await Userrepo.userRepo.setuser(User);
      await FirebaseAuth.instance.signOut();
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => signupPage2(id: id, userType: userType,)));
      
    }
  }
}
