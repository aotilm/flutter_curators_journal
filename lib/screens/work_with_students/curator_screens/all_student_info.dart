import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

import '../../../MySqlConnection.dart';
import '../cards/cards.dart';
import '../edit_form.dart';

class AllStudentInfo extends StatefulWidget {
  AllStudentInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String middleName;

  @override
  State<AllStudentInfo> createState() => _AllStudentInfoState();
}

class _AllStudentInfoState extends State<AllStudentInfo> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  Future<List<GeneralDataCard>> returnStudentGeneralInfo() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "general_info");
    List<GeneralDataCard> generalDataCards = [];

    for (var record in records) {
      final card = GeneralDataCard(
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          date: record['date'] ?? 'No Date',
          address: record['address'] ?? 'No Address',
          phone: record['phone_number'] ?? 'No Phone',
          status: record['status'] == '1',
          showName: false
      );

      generalDataCards.add(card);
    }

    await connHandler.close();
    return generalDataCards;
  }
  Future<List<EducationDataCard>> returnEducationData() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, 'education_data'); //
    List<EducationDataCard> educationDataCards = [];//

    for (var record in records) {
      final card = EducationDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          institutionName: record['institution_name'] ?? 'No',
          endDate: record['end_date'] ?? 'No',
          averageScore: double.parse(record['average_score'].toString()),
          showName: false
      );

      educationDataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return educationDataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<ArmyServiceDataCard>> returnServiceInArmy() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "service_in_army"); //
    List<ArmyServiceDataCard> dataCards = [];//

    for (var record in records) {
      final card = ArmyServiceDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          serviceStartDate: record['start_date'] ?? 'No',
          serviceEndDate: record['end_date'] ?? 'No',
          serviceUnit: record['unit'],
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<JobActivityDataCard>> returnJobActivity() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "job_activity"); //
    List<JobActivityDataCard> dataCards = [];//

    for (var record in records) {
      final card = JobActivityDataCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          end_date: record['end_date'] ?? '-',
          start_date: record['start_date'] ?? 'No',
          place: record['place'] ?? 'No',
          phone_number: record['phone_number'] ?? 'No',
          job_position: record['job_position'] ?? 'No',
          showName: false

      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<ParentsInfoDataCard>> returnParentsInfo() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, 'parents_info'); //
    List<ParentsInfoDataCard> dataCards = [];//

    for (var record in records) {
      final card = ParentsInfoDataCard(//
          id: int.parse(record['id'].toString()),
          // idTable: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          father: record['father'] ?? '-',
          fathers_phone: record['fathers_phone'] ?? 'No',
          mother: record['mother'] ?? 'No',
          mothers_phone: record['mothers_phone'] ?? 'No',
          note: record['note'] ?? '-',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<SocialActivityCard>> returnSocialActivity() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "social_activity"); //
    List<SocialActivityCard> dataCards = [];//

    for (var record in records) {
      final card = SocialActivityCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          session: record['session'] ?? 'no',
          date: record['date'] ?? 'No',
          activity: record['activity'] ?? 'No',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }
  Future<List<CircleActivityCard>> returnCircleActivity() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "circle_activity"); //
    List<CircleActivityCard> dataCards = [];//

    for (var record in records) {
      final card = CircleActivityCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          session: record['session'] ?? 'no',
          circleName: record['circle_name'] ?? 'No',
          note: record['note'] ?? 'No',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<IndividualEscortCard>> returnIndividualEscort() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, 'individual_escort'); //
    List<IndividualEscortCard> dataCards = [];//

    for (var record in records) {
      final card = IndividualEscortCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          session: record['session'] ?? 'no',
          date: record['date'] ?? 'No',
          content: record['content'] ?? 'No',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<EncouragementCard>> returnEncuragement() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "encouragement"); //
    List<EncouragementCard> dataCards = [];//

    for (var record in records) {
      final card = EncouragementCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          session: record['session'] ?? 'no',
          date: record['date'] ?? 'No',
          content: record['content'] ?? 'No',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  Future<List<SocialPassportCard>> returnSocialPassportCard() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByStId(widget.id, "social_passport"); //
    List<SocialPassportCard> dataCards = [];//

    for (var record in records) {
      final card = SocialPassportCard(//
          id: int.parse(record['id'].toString()),
          firstName: '',
          lastName: '',
          middleName: '',
          session: record['session'] ?? 'no',
          category: record['category'] ?? 'no',
          startDate: record['start_date'] ?? 'no',
          endDate: record['end_date'] ?? 'no',
          note: record['note'] ?? 'no',
          showName: false
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Дані про студента"),
        backgroundColor: Theme.of(context).colorScheme.primary,

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            returnSocialActivity();
          });
        },
      ),
      body: Accordion(
        // disableScrolling: true,
        scaleWhenAnimating: false,
        children: [
          // Загальні відомості
          AccordionSection(
              contentVerticalPadding: 0,
              contentHorizontalPadding: 0,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text('Загальні відомості', style: headerStyle),
              content: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Загальні дані"),
                  FutureBuilder<List<GeneralDataCard>>(
                    future: returnStudentGeneralInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditForm(
                                        id: widget.id,
                                        // firstName: widget.firstName,
                                        // lastName: widget.lastName,
                                        // middleName: widget.middleName,
                                        selectedValue: "Загальні дані",
                                        action: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text('Додати інформацію')
                                  ],
                                )
                            )
                          ],
                        );
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnGenInfoCard(context);
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 10,),
                  Text("Дані про освіту"),
                  FutureBuilder<List<EducationDataCard>>(
                    future: returnEducationData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditForm(
                                        id: widget.id,
                                        selectedValue: "Дані про освіту",
                                        action: false,

                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text('Додати інформацію')
                                  ],
                                )
                            )
                          ],
                        );
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnEduData(context);
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 10,),
                  Text("Служба в ЗСУ"),
                  FutureBuilder<List<ArmyServiceDataCard>>(
                    future: returnServiceInArmy(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditForm(
                                        id: widget.id,
                                        selectedValue: "Служба в ЗСУ",
                                        action: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text('Додати інформацію')
                                  ],
                                )
                            )
                          ],
                        );
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnArmyData(context);
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 10,),
                  Text("Трудова діяльність"),
                  FutureBuilder<List<JobActivityDataCard>>(
                    future: returnJobActivity(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditForm(
                                        id: widget.id,
                                        selectedValue: "Трудова діяльність",
                                        action: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text('Додати інформацію')
                                  ],
                                )
                            )
                          ],
                        );
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnJobActivityData(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Text("Інформація про батьків"),
                  FutureBuilder<List<ParentsInfoDataCard>>(
                    future: returnParentsInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditForm(
                                        id: widget.id,
                                        selectedValue: "Інформація про батьків",
                                        action: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text('Додати інформацію')
                                  ],
                                )
                            )
                          ],
                        );
                      }

                      return Column(
                        children: snapshot.data!.map<Widget>((card) {
                          return card.returnParentsInfoCards(context);
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 15)
                ],
              )

          ),

          // Громадська та гурткова діяльність
          AccordionSection(
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Громадська та гурткова діяльність', style: headerStyle),
            content: Column(
              children: [
                SizedBox(height: 10,),
                Text("Громадська діяльність"),
                FutureBuilder<List<SocialActivityCard>>(
                  future: returnSocialActivity(),
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
                SizedBox(height: 5),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditForm(
                              id: widget.id,
                              selectedValue: "Громадська діяльність",
                              action: false,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Додати інформацію')
                        ],
                      )
                  )
              ],
            ),
                SizedBox(height: 10,),
                Text("Гурткова діяльність"),
                FutureBuilder<List<CircleActivityCard>>(
                  future: returnCircleActivity(),
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
                SizedBox(height: 5),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditForm(
                              id: widget.id,
                              // firstName: widget.firstName,
                              // lastName: widget.lastName,
                              // middleName: widget.middleName,
                              selectedValue: "Гурткова діяльність",
                              action: false,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Додати інформацію')
                        ],
                      )
                  )
                ],
              ),
                SizedBox(height: 15)
              ],
            )
          ),

          // Індивідуальний супровід
          AccordionSection(
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Індивідуальний супровід', style: headerStyle),
            content: Column(
              children: [
                FutureBuilder<List<IndividualEscortCard>>(
                  future: returnIndividualEscort(),
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditForm(
                                id: widget.id,
                                // firstName: widget.firstName,
                                // lastName: widget.lastName,
                                // middleName: widget.middleName,
                                selectedValue: "Індивідуальний супровід",
                                action: false,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text('Додати інформацію')
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(height: 15)
              ],
            ),
          ),

          // Заохочення
          AccordionSection(
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Заохочення', style: headerStyle),
            content:Column(
              children: [
                FutureBuilder<List<EncouragementCard>>(
                  future: returnEncuragement(),
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditForm(
                                id: widget.id,
                                // firstName: widget.firstName,
                                // lastName: widget.lastName,
                                // middleName: widget.middleName,
                                selectedValue: "Заохочення",
                                action: false,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text('Додати інформацію')
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(height: 15)
              ],
            ),
          ),

          // Соціальний паспорт
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditForm(
                                id: widget.id,
                                // firstName: widget.firstName,
                                // lastName: widget.lastName,
                                // middleName: widget.middleName,
                                selectedValue: "Соціальний паспорт",
                                action: false,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text('Додати інформацію')
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(height: 15)
              ],
            ),
          ),
        ],
      )

    );
  }
}
