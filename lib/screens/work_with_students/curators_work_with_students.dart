import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/activity.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/individual_escort.dart';
import 'package:test_journal/screens/work_with_students/work_plan.dart';

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
  int currentPageIndex = 0;
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer with the new context
            },
          ),
        ),
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
                onTap: (){
                  setState(() {
                    selectedPage = 3;
                    Navigator.pop(context);
                  });
                }
            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Заохочення'),
                onTap: (){
                  setState(() {
                    selectedPage = 4;
                    Navigator.pop(context);
                  });
                }
            ),

            ListTile(
                leading: const Icon(Icons.accessibility),
                title: const Text('Соціальний паспорт'),
                onTap: (){
                  setState(() {
                    selectedPage = 5;
                    Navigator.pop(context);
                  });
                }
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.people, color: Colors.white,),
            icon: Icon(Icons.people),
            label: 'Робота з студентами',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list_alt, color: Colors.white,),
            icon: Icon(Icons.list_alt),
            label: 'План роботи',
          ),
        ],
      ),
      body: Scaffold(
        body: <Widget>[
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
          ),
          WorkPlan(),
        ][currentPageIndex]

      ),
    );
  }
  Widget _getBodyContent() {
    switch (selectedPage) {
      case 1:
        return GeneralInformation();
      case 2:
        return Activity();
      case 3:
        return IndividualEscort();
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
