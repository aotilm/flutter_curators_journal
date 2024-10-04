import 'package:flutter/material.dart';

class DataCards extends StatelessWidget {
  DataCards.general({
    required this.type,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.date,
    required this.address,
    required this.phone,
    required this.status,
  })  : end_date = '',
        institution_name = '',
        average_score = 0;

  // Іменований конструктор для даних про освіту
  DataCards.education({
    required this.type,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.end_date,
    required this.institution_name,
    required this.average_score,
  })  : date = '',
        address = '',
        phone = '',
        status = false;

  final int type;

  final int id;

  final String firstName;
  final String lastName;
  final String middleName;

  // загальна інформація
  final String date;
  final String address;
  final String phone;
  final bool status;

  // дані про освіту
  final String end_date;
  final String institution_name;
  final double average_score;


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
               'Закінчив: $institution_name, \n $end_date \n з середнім балом: $average_score'
             )



            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 1:
        return returnGenInfoCard();
      case 2:
        return returnEduData();
      default:
        return Center(
            child:  Text("default!")
        );
    }
  }
}