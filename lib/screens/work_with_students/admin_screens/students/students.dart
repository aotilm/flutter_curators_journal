import 'dart:io';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print('hello');

        },
        label: Text('Створити групу'),
        icon: Icon(Icons.add),

      ),
    );
  }
}
