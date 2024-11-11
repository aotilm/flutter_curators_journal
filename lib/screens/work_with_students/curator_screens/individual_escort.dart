import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import '../cards/cards.dart';
import '../../../MySqlConnection.dart';

class IndividualEscort extends StatefulWidget {
  const IndividualEscort({super.key, required this.group});
  final String group;

  @override
  State<IndividualEscort> createState() => _IndividualEscortState();
}

class _IndividualEscortState extends State<IndividualEscort> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  Future<List<IndividualEscortCard>> returnIndividualEscortCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectIndividualEscort(widget.group); //
    List<IndividualEscortCard> dataCards = [];//

    for (var record in records) {
      final card = IndividualEscortCard(//
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
            header: const Text('Індивідуальний супровід', style: headerStyle),
            content: FutureBuilder<List<IndividualEscortCard>>(
              future: returnIndividualEscortCards(),
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
                    return card.returnIndividualEscortCard(context);
                  }).toList(),
                );
              },
            ),
          ),
        ]
    );
  }
}
