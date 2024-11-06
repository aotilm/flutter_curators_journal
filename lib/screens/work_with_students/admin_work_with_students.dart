import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/admin_screens/students/groups.dart';

class AdminWorkWithStudents extends StatefulWidget {
  const AdminWorkWithStudents({super.key});

  @override
  State<AdminWorkWithStudents> createState() => _AdminWorkWithStudentsState();
}

class _AdminWorkWithStudentsState extends State<AdminWorkWithStudents> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Сторінка адміністратора"),
        backgroundColor: Theme.of(context).colorScheme.primary,

      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.people, color: Colors.white,),
            icon: Icon(Icons.people),
            label: 'Групи',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.white,),
            icon: Icon(Icons.person),
            label: 'Куратори',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list_alt, color: Colors.white,),
            icon: Icon(Icons.list_alt),
            label: 'План роботи',
          ),
        ],
      ),

      body: <Widget>[
        Groups(),
        Text('2'),
        Text('3'),
      ][currentPageIndex]
    );
  }

}
