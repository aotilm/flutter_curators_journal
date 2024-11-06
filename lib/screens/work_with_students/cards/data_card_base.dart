import 'package:flutter/material.dart';
import '../curator_screens/all_student_info.dart';

class DataCardBase {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final bool showName;


  DataCardBase({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.showName
  });

  Card returnCard(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllStudentInfo(
                id: id,
                firstName: firstName,
                lastName: lastName,
                middleName: middleName,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Запис №$id',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$lastName $firstName $middleName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
    );
  }

}