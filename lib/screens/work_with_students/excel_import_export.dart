import 'package:flutter/material.dart';


class ExcelImportExport extends StatelessWidget {
  const ExcelImportExport({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Виберіть дію'),
      content: Container(
        width: 300,
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Оберіть, що ви хочете зробити з Excel:'),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Імпортувати студентів'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Імпортувати викладачів-кураторів'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Імпортувати назви груп'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Експорт соціального паспорта'),
              ),
            ],
          ),
        ),
      ),

      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: const Text('Ок'),
      //   ),
      //
      // ],
    );
  }
}
