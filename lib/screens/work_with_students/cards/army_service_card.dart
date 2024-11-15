import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

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