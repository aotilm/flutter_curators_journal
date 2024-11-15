import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

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