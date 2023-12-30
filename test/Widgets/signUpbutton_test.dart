import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutor_bud/Screens/signUp/bloc/sign_up_bloc.dart';
import 'package:tutor_bud/Widgets/signUpbutton.dart';

class MockSignUpBloc extends Mock implements SignUpBloc {}

void main() {
  late MockSignUpBloc mockSignUpBloc;

  setUp(() {
    mockSignUpBloc = MockSignUpBloc();
  });

  testWidgets('SignUpButton widget ...', (tester) async {
    // TODO: Implement test

    final GlobalKey<FormState> formkey = MockFormState();
    final TextEditingController emailController = MockemailEditingController();
    final TextEditingController passwordController =
        MockpasswordEditingController();
    final TextEditingController firstNameController =
        MockfirstNameEditingController();
    final TextEditingController lastNameController =
        MocklastNameEditingController();

    final String imagePath = "image";
    final String userType = "Student";



    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: signUp_button(
            formkey: formkey,
            emailController: emailController,
            passwordController: passwordController,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            imagePath: imagePath,
            userType: userType,
            signUpBloc: mockSignUpBloc),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}

class MockemailEditingController extends TextEditingController {
  @override
  String get text => "email";
}

class MockpasswordEditingController extends TextEditingController {
  @override
  String get text => "password";
}

class MockfirstNameEditingController extends TextEditingController {
  @override
  String get text => "first name";
}

class MocklastNameEditingController extends TextEditingController {
  @override
  String get text => "last name";
}

class MockFormState extends GlobalKey<FormState> {
  MockFormState() : super.constructor();
}
