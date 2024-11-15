import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import '../cards/cards.dart';
import '../../../MySqlConnection.dart';
class Activity extends StatefulWidget {
  const Activity({super.key, required this.group});

  final String group;

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  Future<List<SocialActivityCard>> returnSocialActivityCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectSocialActivity(widget.group); //
    List<SocialActivityCard> dataCards = [];//

    for (var record in records) {
      final card = SocialActivityCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          session: record['session'] ?? 'no',
          date: record['date'] ?? 'No',
          activity: record['activity'] ?? 'No',
          showName: true
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<CircleActivityCard>> returnCircleActivityCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectCircleActivity(widget.group); //
    List<CircleActivityCard> dataCards = [];//

    for (var record in records) {
      final card = CircleActivityCard(//
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        session: record['session'] ?? 'no',
        circleName: record['circle_name'] ?? 'No',
        note: record['note'] ?? 'No',
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
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Громадська діяльність', style: headerStyle),
            content: FutureBuilder<List<SocialActivityCard>>(
              future: returnSocialActivityCards(),
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
                    return card.returnSocialActivityCards(context);
                  }).toList(),
                );
              },
            ),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Гурткова діяльність', style: headerStyle),
            // content: Text('hello'),
            content: FutureBuilder<List<CircleActivityCard>>(
              future: returnCircleActivityCards(),
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
                    return card.returnCircleActivityCards(context);
                  }).toList(),
                );
              },
            ),
          ),
        ]
    );
  }
}
