import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

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