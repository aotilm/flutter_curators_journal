import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/screens/general_information.dart';

class WorkWithStudents extends StatefulWidget {
  const WorkWithStudents({super.key});

  @override
  State<WorkWithStudents> createState() => _WorkWithStudentsState();
}

class _WorkWithStudentsState extends State<WorkWithStudents> {
  int selectedPage = 0 ;
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
        body:  _getBodyContent(),
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
        return Center(
            child:  Text("Вітаємо!")
        );
    }
  }
}
