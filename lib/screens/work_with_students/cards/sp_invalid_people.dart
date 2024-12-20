import 'package:flutter/material.dart';
import '../edit_form.dart';
import 'data_card_base.dart';

class SpInvalidPeople extends DataCardBase {
  // final String session;
  final String category;
  final String startDate;
  final String endDate;
  final String invalidCategory;

  // final String note;



  SpInvalidPeople({
    required int id,
    required String firstName,
    required String lastName,
    required String middleName,
    required bool showName,
    // required this.session,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.invalidCategory
    // required this.note,
  }) : super(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      showName: showName
  );

  Card returnSpInvalidPeopleCard(context){
    return Card(

      child:
      InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => EditForm(
          //       id: id,
          //       selectedValue: "Соціальний паспорт",
          //       action: true,
          //     ),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showName ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            text: 'Категорія: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: category)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Група інвалідності: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: invalidCategory)
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
                        TextSpan(text: startDate)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата кінця: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: endDate)
                      ]
                  )
              ),
              // note.isNotEmpty ?
              // Text.rich(
              //     TextSpan(
              //         text: 'Примітка: $note',
              //         style: TextStyle(fontStyle: FontStyle.italic)
              //     )
              // ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
