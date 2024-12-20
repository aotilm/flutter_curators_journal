import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:test_journal/screens/work_with_students/cards/groups_card.dart';
import '../../../../MySqlConnection.dart';
import '../table/student.dart';
// import 'package:file_picker/file_picker.dart';


class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {

  Future<List<Student>> getExcelStudentData() async {
    List<Student> studentsList = [];


    var bytes = await rootBundle.load('assets/student.xlsx');
    var excel = Excel.decodeBytes(bytes.buffer.asUint8List());

    var firstSheetKey = excel.tables.keys.first;
    var sheet = excel.tables[firstSheetKey]!;
    for (var row in sheet.rows.skip(1)) {
      if (row.every((cell) => cell == null || cell.value == null || cell.value.toString().trim().isEmpty)) {
        continue;
      }

      var firstName = row[0]?.value;
      var lastName = row[1]?.value;
      var middleName = row[2]?.value;
      var group = row[3]?.value;
      var student = Student(firstName: firstName.toString(), secondName: lastName.toString(), middleName: middleName.toString(), group: group.toString());
      studentsList.add(student);
      // print('$i Імя: $column1, Прізвище: $column2, По батькові: $column3, Група: $column4');
    }
    log('Читання завершено');
    return studentsList;
  }

  Future<List<GroupsCard>> returnCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectGroups(); //
    List<GroupsCard> dataCards = [];//

    for (var record in records) {
      final card = GroupsCard(
        id: int.parse(record['id'].toString()),
        groupName: record['group_name'] ?? 'No',
        curator: record['curator'] ?? 'No',
        profession: record['profession'] ?? 'No',

      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //
      //     // final connHandler = MySqlConnectionHandler();
      //     // await connHandler.connect();
      //     // List<Student> students = await returnExcelStudentData();
      //     // await connHandler.insertStudent(students);
      //     // await connHandler.close();
      //
      //   },
      //   label: Text('Імпорт'),
      //   icon: Icon(Icons.add),
      //
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<GroupsCard>>(
              future: returnCards(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data found');
                }

                return Column(
                  children: snapshot.data!.map<Widget>((card) {
                    return card.returnGroupCard(context);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
