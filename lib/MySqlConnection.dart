import 'package:mysql_client/mysql_client.dart';
import 'package:test_journal/screens/work_with_students/admin_screens/table/student.dart';

class MySqlConnectionHandler {
  // final String _host = "192.168.0.109";
  final String _host = "192.168.122.1";
  // final String _host = "192.168.1.10 9";

  final int _port = 3306;
  final String _userName = "root";
  final String _password = "123456";
  final String _databaseName = "journal";

  MySQLConnection? _connection;

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

  Future<bool> loginUser(String user, String pass) async {
    if (_connection == null) {
      print('No database connection found.');
      return false;
    }

    try {
      var result = await _connection!.execute('''
      SELECT * FROM curators WHERE email = :email AND password = :password;
    ''', {
        'email': user,
        'password': pass,
      });

      return result.rows.isNotEmpty;
    } catch (e) {
      print('Select query failed: $e');
      return false; // Повертає false у разі помилки
    }
  }

  Future<List<Map<String, dynamic>>> selectCuratorInfo(String user, String pass) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
      SELECT * FROM curators WHERE email = :email AND password = :password;
    ''', {
        'email': user,
        'password': pass,
      });

      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }


  Future<List<Map<String, dynamic>>> selectGenInfo(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = [];

    try {
      var result = await _connection!.execute('''
        SELECT gi.id, s.second_name, s.first_name, s.middle_name,
               gi.phone_number, gi.date, gi.address, gi.status
        FROM students s 
        JOIN general_info gi ON s.id = gi.id_student
        WHERE s.group = :group;
        ''',
      {'group': group});

      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectEduData(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {
      var result = await _connection!.execute('''
        SELECT ed.id, s.second_name, s.first_name, s.middle_name,
               ed.average_score, ed.end_date, ed.institution_name
        FROM students s 
        JOIN education_data ed ON s.id = ed.id_student 
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectServInArmyData(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT sia.id, s.second_name, s.first_name, s.middle_name, 
               sia.start_date, sia.end_date, sia.unit
        FROM students s 
        JOIN service_in_army sia ON s.id = sia.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectJobActivityData(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT ja.id, s.second_name, s.first_name, s.middle_name,
               ja.end_date, ja.start_date, ja.place, ja.job_position, ja.phone_number
        FROM students s 
        JOIN job_activity ja ON s.id = ja.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectParentsInfoData(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT pi.id, s.second_name, s.first_name, s.middle_name, s.group,
               pi.father, pi.fathers_phone, pi.mother, pi.mothers_phone, pi.note
        FROM students s 
        JOIN parents_info pi ON s.id = pi.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectStudentData(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT * FROM students where `group` = :group order by second_name asc;
      ''',
        {
          'group': group,
        }
      );
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectSocialActivity(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {
      // s.id,
    var result = await _connection!.execute('''
        SELECT s.second_name, s.first_name, s.middle_name, 
               sa.id, sa.session, sa.date, sa.activity
        FROM students s 
        JOIN social_activity sa ON s.id = sa.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectCircleActivity(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT ca.id, s.second_name, s.first_name, s.middle_name, 
               ca.session, ca.circle_name, ca.note
        FROM students s 
        JOIN circle_activity ca ON s.id = ca.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectIndividualEscort(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT ie.id, s.second_name, s.first_name, s.middle_name, 
               ie.session, ie.date, ie.content
        FROM students s 
        JOIN individual_escort ie ON s.id = ie.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectEncouragement(String group) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT e.id, s.second_name, s.first_name, s.middle_name, 
               e.session, e.date, e.content
        FROM students s 
        JOIN encouragement e ON s.id = e.id_student
        WHERE s.group = :group;
        ''',
          {'group': group});
      for (final row in result.rows) {
        var record = row.assoc();
        records.add(record);
      }
    } catch (e) {
      print('Select query failed: $e');
    }

    return records; // Return the list of records
  }

  Future<List<Map<String, dynamic>>> selectSocialPassport() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = []; // List to store records

    try {

      var result = await _connection!.execute('''
        SELECT sp.id, s.second_name, s.first_name, s.middle_name, 
               sp.session, sp.category, sp.start_date, sp.end_date, sp.note
        FROM students s 
        JOIN social_passport sp ON s.id = sp.id_student;
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

  Future<List<Map<String, dynamic>>> selectWorkPlan() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = [];

    try {
      var result = await _connection!.execute(
          'SELECT * FROM work_plan '
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

  Future<List<Map<String, dynamic>>> selectStudentInfoByStId(int id, String table) async {
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
  Future<List<Map<String, dynamic>>> selectStudentInfoByPkId(int id, String table) async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = [];

    try {
      var result = await _connection!.execute(
          'SELECT * FROM $table WHERE id = :id',
          {'id': id}
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

  Future<List<Map<String, dynamic>>> selectGroups() async {
    if (_connection == null) {
      print('No database connection found.');
      return [];
    }

    List<Map<String, dynamic>> records = [];

    try {
      var result = await _connection!.execute(
          'SELECT * FROM `groups`'
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

  Future<void> insertStudent(List<Student> studentsList) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      for(var student in studentsList){
        var result = await _connection!.execute(
            '''
            INSERT INTO 
            students (second_name, first_name, middle_name, `group`) 
            VALUES (:second_name, :first_name, :middle_name, :group);
         ''',
            {
              'second_name': student.secondName,
              'first_name': student.firstName,
              'middle_name': student.middleName,
              'group': student.group
            }
        );
        print(result.affectedRows);
      }
    } catch (e) {
      print('Insert query failed: $e');
    }

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
      WHERE id = :id;       
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
          WHERE id = :id;       
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
          WHERE id = :id;       
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
      WHERE id = :id;       
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
      WHERE id = :id;       
    ''',
          {
            'father': father,
            'fathersPhone': fathersPhone,
            'mother': mother,
            'mothersPhone': mothersPhone,
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

  Future<void> updateSocialActivity(int id, int session, String date, String activity) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE social_activity
      SET
        session = :session,  
        date = :date,          
        activity = :activity
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'date': date,
            'activity': activity,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertSocialActivity(int id, int session, String date, String activity) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            social_activity (session, date, activity, id_student) 
            VALUES (:session, :date, :activity, :id_student);
         ''',
          {
            'session': session,
            'date': date,
            'activity': activity,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateCircleActivity(int id, int session, String circleName, String note) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE circle_activity
      SET
        session = :session,  
        circle_name = :circle_name,          
        note = :note
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'circle_name': circleName,
            'note': note,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertCircleActivity(int id, int session, String circleName, String note) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            circle_activity (session, circle_name, note, id_student) 
            VALUES (:session, :circle_name, :note, :id_student);
         ''',
          {
            'session': session,
            'circle_name': circleName,
            'note': note,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateIndividualEscort(int id, int session, String date, String content) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE individual_escort
      SET
        session = :session,  
        date = :date,          
        content = :content
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'date': date,
            'content': content,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertIndividualEscort(int id, int session, String date, String content) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            individual_escort (session, date, content, id_student) 
            VALUES (:session, :date, :content, :id_student);
         ''',
          {
            'session': session,
            'date': date,
            'content': content,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateEncouragement(int id, int session, String date, String content) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE encouragement
      SET
        session = :session,  
        date = :date,          
        content = :content
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'date': date,
            'content': content,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertEncouragement(int id, int session, String date, String content) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            encouragement (session, date, content, id_student) 
            VALUES (:session, :date, :content, :id_student);
         ''',
          {
            'session': session,
            'date': date,
            'content': content,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateSocialPassport(int id, int session, String category, String startDate, String endDate, String note) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE social_passport
      SET
        session = :session,  
        category = :category,
        start_date = :start_date,
        end_date = :end_date,
        note = :note
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'category': category,
            'start_date': startDate,
            'end_date': endDate,
            'note': note,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertSocialPassport(int id, int session, String category, String startDate, String endDate, String note) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            social_passport (session, category, start_date, end_date, note, id_student) 
            VALUES (:session, :category, :start_date, :end_date, :note, :id_student);
         ''',
          {
            'session': session,
            'category': category,
            'start_date': startDate,
            'end_date': endDate,
            'note': note,
            'id_student': id,
          }
      );

      print(result.affectedRows);
    } catch (e) {
      print('Insert query failed: $e');
    }

  }

  Future<void> updateWorkPlan(int id, int session, String eventName, String executionDate, String executor, bool isDone, bool adminConfirmation) async {
    if (_connection == null) {
      print('No database connection found.');
      return;
    }

    try {
      var result = await _connection!.execute(
          ''' 
      UPDATE work_plan
      SET
        session = :session,  
        event_name = :event_name,
        execution_date = :execution_date,
        executor = :executor,
        isDone = :isDone,
        admin_confirmation = :admin_confirmation
      WHERE id = :id;       
    ''',
          {
            'session': session,
            'event_name': eventName,
            'execution_date': executionDate,
            'executor': executor,
            'isDone': isDone,
            'admin_confirmation': adminConfirmation,
            'id': id
          }
      );

      print('Updated rows: ${result.affectedRows}');
    } catch (e) {
      print('Update query failed: $e');
    }
  }
  Future<void> insertWorkPlan(int session, String eventName, String executionDate, String executor, bool isDone, bool adminConfirmation) async {
    if (_connection == null) {
      print('No database connection found.');
    }

    try {
      var result = await _connection!.execute(
          '''
            INSERT INTO 
            work_plan (session, event_name, execution_date, executor, isDone, admin_confirmation) 
           VALUES (:session, :event_name, :execution_date, :executor, :isDone, :admin_confirmation);
         ''',
          {
            'session': session,
            'event_name': eventName,
            'execution_date': executionDate,
            'executor': executor,
            'isDone': isDone,
            'admin_confirmation': adminConfirmation,
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

