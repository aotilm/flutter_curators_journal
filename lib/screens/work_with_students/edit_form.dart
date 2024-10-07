import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  EditForm({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування даних студента'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '$lastName $firstName $middleName',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              )
          )

        ],
      ),
    );
  }
}
