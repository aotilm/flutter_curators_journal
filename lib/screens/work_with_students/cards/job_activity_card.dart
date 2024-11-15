import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

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