import 'package:flutter/material.dart';

class DataCards extends StatelessWidget {
  // Конструктор з обов'язковими параметрами
  const DataCards({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.date,
    required this.address,
    required this.phone,
    required this.status,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String date;
  final String address;
  final String phone;
  final bool status;

  @override
  Widget build(BuildContext context) {
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