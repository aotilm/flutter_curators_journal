import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/activity.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/encouragement.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/individual_escort.dart';
import 'package:test_journal/screens/work_with_students/curator_screens/social_passport.dart';
import 'package:test_journal/screens/work_with_students/work_plan.dart';

import '../../MySqlConnection.dart';
export 'cards/cards.dart';
import 'cards/data_card_base.dart';
import 'curator_screens/general_information.dart';
import 'edit_form.dart';

class CuratorsWorkWithStudents extends StatefulWidget {
  const CuratorsWorkWithStudents({super.key, required this.group});

  final String group;

  @override
  State<CuratorsWorkWithStudents> createState() => _CuratorsWorkWithStudentsState();
}

class _CuratorsWorkWithStudentsState extends State<CuratorsWorkWithStudents> {
  int selectedPage = 1 ;
  int currentPageIndex = 0;
  // String group = "2-КТ-21";
  final List<String> pages = ['Загальні відомості', 'Громадська та гурткова діяльність', 'Індивідуальний супровід' ,'Заохочення', 'Соціальний паспорт'];
  Future<List<DataCardBase>> returnCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectStudentData(widget.group); //
    List<DataCardBase> dataCards = [];//
    int recordNumber = 1;
    for (var record in records) {
      final card = DataCardBase(//
        id: int.parse(record['id'].toString()),
        number: recordNumber,
        firstName: record['first_name'] ?? 'No Name',
        lastName: record['second_name'] ?? 'No Second Name',
        middleName: record['middle_name'] ?? 'No Middle Name',
        showName: true,
      );
      recordNumber++;
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
        title: Text("${widget.group} - Робота з студентами",
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: Icon(Icons.menu),
        //     color: Colors.white,
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer(); // Open the drawer with the new context
        //     },
        //   ),
        // ),

      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //        DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).colorScheme.primary
      //         ),
      //         child: Column(
      //           children: [
      //             CircleAvatar(
      //               // backgroundImage: ,
      //               child: Icon(Icons.account_circle, size: 70,),
      //               radius: 40,
      //             ),
      //             SizedBox(height: 10),
      //             Text(
      //                 'Призвіще та Імя',
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w500,
      //                 color: Colors.white
      //               ),
      //             )
      //           ],
      //         )
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.accessibility),
      //         title: const Text('Загальні відомості'),
      //         onTap: (){
      //           setState(() {
      //             selectedPage = 1;
      //             Navigator.pop(context);
      //           });
      //         },
      //
      //       ),
      //
      //       ListTile(
      //           leading: const Icon(Icons.accessibility),
      //           title: const Text('Громадська та гурткова діяльність'),
      //           onTap: (){
      //             setState(() {
      //               selectedPage = 2;
      //               Navigator.pop(context);
      //             });
      //           }
      //       ),
      //
      //       ListTile(
      //           leading: const Icon(Icons.accessibility),
      //           title: const Text('Індивідуальний супровід'),
      //           onTap: (){
      //             setState(() {
      //               selectedPage = 3;
      //               Navigator.pop(context);
      //             });
      //           }
      //       ),
      //
      //       ListTile(
      //           leading: const Icon(Icons.accessibility),
      //           title: const Text('Заохочення'),
      //           onTap: (){
      //             setState(() {
      //               selectedPage = 4;
      //               Navigator.pop(context);
      //             });
      //           }
      //       ),
      //
      //       ListTile(
      //           leading: const Icon(Icons.accessibility),
      //           title: const Text('Соціальний паспорт'),
      //           onTap: (){
      //             setState(() {
      //               selectedPage = 5;
      //               Navigator.pop(context);
      //             });
      //           }
      //       ),
      //     ],
      //   ),
      // ),
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
      body:  <Widget>[
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
                    Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Text('Група ${widget.group}'),
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
                            )
                          ],
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditForm(
                                id: 0,
                                group: widget.group,
                                selectedValue: "Додавання студента",
                                action: true,
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                    Column(
                      children: [
                        DropdownButton<String>(
                          hint: Text("Виберіть сторінку:"),
                          value: pages[selectedPage - 1],
                          items: pages.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPage = pages.indexOf(newValue!) + 1;
                            });
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _getBodyContent(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )


                  ],
                ),
              )

            ],
          ),
        ),
        WorkPlan(isAdmin: false,),
      ][currentPageIndex]
    );
  }
  Widget _getBodyContent() {
    switch (selectedPage) {
      case 1:
        return GeneralInformation(group: widget.group,);
      case 2:
        return Activity(group: widget.group,);
      case 3:
        return IndividualEscort(group: widget.group,);
      case 4:
        return Encouragement(group: widget.group,);
      case 5:
        return SocialPassport(group: widget.group,);
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
