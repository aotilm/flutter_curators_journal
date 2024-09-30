import 'package:mysql_client/mysql_client.dart';

class MySqlConnectionHandler {
  final String _host = "10.0.2.2";
  final int _port = 3306;
  final String _userName = "root";
  final String _password = "123456";
  final String _databaseName = "journal";

  MySQLConnection? _connection;

  // Функція для підключення до бази даних
  Future<void> connect() async {
    try {
      // Замість створення нової локальної змінної, призначаємо значення полю класу
      _connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _userName,
        password: _password,
        databaseName: _databaseName,
      );

      await _connection!.connect();
      print('Successfully connected to the database.');
    } catch (e) {
      print('Error connecting to the database: $e');
    }
  }

  Future<List<Map<String, dynamic>>> selectGenInfo() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {
      var result = await _connection!.execute("SELECT * FROM general_info");
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  // Виконання SQL-запиту на оновлення
  Future<void> update() async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
        "UPDATE book SET name = :name WHERE id = :id",
        {'name': 'Zaid', 'id': 1}, // Параметри запиту
      );
      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }

  // Функція для закриття з'єднання
  Future<void> close() async {
    if (_connection != null) {
      await _connection!.close();
      print('Connection closed.');
    }
  }
}

