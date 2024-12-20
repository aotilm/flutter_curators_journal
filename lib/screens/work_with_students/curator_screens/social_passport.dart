import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:test_journal/screens/work_with_students/cards/sp_default.dart';

import '../../../MySqlConnection.dart';
import '../cards/cards.dart';
import '../cards/sp_chornobyltsi.dart';
import '../cards/sp_invalid_people.dart';
import '../cards/sp_many_children.dart';

class SocialPassport extends StatefulWidget {
  const SocialPassport({super.key, required this.group});
  final String group;

  @override
  State<SocialPassport> createState() => _SocialPassportState();
}

class _SocialPassportState extends State<SocialPassport> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  Future<List<SocialPassportCard>> returnSocialPassportCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSocialPassport(); //
    List<SocialPassportCard> dataCards = [];//

    for (var record in records) {
      final card = SocialPassportCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          session: record['session'] ?? 'no',
          category: record['category'] ?? 'no',
          startDate: record['start_date'] ?? 'no',
          endDate: record['end_date'] ?? 'no',
          note: record['note'] ?? 'no',
          showName: true
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<SpDefaultCard>> returnSpDefaultCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSpDefault(widget.group); //
    List<SpDefaultCard> dataCards = [];//

    for (var record in records) {
      final card = SpDefaultCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          category: record['category'] ?? 'no',
          startDate: record['start_date'] ?? 'no',
          endDate: record['end_date'] ?? 'no',
          showName: true
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<SpManyChildren>> returnSpManyChildrenCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSpManyChildren(widget.group); //
    List<SpManyChildren> dataCards = [];//

    for (var record in records) {
      final card = SpManyChildren(//
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        category: record['category'] ?? 'no',
        startDate: record['start_date'] ?? 'no',
        endDate: record['end_date'] ?? 'no',
        numberOfChildren: record['number_of_children'] ?? 'no',
        lessThan18: record['less_than_18'] ?? 'no',
        moreThan18Studying: record['more_than_18_studying'] ?? 'no',
        showName: true,
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<SpInvalidPeople>> returnSpIvalidPeopleCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSpInvalidPeople(widget.group); //
    List<SpInvalidPeople> dataCards = [];//

    for (var record in records) {
      final card = SpInvalidPeople(//
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        category: record['category'] ?? 'no',
        startDate: record['start_date'] ?? 'no',
        endDate: record['end_date'] ?? 'no',
        invalidCategory: record['invalid_group'] ?? 'no',
        showName: true,
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<SpChornobyltsi>> returnSpChornobyltsiCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSpChornobyltsi(widget.group); //
    List<SpChornobyltsi> dataCards = [];//

    for (var record in records) {
      final card = SpChornobyltsi(//
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        category: record['category'] ?? 'no',
        startDate: record['start_date'] ?? 'no',
        endDate: record['end_date'] ?? 'no',
        chornobylCategory: record['group'] ?? 'no',
        showName: true,
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }


  @override
  Widget build(BuildContext context) {
    return Accordion(
        disableScrolling: true,
        scaleWhenAnimating: false,
        children: [
          AccordionSection(
              isOpen: true,
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Соціальний паспорт', style: headerStyle),
              content: Column(
                children: [
                  // FutureBuilder<List<SocialPassportCard>>(
                  //   future: returnSocialPassportCard(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return CircularProgressIndicator();
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return Text('No data found');
                  //     }
                  //
                  //     return Column(
                  //       children: snapshot.data!.map<Widget>((card) {
                  //         return card.returnSocialPassportCard(context);
                  //       }).toList(),
                  //     );
                  //   },
                  // ),
                  FutureBuilder<List<SpDefaultCard>>(
                    future: returnSpDefaultCard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnSpDefaultCard(context);
                        }).toList(),
                      );
                    },
                  ),
                  FutureBuilder<List<SpManyChildren>>(
                    future: returnSpManyChildrenCard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnSpManyChildrenCard(context);
                        }).toList(),
                      );
                    },
                  ),
                  FutureBuilder<List<SpInvalidPeople>>(
                    future: returnSpIvalidPeopleCard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnSpInvalidPeopleCard(context);
                        }).toList(),
                      );
                    },
                  ),
                  FutureBuilder<List<SpChornobyltsi>>(
                    future: returnSpChornobyltsiCard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnSpChornobyltsiCard(context);
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 10,)
                ],
              )
          ),
        ]
    );;
  }
}
