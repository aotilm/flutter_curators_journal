import 'package:flutter/material.dart';
// import 'package:test_journal/screens/home_page.dart';
import 'package:test_journal/screens/login_page.dart';
import 'package:test_journal/screens/work_with_students/admin_work_with_students.dart';
// import 'package:test_journal/screens/work_with_students/curator_screens/activity.dart';
// import 'package:test_journal/screens/work_with_students/curator_screens/general_information.dart';
import 'package:test_journal/screens/work_with_students/curators_work_with_students.dart';
// import 'package:test_journal/screens/work_with_students/edit_form.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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
        ),
      ),
      locale: const Locale('uk', 'UA'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('uk', 'UA'),
        const Locale('en', 'US'),
      ],
      initialRoute: '/',
      routes: {
        // '/': (context) => HomePage(),
        '/': (context) => LoginPage(),
        '/work_with_students': (context) => CuratorsWorkWithStudents(group: '2-КТ-21',),
        '/admin_work_with_students': (context) => AdminWorkWithStudents(),
        // '/general_information': (context) => GeneralInformation(),
        // '/activity': (context) => Activity(),
        // '/edit_form': (context) => EditForm(id: 1, firstName: 'Muravets', lastName: 'Illia', middleName: 'Andiryovich')
      },
    );
  }
}


