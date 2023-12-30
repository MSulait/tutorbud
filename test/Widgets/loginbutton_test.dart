import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutor_bud/Screens/login/bloc/login_bloc.dart';
import 'package:tutor_bud/Widgets/loginbutton.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockloginBloc;

  setUp(() {
    mockloginBloc = MockLoginBloc();
  });

  testWidgets('loginButton widget ...', (tester) async {
    // TODO: Implement test

    final GlobalKey<FormState> formkey = MockFormState();
    final TextEditingController emailController = MockemailEditingController();
    final TextEditingController passwordController =
        MockpasswordEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: login_button(
            formkey: formkey,
            emailController: emailController,
            passwordController: passwordController,
            loginBloc: mockloginBloc),
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

class MockFormState extends GlobalKey<FormState> {
  MockFormState() : super.constructor();
}
