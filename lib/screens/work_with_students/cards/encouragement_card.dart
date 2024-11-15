import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

class EncouragementCard extends DataCardBase {
  final String session;
  final String date;
  final String content;


  EncouragementCard({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    required this.session,
    required this.date,
    required this.content,
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
