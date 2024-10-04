import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import '../cards.dart';
import '../../../MySqlConnection.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  static const loremIpsum =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et 
  malorum', a 1st century BC text by the Roman statesman and philosopher Cicero,
   with words altered, added, and removed to make it nonsensical and improper Latin.''';
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  // static const contentStyle = TextStyle(
  //     color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  Future<List<DataCards>> returnGeneralInfoCards() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectGenInfo();
    List<DataCards> generalDataCards = [];

    for (var record in records) {
      final card = DataCards.general(
        type: 1,
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        date: record['date'] ?? 'No Date',
        address: record['address'] ?? 'No Address',
        phone: record['phone_number'] ?? 'No Phone',
        status: record['status'] == '1',
      );

      generalDataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return generalDataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<DataCards>> returnEducationData() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectEduData();
    List<DataCards> generalDataCards = [];

    for (var record in records) {
      final card = DataCards.education(
        type: 2,
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        institution_name: record['institution_name'] ?? 'No',
        end_date: record['end_date'] ?? 'No',
        average_score: double.parse(record['average_score'].toString())
        // average_score: 11.1,
      );

      generalDataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return generalDataCards; // Return the list of GeneralDataCard objects
  }
  @override
  Widget build(BuildContext context) {

    return Accordion(
        children: [
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Загальні Дані', style: headerStyle),
            content: FutureBuilder<List<DataCards>>(
              future: returnGeneralInfoCards(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data found');
                }
                return Column(
                  children: snapshot.data!.map((card) {
                    return card;
                  }).toList(),
                );
              },
            ),
          ),

          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Дані про освіту', style: headerStyle),
            // content: DataCards.education(type: 2, id: 1, firstName: "Муравець", lastName: 'Ілля', middleName: 'Андрійович', end_date: '31.09.2021', institution_name: 'Нововолинський ліцей №1', average_score: 11.3),
            content: FutureBuilder<List<DataCards>>(
              future: returnEducationData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data found');
                }
                return Column(
                  children: snapshot.data!.map((card) {
                    return card;
                  }).toList(),
                );
              },
            ),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Служба в ЗСУ', style: headerStyle),
            content: const Text(loremIpsum),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Трудова діяльність', style: headerStyle),
            content: const Text(loremIpsum),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Інформація про батьків', style: headerStyle),
            content: const Text(loremIpsum),
          )
        ]);
  }
}


