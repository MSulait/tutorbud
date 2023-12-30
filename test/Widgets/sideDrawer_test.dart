import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tutor_bud/Models/userModel.dart';
import 'package:tutor_bud/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tutor_bud/Widgets/sideDrawer.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('sideDrawer widget ...', (tester) async {
    // TODO: Implement test

    final user User = user(
        first_name: "john",
        last_name: "doe",
        email: "john@gmail.com",
        id: "123",
        ProfileImagePath: "image",
        UserType: "Student");


    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: side_drawer(User: User, homeBloc: mockhomeBloc),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text("${User.first_name} ${User.last_name}"),
          findsOneWidget);

      expect(find.text("Profile"),
          findsOneWidget);
      
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
      
    });
  });
}
