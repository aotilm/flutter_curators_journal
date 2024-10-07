import 'package:flutter/material.dart';

import '../../MySqlConnection.dart';
import 'cards.dart';
import 'curator_screens/general_information.dart';

class CuratorsWorkWithStudents extends StatefulWidget {
  const CuratorsWorkWithStudents({super.key});

  @override
  State<CuratorsWorkWithStudents> createState() => _CuratorsWorkWithStudentsState();
}

class _CuratorsWorkWithStudentsState extends State<CuratorsWorkWithStudents> {
  int selectedPage = 0 ;

  Future<List<DataCardBase>> returnCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentData(); //
    List<DataCardBase> dataCards = [];//

    for (var record in records) {
      final card = DataCardBase(//
        id: int.parse(record['id'].toString()),
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Робота з студентами",
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,

      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    // backgroundImage: ,
                    child: Icon(Icons.account_circle, size: 70,),
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Призвіще та Імя',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  )
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Загальні відомості'),
              onTap: (){
                setState(() {
                  selectedPage = 1;
                  Navigator.pop(context);
                });
              },

            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Громадська та гурткова діяльність'),
                onTap: (){
                  setState(() {
                    selectedPage = 2;
                    Navigator.pop(context);
                  });
                }
            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Індивідуальний супровід'),
                onTap: null
            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Заохочення'),
                onTap: null
            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Соціальний паспорт'),
                onTap: null
            ),
          ],
        ),
      ),

      body: Scaffold(
        body: 
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  // labelColor: Colors.blue, // Колір тексту активної вкладки
                  // unselectedLabelColor: Colors.grey, // Колір тексту неактивних вкладок
                  // indicatorColor: Colors.blue, // Колір індикатора активної вкладки
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 8),
                          Text("Усі студенти"),
                        ],
                      ),
                    ),

                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 8),
                          Text("Розширенна"),
                        ],
                      ),
                    )

                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Text('усі студікі'),
                      Column(
                        children: [
                          Padding(
                              padding:  const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'тут буде група студентів куратора',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                          ),

                          FutureBuilder<List<DataCardBase>>(
                            future: returnCards(),
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
                                  return card.returnCard(context);
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                      _getBodyContent(),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget _getBodyContent() {
    switch (selectedPage) {
      case 1:
        return GeneralInformation();
      case 2:
        return Text('Активність');
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Вітаємо!"),
            Text('Виберіть розділ у меню')
          ],
        );
    }
  }
}
