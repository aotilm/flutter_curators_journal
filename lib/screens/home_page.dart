import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:mysql_client/mysql_client.dart';
// import 'package:test_journal/MySqlConnection.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Сurators Journal'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$name',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FilledButton(
                onPressed: () => Navigator.pushNamed(context, '/work_with_students'),
                child:
                Text("Робота з студентами")
            ),
            FilledButton(
                // onPressed: () => Navigator.pushReplacementNamed(context, '/admin_work_with_students'),
                onPressed: () => Navigator.pushNamed(context, '/admin_work_with_students'),
                child:
                Text("Робота з студентами Admin")
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}