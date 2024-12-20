import 'package:flutter/material.dart';

import '../../MySqlConnection.dart';
import 'cards/cards.dart';
import 'edit_form.dart';

class WorkPlan extends StatefulWidget {
  const WorkPlan({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  State<WorkPlan> createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
  String? selectedValue;
  final List<String> sessions = ['1','2','3','4','5','6','7','8'];
  Future<List<WorkPlanCard>> returnWorkPlanCards() async { //
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.selectWorkPlan(); //
    List<WorkPlanCard> dataCards = [];//

    for (var record in records) {
      final card = WorkPlanCard(//
        id: int.parse(record['id'].toString()),
        session: int.parse(record['session'].toString()),
        eventName: record['event_name'] ?? 'No',
        executionDate: record['execution_date'] ?? 'No',
        executor: record['executor'] ?? 'No',
        isDone: record['isDone'] == "1",
        adminConfirmation: record['admin_confirmation'] == "1",
        isAdmin: widget.isAdmin

      );

      dataCards.add(card);
    }

    await connHandler.close(); // Close the connection
    return dataCards; // Return the list of GeneralDataCard objects
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: 0,
                selectedValue: 'План роботи',
                action: false,
              ),
            ),
          );
        }
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text("Виберіть семестр:"),
                    value: selectedValue,
                    items: sessions.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  )
                ],
              ),
            ),
            FutureBuilder<List<WorkPlanCard>>(
              future: returnWorkPlanCards(),
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
                    return card.returnWorkPlanCard(context);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
