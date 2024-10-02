import 'package:flutter/material.dart';
import 'package:test_journal/screens/work_with_students/admin_screens/create_group.dart';


class AdminWorkWithStudents extends StatefulWidget {
  const AdminWorkWithStudents({super.key});

  @override
  State<AdminWorkWithStudents> createState() => _AdminWorkWithStudentsState();
}

class _AdminWorkWithStudentsState extends State<AdminWorkWithStudents> {
  int selectedPage = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Робота з студентами Admin"),
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
              title: const Text('Створити групу'),
              onTap: (){
                setState(() {
                  selectedPage = 1;
                  Navigator.pop(context);
                });
              },

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
        return CreateGroup();
      case 2:
        return Text('Активність');
      default:
        return Center(
            child:  Text("Вітаємо!")
        );
    }
  }
}
