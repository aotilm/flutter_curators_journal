import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:test_journal/MySqlConnection.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  String name = '';

  Future<void> connection() async {
    final connHandler = MySqlConnectionHandler(); // Створюємо об'єкт MySqlConnectionHandler

    await connHandler.connect(); // Підключаємося до бази даних
    // await connHandler.update();  // Виконуємо оновлення
    // Get records
    List<Map<String, dynamic>> records = await connHandler.selectGenInfo();

    // Output the records
    for (var record in records) {
      print('ID: ${record['id']} ${record['second_name']}, ');
    }

    await connHandler.close();
  }

  void workWithStudents(){
    Navigator.pushNamed(context, '/work_with_students');
  }

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
                onPressed: workWithStudents,
                child:
                Text("Робота з студентами")
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: connection,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}