import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

class ParentsInfoDataCard extends DataCardBase {
  final String father;
  final String fathers_phone;
  final String mother;
  final String mothers_phone;
  final String note;
  // final int idTable;

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
    // required this.idTable

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
                selectedValue: "Інформація про батьків",
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