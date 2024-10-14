import 'dart:developer';

import 'package:mysql_client/mysql_client.dart';

class MySqlConnectionHandler {
  final String _host = "192.168.0.106";
  // final String _host = "192.168.191.28";

  // final String _host = "192.168.1.108";

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
      // var result = await _connection!.execute("SELECT * FROM general_info");

      var result = await _connection!.execute('''
        SELECT s.id, s.second_name, s.first_name, s.middle_name, s.group, 
               gi.phone_number, gi.date, gi.address, gi.status
        FROM students s 
        JOIN general_info gi ON s.id = gi.id_student;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectEduData() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {
      // var result = await _connection!.execute("SELECT * FROM general_info");

      var result = await _connection!.execute('''
        SELECT s.id, s.second_name, s.first_name, s.middle_name, 
               ed.average_score, ed.end_date, ed.institution_name
        FROM students s 
        JOIN education_data ed ON s.id = ed.id_student;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectServInArmyData() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT s.id, s.second_name, s.first_name, s.middle_name, 
               sia.start_date, sia.end_date, sia.unit
        FROM students s 
        JOIN service_in_army sia ON s.id = sia.id_student;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectJobActivityData() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT s.id, s.second_name, s.first_name, s.middle_name, 
               ja.end_date, ja.start_date, ja.place, ja.job_position, ja.phone_number
        FROM students s 
        JOIN job_activity ja ON s.id = ja.id_student;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectParentsInfoData() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT s.id, s.second_name, s.first_name, s.middle_name, 
               pi.father, pi.fathers_phone, pi.mother, pi.mothers_phone, pi.note
        FROM students s 
        JOIN parents_info pi ON s.id = pi.id_student;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectStudentData() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT * FROM students;
      ''');
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> checkIfExists(int id, String table) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = [];

    try {
      var result = await _connection!.execute(
          'SELECT * FROM $table WHERE id_student = :id_student',
          {'id_student': id}
      );

      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }
    return records;

  }

  Future<void> insertGenInfo(String phone, String date, String address, bool status, int id) async {
    if (_connection == null) {
      print('No database connection found.');
    }
    
    try {
      var result = await _connection!.execute(
         '''
            INSERT INTO 
            general_info (phone_number, date, address, status, id_student) 
            VALUES (:phone, :date, :address, :status, :id);
         ''',
          {
            'phone': phone,
            'date': date,
            'address': address,
            'status': status,
            'id': id
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }
  Future<void> updateGenInfo(int id, String phoneNumber, String date, String address) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE general_info
      SET
        phone_number = :phone_number,  
        date = :date,          
        address = :address        
      WHERE id_student = :id;       
      ''',
          {
            'phone_number': phoneNumber,
            'date': date,
            'address': address,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }

  Future<void> updateEduData(int id, String institutionName, String endDate, String averageScore) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
          UPDATE education_data
          SET
            institution_name = :institution_name,  
            end_date = :end_date,          
            average_score = :average_score        
          WHERE id_student = :id;       
      ''',
          {
            'institution_name': institutionName,
            'end_date': endDate,
            'average_score': averageScore,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertEduDate(String endDate, String institutionName, String averageScore, int id) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            education_data (end_date, institution_name, average_score, id_student) 
            VALUES (:end_date, :institution_name, :average_score, :id_student);
         ''',
          {
            'end_date': endDate,
            'institution_name': institutionName,
            'average_score': averageScore,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateArmyServ(int id, String startDate, String endDate, String unit) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
          UPDATE service_in_army
          SET
            start_date = :start_date,  
            end_date = :end_date,          
            unit = :unit        
          WHERE id_student = :id;       
      ''',
          {
            'start_date': startDate,
            'end_date': endDate,
            'unit': unit,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertArmyServ(String endDate, String startDate, String unit, int id) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            service_in_army (end_date, start_date, unit, id_student) 
            VALUES (:end_date, :start_date, :unit, :id_student);
         ''',
          {
            'end_date': endDate,
            'start_date': startDate,
            'unit': unit,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateJobActivity(int id, String startDate, String endDate, String place, String jobPosition, String phoneNumber) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE job_activity
      SET
        start_date = :start_date,  
        end_date = :end_date,          
        place = :place,  -- Added missing comma
        job_position = :job_position,  -- Added missing comma
        phone_number = :phone_number
      WHERE id_student = :id;       
    ''',
          {
            'start_date': startDate,
            'end_date': endDate,
            'place': place,
            'job_position': jobPosition,
            'phone_number': phoneNumber,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertJobActivity(int id, String startDate, String endDate, String place, String jobPosition, String phoneNumber) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            job_activity (end_date, start_date, phone_number, place, job_position, id_student) 
            VALUES (:end_date, :start_date, :phone_number, :place, :job_position, :id_student);
         ''',
          {
            'end_date': endDate,
            'start_date': startDate,
            'phone_number': phoneNumber,
            'place': place,
            'job_position': jobPosition,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateParentsInfo(int id, String father, String fathersPhone, String mother, String mothersPhone, String note) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE parents_info
      SET
        father = :father,  
        fathers_phone = :fathersPhone,          
        mother = :mother,  
        mothers_phone = :mothersPhone, 
        note = :note
      WHERE id_student = :id;       
    ''',
          {
            'father': father,
            'fathersPhone': fathersPhone,
            'mother': mother,
            'mothers_phone': mothersPhone,
            'note': note,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertParentsInfo(int id, String father, String fathersPhone, String mother, String mothersPhone, String note) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            parents_info (father, fathers_phone, mother, mothers_phone, note, id_student) 
            VALUES (:father, :fathers_phone, :mother, :mothers_phone, :note, :id_student);
         ''',
          {
            'father': father,
            'fathers_phone': fathersPhone,
            'mother': mother,
            'mothers_phone': mothersPhone,
            'note': note,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
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

