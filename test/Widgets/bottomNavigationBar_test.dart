import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutor_bud/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tutor_bud/Widgets/bottomNavigationBar.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('bottomNavigationBar ...', (tester) async {
    // TODO: Implement test

    final int index = 0;

    final String userType = "Teacher";

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: bottomNavigationBar(
            index: index, homeBloc: mockhomeBloc, userType: userType),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text("Home"), findsOneWidget);
    expect(find.text("Meeting Requests"), findsOneWidget);
    expect(find.text("Users"), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.class_outlined), findsOneWidget);
    expect(find.byIcon(Icons.account_box), findsOneWidget);
  });
}
