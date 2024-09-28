import 'package:flutter/material.dart';
import 'package:test_journal/screens/home_page.dart';
import 'package:test_journal/screens/work_with_students/screens/activity.dart';
import 'package:test_journal/screens/work_with_students/screens/general_information.dart';
import 'package:test_journal/screens/work_with_students/work_with_students.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goddamn journal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: CardTheme(
          // color: Theme.of(context).cardColor,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        ),

        appBarTheme: AppBarTheme(
          // backgroundColor: Theme.of(context).primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20
          )
        )
      ),
      initialRoute: '/work_with_students',
      routes: {
        '/': (context) => HomePage(),
        '/work_with_students': (context) => WorkWithStudents(),
        '/general_information': (context) => GeneralInformation(),
        '/activity': (context) => Activity()
      },
    );
  }
}


