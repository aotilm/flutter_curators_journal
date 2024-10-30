import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

import '../../../MySqlConnection.dart';
import '../cards.dart';

class SocialPassport extends StatefulWidget {
  const SocialPassport({super.key});

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
          idActivity: 0,
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


  @override
  Widget build(BuildContext context) {
    return Accordion(
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
                  FutureBuilder<List<SocialPassportCard>>(
                    future: returnSocialPassportCard(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No data found');
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnSocialPassportCard(context);
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
