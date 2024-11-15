import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import '../cards/cards.dart';
import '../../../MySqlConnection.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key, required this.group});

  final String group;

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {

  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);



  Future<List<GeneralDataCard>> returnGeneralInfoCards() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectGenInfo(widget.group);
    List<GeneralDataCard> generalDataCards = [];

    for (var record in records) {
      final card = GeneralDataCard(
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          date: record['date'] ?? 'No Date',
          address: record['address'] ?? 'No Address',
          phone: record['phone_number'] ?? 'No Phone',
          status: record['status'] == '1',
          showName: true
      );

      generalDataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return generalDataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<EducationDataCard>> returnEducationDataCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectEduData(widget.group); //
    List<EducationDataCard> educationDataCards = [];//

    for (var record in records) {
      final card = EducationDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          institutionName: record['institution_name'] ?? 'No',
          endDate: record['end_date'] ?? 'No',
          averageScore: double.parse(record['average_score'].toString()),
          showName: true
        // averageScore: 1
      );

      educationDataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return educationDataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<ArmyServiceDataCard>> returnServiceInArmyCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectServInArmyData(widget.group); //
    List<ArmyServiceDataCard> dataCards = [];//

    for (var record in records) {
      final card = ArmyServiceDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          serviceStartDate: record['start_date'] ?? 'No',
          serviceEndDate: record['end_date'] ?? 'No',
          serviceUnit: record['unit'],
          showName: true
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<JobActivityDataCard>> returnJobActivityCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectJobActivityData(widget.group); //
    List<JobActivityDataCard> dataCards = [];//

    for (var record in records) {
      final card = JobActivityDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          end_date: record['end_date'] ?? '-',
          start_date: record['start_date'] ?? 'No',
          place: record['place'] ?? 'No',
          phone_number: record['phone_number'] ?? 'No',
          job_position: record['job_position'] ?? 'No',
          showName: true

      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<ParentsInfoDataCard>> returnParentsInfoCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectParentsInfoData(widget.group); //
    List<ParentsInfoDataCard> dataCards = [];//

    for (var record in records) {
      final card = ParentsInfoDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: record['first_name'] ?? 'No Name',
          lastName: record['second_name'] ?? 'No Second Name',
          middleName: record['middle_name'] ?? 'No Middle Name',
          father: record['father'] ?? '-',
          fathers_phone: record['fathers_phone'] ?? 'No',
          mother: record['mother'] ?? 'No',
          mothers_phone: record['mothers_phone'] ?? 'No',
          note: record['note'] ?? '-',
          showName: true,
          // idTable: int.parse(record['id'].toString())
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
              header: const Text('Загальні Дані', style: headerStyle),
              content: Column(
                children: [
                  FutureBuilder<List<GeneralDataCard>>(
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
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnGenInfoCard(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )



          ),
          AccordionSection(
            // isOpen: true,
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon:
              const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Дані про освіту', style: headerStyle),
              // content: Text('hello'),
              content: Column(
                children: [
                  FutureBuilder<List<EducationDataCard>>(
                    future: returnEducationDataCards(),
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
                          return card.returnEduData(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
          ),
          AccordionSection(
            // isOpen: true,
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon:
              const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Служба в ЗСУ', style: headerStyle),
              content: Column(
                children: [
                  FutureBuilder<List<ArmyServiceDataCard>>(
                    future: returnServiceInArmyCards(),
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
                          return card.returnArmyData(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
          ),
          AccordionSection(
            // isOpen: true,
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon:
              const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Трудова діяльність', style: headerStyle),
              content: Column(
                children: [
                  FutureBuilder<List<JobActivityDataCard>>(
                    future: returnJobActivityCards(),
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
                          return card.returnJobActivityData(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
          ),
          AccordionSection(
            // isOpen: true,
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon:
              const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Інформація про батьків', style: headerStyle),
              content: Column(
                children: [
                  FutureBuilder<List<ParentsInfoDataCard>>(
                    future: returnParentsInfoCards(),
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
                          return card.returnParentsInfoCards(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
          )
        ]
    );


  }
}


