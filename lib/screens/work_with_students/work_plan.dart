import 'package:flutter/material.dart';

import 'cards.dart';

class WorkPlan extends StatefulWidget {
  const WorkPlan({super.key});

  @override
  State<WorkPlan> createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
  String? selectedValue;
  final List<String> sessions = ['1','2','3','4','5','6','7','8'];

  @override
  Widget build(BuildContext context) {
    var plan = WorkPlanCard(id: 1, session: 2, eventName: "eventName", executionDate: "executionDate", executor: "executor", isDone: true, adminConfirmation: false);
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},),
      body: Column(
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
          plan.returnCard(context)
          // FutureBuilder<List<WorkPlanCard>>(
          //   future: returnCards(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //       return Text('No data found');
          //     }
          //
          //     return Column(
          //       children: snapshot.data!.map<Widget>((card) {
          //         return card.returnCard(context);
          //       }).toList(),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
