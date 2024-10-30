import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/all_student_info.dart';
import 'package:test_journal/screens/work_with_students/edit_form.dart';

import '../../MySqlConnection.dart';

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

class GeneralDataCard extends DataCardBase {
  final String date;
  final String address;
  final String phone;
  final bool status;

  GeneralDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.date,
    required this.address,
    required this.phone,
    required this.status,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnGenInfoCard(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                selectedValue: "Загальні дані",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата народження: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: date)
                      ]
                  )
              ),
              SizedBox(height: 3),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Номер телефону: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: phone)
                      ]
                  )
              ),
              SizedBox(height: 3),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Адреса проживання: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: address)
                      ]
                  )
              ),
              SizedBox(height: 8),

              status ?
              Row(
                children: [
                  Text(
                    'Вибув',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ): Container()


            ],
          ),
        ),
      ),
    );
  }
}

class EducationDataCard extends DataCardBase {
  final String endDate;
  final String institutionName;
  final double averageScore;

  EducationDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.endDate,
    required this.institutionName,
    required this.averageScore,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName

  );

  Card returnEduData(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                selectedValue: "Дані про освіту",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Закінчив навчальний заклад: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: institutionName)
                      ]
                  ),
              ),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата закінчення: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: endDate)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Cередній бал: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: averageScore.toString())
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

class ArmyServiceDataCard extends DataCardBase {
  final String serviceStartDate;
  final String serviceEndDate;
  final String serviceUnit;


  ArmyServiceDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.serviceStartDate,
    required this.serviceEndDate,
    required this.serviceUnit,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnArmyData(context) {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                selectedValue: "Служба в ЗСУ",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Запис №$id',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$lastName $firstName $middleName',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                    ],
                  ) : Container(),
              Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                          text: 'Служба в ЗСУ з: ',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(text: '$serviceStartDate - $serviceEndDate'),
                    ]
                ),
              ),
              Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                          text: 'Підрозділ: ',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(text: serviceUnit)
                    ]
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}

class JobActivityDataCard extends DataCardBase {
  final String phone_number;
  final String start_date;
  final String end_date;
  final String place;
  final String job_position;

  JobActivityDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.end_date,
    required this.start_date,
    required this.job_position,
    required this.phone_number,
    required this.place

  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnJobActivityData(context) {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                selectedValue: "Трудова діяльність",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Місце роботи: ',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(text: '$place')
                  ]
                )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Посада: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$job_position')
                      ]
                  )
              ),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата початку: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$start_date')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата закінчення: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$end_date')
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

class ParentsInfoDataCard extends DataCardBase {
  final String father;
  final String fathers_phone;
  final String mother;
  final String mothers_phone;
  final String note;
  final int idTable;

  ParentsInfoDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.father,
    required this.fathers_phone,
    required this.mother,
    required this.mothers_phone,
    required this.note,
    required this.idTable

  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnParentsInfoCards(context) {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idTable,
                selectedValue: "Інформація про батьків",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ): Container(),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Батько: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$father')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Тел.: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$fathers_phone')
                      ]
                  )
              ),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Мати: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$mother')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Тел.: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$mothers_phone')
                      ]
                  )
              ),
              note.isNotEmpty ?
              Text.rich(
                  TextSpan(
                      text: 'Примітка: $note',
                      style: TextStyle(fontStyle: FontStyle.italic)
                  )
              ) : Container()


            ],
          ),
        ),
      ),
    );
  }
}

class SocialActivityCard extends DataCardBase {
  final int idActivity;
  final String session;
  final String date;
  final String activity;

  SocialActivityCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.idActivity,
    required this.session,
    required this.date,
    required this.activity,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnSocialActivityCards(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idActivity,
                selectedValue: "Громадська діяльність",
                action: true,
              ),
            ),
          );

        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Семестр №:',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$session')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$date')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Діяльність: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$activity')
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

class CircleActivityCard extends DataCardBase  {
  final String session;
  final String circleName;
  final String note;
  final int idActivity;

  CircleActivityCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.session,
    required this.circleName,
    required this.note,
    required this.idActivity
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnCircleActivityCards(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idActivity,
                selectedValue: "Гурткова діяльність",
                action: true,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Семестр №:',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$session')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Назва гуртка: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$circleName')
                      ]
                  )
              ),
              note.isNotEmpty ?
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Нотатка: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$note')
                      ]
                  )
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class IndividualEscortCard extends DataCardBase {
  final String session;
  final String date;
  final String content;
  final int idActivity;


  IndividualEscortCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.session,
    required this.date,
    required this.content,
    required this.idActivity
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    showName: showName
  );

  Card returnIndividualEscortCard(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idActivity,
                selectedValue: "Індивідуальний супровід",
                action: true,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Семестр №: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$session')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: date)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Зміст: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: content)
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

class EncouragementCard extends DataCardBase {
  final String session;
  final String date;
  final String content;
  final int idActivity;


  EncouragementCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.session,
    required this.date,
    required this.content,
    required this.idActivity
  }) : super(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      showName: showName
  );

  Card returnEncouragementCard(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idActivity,
                selectedValue: "Заохочення",
                action: true,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Семестр №: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$session')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: date)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Зміст: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: content)
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

class SocialPassportCard extends DataCardBase {
  final String session;
  final String category;
  final String startDate;
  final String endDate;
  final String note;

  final int idActivity;


  SocialPassportCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.session,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.note,
    required this.idActivity
  }) : super(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      showName: showName
  );

  Card returnSocialPassportCard(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: idActivity,
                selectedValue: "Соціальний паспорт",
                action: true,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$lastName $firstName $middleName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ) : Container(),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Семестр №: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: '$session')
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Категорія: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: category)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата початку: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: startDate)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата кінця: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: endDate)
                      ]
                  )
              ),
              note.isNotEmpty ?
              Text.rich(
                  TextSpan(
                      text: 'Примітка: $note',
                      style: TextStyle(fontStyle: FontStyle.italic)
                  )
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}



class WorkPlanCard {
  final int id;
  final int session;
  final String eventName;
  final String executionDate;
  final String executor;
  final bool isDone;
  final bool adminConfirmation;

  WorkPlanCard({
    required this.id,
    required this.session,
    required this.eventName,
    required this.executionDate,
    required this.executor,
    required this.isDone,
    required this.adminConfirmation
  });

  Card returnWorkPlanCard(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          !adminConfirmation ?
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: id,
                selectedValue: 'План роботи',
                action: true,
              ),
            ),
          ): null;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Запис №$id',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Семестр №$session',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
              ),

              SizedBox(height: 6),
              Text(
                '$eventName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата виконання: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: executionDate)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Виконавець: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: executor)
                      ]
                  )
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'Підтвердження від адміністратора: ',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  adminConfirmation ? Icon(Icons.done, color: Colors.green) : Icon(Icons.close, color: Colors.red)
                ],
              ),
              Row(
                children: [
                  Text(
                    'Cтатус виконання заходу: ',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  isDone ? Icon(Icons.done, color: Colors.green) : Icon(Icons.close, color: Colors.red)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

