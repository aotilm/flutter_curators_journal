import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:test_journal/screens/work_with_students/cards/cards.dart';

import '../../../MySqlConnection.dart';


class Encouragement extends StatefulWidget {
  const Encouragement({super.key, required this.group});
  final String group;
  @override
  State<Encouragement> createState() => _EncouragementState();
}

class _EncouragementState extends State<Encouragement> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  Future<List<EncouragementCard>> returnEncuragementCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectEncouragement(widget.group); //
    List<EncouragementCard> dataCards = [];//

    for (var record in records) {
      final card = EncouragementCard(//
          id: int.parse(record['id'].toString()),
          idActivity: 0,
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          session: record['session'] ?? 'no',
          date: record['date'] ?? 'No',
          content: record['content'] ?? 'No',
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
        disableScrolling: true,
        scaleWhenAnimating: false,
        children: [
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Заохочення', style: headerStyle),
            content: Column(
              children: [
                FutureBuilder<List<EncouragementCard>>(
                  future: returnEncuragementCards(),
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
                        return card.returnEncouragementCard(context);
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 10,)
              ],
            )
          ),
        ]
    );
  }
}
