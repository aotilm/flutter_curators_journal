import 'package:flutter/material.dart';
import '../edit_form.dart';

class WorkPlanCard {
  final int id;
  final int session;
  final String eventName;
  final String executionDate;
  final String executor;
  final bool isDone;
  final bool adminConfirmation;
  final bool isAdmin;

  WorkPlanCard({
    required this.id,
    required this.session,
    required this.eventName,
    required this.executionDate,
    required this.executor,
    required this.isDone,
    required this.adminConfirmation,
    required this.isAdmin
  });

  Card returnWorkPlanCard(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          !adminConfirmation ?
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditForm(
                id: id,
                idTable: id,
                selectedValue: 'План роботи',
                action: true,
                isAdmin: isAdmin,
              ),
            ),
          ): null;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Запис №$id',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Семестр №$session',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              SizedBox(height: 6),
              Text(
                '$eventName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Дата виконання: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: executionDate)
                      ]
                  )
              ),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Виконавець: ',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(text: executor)
                      ]
                  )
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'Підтвердження від адміністратора: ',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  adminConfirmation ? Icon(Icons.done, color: Colors.green) : Icon(Icons.close, color: Colors.red)
                ],
              ),
              Row(
                children: [
                  Text(
                    'Cтатус виконання заходу: ',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  isDone ? Icon(Icons.done, color: Colors.green) : Icon(Icons.close, color: Colors.red)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
