import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  String name = '';

  Future<void> connection() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "10.0.2.2",
      port: 3306,
      userName: "illia",
      password: "123456",
      databaseName: "journal", // optional
    );

    await conn.connect();

    print("Connected");

    var result = await conn.execute("SELECT name FROM book WHERE id = 2");
    for (final row in result.rows) {
      print(row.assoc());
      setState(() {
        name = row.assoc().toString();
      });
    }
    // update some rows
    var res = await conn.execute(
      "UPDATE book SET name = :name",
      {"name": "changed name"},
    );

    print(res.affectedRows);
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