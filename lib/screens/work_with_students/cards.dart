import 'package:flutter/material.dart';

class DataCardBase {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;

  DataCardBase({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
  });
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
    required this.date,
    required this.address,
    required this.phone,
    required this.status
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
  );

  Card returnGenInfoCard(){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("$id");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$date',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '$phone',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                '$address',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              status ?
              Row(
                children: [
                  SizedBox(height: 8),
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
    required this.endDate,
    required this.institutionName,
    required this.averageScore,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
  );

  Card returnEduData(){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("$id");
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
              Text(
                  'Закінчив: $institutionName, \n $endDate \n з середнім балом: $averageScore'
              )



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
    required this.serviceStartDate,
    required this.serviceEndDate,
    required this.serviceUnit,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
  );

  Card returnArmyData() {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("$id");
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
              Text(
                  'Служба в ЗСУ з  $serviceStartDate $serviceEndDate \n Підрозділ $serviceUnit'
              )


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
  );

  Card returnJobActivityData() {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("$id");
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

  ParentsInfoDataCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required this.father,
    required this.fathers_phone,
    required this.mother,
    required this.mothers_phone,
    required this.note

  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
  );

  Card returnParentsInfoCards() {
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print("$id");
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
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Примітка: $note',
                            style: TextStyle(fontStyle: FontStyle.italic)
                        )
                      ]
                  )
              )


            ],
          ),
        ),
      ),
    );
  }
}