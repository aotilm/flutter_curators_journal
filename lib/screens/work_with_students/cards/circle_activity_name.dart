import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

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
