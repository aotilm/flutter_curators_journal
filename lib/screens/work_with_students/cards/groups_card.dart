import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/curators_work_with_students.dart';
import '../curator_screens/all_student_info.dart';

class GroupsCard {
  final int id;
  final String groupName;
  final String curator;
  final String profession;


  GroupsCard({
    required this.id,
    required this.groupName,
    required this.curator,
    required this.profession,
  });

  Card returnGroupCard(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CuratorsWorkWithStudents(
                group: groupName,
              )
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   'Запис №$id',
              //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              // ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 6),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Куратор: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: curator)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Спеціальність: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: profession)
                      ]
                  )
              ),
            ],

          ),
        ),
      ),
    );
  }

}