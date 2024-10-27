import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../MySqlConnection.dart';

class EditForm extends StatefulWidget {
  EditForm({
    required this.id,
    this.idTable,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.selectedValue
  });

  final int id;
  final int? idTable;
  final String firstName;
  final String lastName;
  final String middleName;
  String selectedValue;

  @override
  EditFormState createState() => EditFormState();
}

class EditFormState extends State<EditForm> {
  // String? selectedValue;
  @override
  void initState() {
    super.initState();
    returnFormFields();
  }

  DateTime? selectedDate1;
  DateTime? selectedDate2;


  final formKey = GlobalKey<FormState>();

  final List<String> editForms = ["Загальні дані", 'Дані про освіту', 'Служба в ЗСУ', 'Трудова діяльність',
    'Інформація про батьків', 'Громадська діяльність',
    'Гурткова ідяльність', 'Індивідуальний супровід', 'Заохочення', 'Соціальний паспорт'];

  final TextEditingController fieldController1 = TextEditingController();
  final TextEditingController fieldController2 = TextEditingController();
  final TextEditingController fieldController3 = TextEditingController();
  final TextEditingController fieldController4 = TextEditingController();
  final TextEditingController fieldController5 = TextEditingController();


  

  void clearData(){
    fieldController1.clear();
    fieldController2.clear();
    fieldController3.clear();
    fieldController4.clear();
    fieldController5.clear();
  }
  Widget getFormContent(){
    if(widget.selectedValue == editForms[0]){
      return getGenInfoForm();
    }
    if(widget.selectedValue == editForms[1]){
      return getEduDataForm();
    }
    if(widget.selectedValue == editForms[2]){
      return getArmyServForm();
    }
    if(widget.selectedValue == editForms[3]){
      return getJobActivityForm();
    }
    if(widget.selectedValue == editForms[4]){
      return getParentsInfoForm();
    }
    if(widget.selectedValue == editForms[5]){
      return getSocialActivityForm();
    }
    if(widget.selectedValue == editForms[6]){
      return getCircleActivityForm();
    }
    if(widget.selectedValue == editForms[7]){
      return getIndividualEscortForm();
    }
    else return Text('This page is in developing...');
  }

  Future<void> returnFormFields() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    if(widget.selectedValue == editForms[0]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'general_info');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['address'] ?? 'No ';
        fieldController2.text = records[0]['phone_number'] ?? 'No ';
      }
    }
    if(widget.selectedValue == editForms[1]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'education_data');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['end_date'] ?? 'No ';
        fieldController2.text = records[0]['average_score'] ?? 'No  ';
        fieldController3.text = records[0]['institution_name'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[2]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'service_in_army');
      if(records.isNotEmpty){
        fieldController2.text = records[0]['end_date'] ?? 'No ';
        fieldController1.text = records[0]['start_date'] ?? 'No ';
        fieldController3.text = records[0]['unit'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[3]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'job_activity');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['start_date'] ?? 'No ';
        fieldController2.text = records[0]['end_date'] ?? 'No ';
        fieldController3.text = records[0]['place'] ?? 'No ';
        fieldController4.text = records[0]['job_position'] ?? 'No ';
        fieldController5.text = records[0]['phone_number'] ?? 'No ';
      }
    }
    if(widget.selectedValue == editForms[4]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'parents_info');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['father'] ?? 'No ';
        fieldController2.text = records[0]['fathers_phone'] ?? 'No ';
        fieldController3.text = records[0]['mother'] ?? 'No ';
        fieldController4.text = records[0]['mothers_phone'] ?? 'No ';
        fieldController5.text = records[0]['note'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[5]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'social_activity');
      if(records.isNotEmpty){
        for(var record in records){
          print(record['id']);

          if(record['id'] == widget.idTable.toString()){
            fieldController1.text = record['session'] ?? 'No ';
            fieldController2.text = record['date'] ?? 'No ';
            fieldController3.text = record['activity'] ?? 'No ';
          }
        }
      }
      print(widget.idTable);

      // if(records.isNotEmpty){
      //   fieldController1.text = records[0]['session'] ?? 'No ';
      //   fieldController2.text = records[0]['date'] ?? 'No ';
      //   fieldController3.text = records[0]['activity'] ?? 'No ';
      // }

    }

    if(widget.selectedValue == editForms[6]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'circle_activity');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['circle_name'] ?? 'No ';
        fieldController3.text = records[0]['note'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[7]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, 'individual_escort');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['content'] ?? 'No ';
      }
    }


    await connHandler.close(); // Close the connection
    // return generalDataCards; // Return the list of GeneralDataCard objects
  }


  Widget dialogMessage(String message) {
    return AlertDialog(
      title: const Text('Інформаційне вікно'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, true);

          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        selectedDate1 = date;
        fieldController1.text = '${selectedDate1!.year}-${selectedDate1!.month}-${selectedDate1!.day}';
      });
    }
  }

  Future<void> selectDate2() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        selectedDate2 = date;
        fieldController2.text = '${selectedDate2!.year}-${selectedDate2!.month}-${selectedDate2!.day}';
      });
    }
  }
  


  Widget getGenInfoForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFormField(
                  controller: fieldController1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата народження',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate();
                  },
                  onSaved: (value) {
                    fieldController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  controller: fieldController2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Номер телефону',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть номер телефону';
                    }
                    if(value.length > 13){
                      return 'Задовгий номер';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController2.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Адреса',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть адресу';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController4.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateGenInfo(fieldController2.text, fieldController1.text, fieldController3.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 5),
                    Text('Зберегти дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateGenInfo(String phone_number, String date, String address) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "general_info");

    if (records.isNotEmpty) {
      await connHandler.updateGenInfo(widget.id, phone_number, date, address);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertGenInfo(phone_number, date, address, false, widget.id);
    }
    await connHandler.close();
  }

  Widget getEduDataForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFormField(
                  controller: fieldController1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата закінчення',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate();
                  },
                  onSaved: (value) {
                    fieldController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFormField(
                  controller: fieldController2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Середній бал',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть середній бал';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController2.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Назва закладу',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть заклад';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateEduData(fieldController3.text, fieldController1.text, fieldController2.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateEduData(String institutionName, String endDate, String averageScore) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "education_data");

    if (records.isNotEmpty) {
      await connHandler.updateEduData(widget.id, institutionName, endDate, averageScore);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertEduDate(endDate, institutionName, averageScore, widget.id);
    }
    await connHandler.close();
  }

  Widget getArmyServForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFormField(
                  controller: fieldController1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата початку',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate();
                  },
                  onSaved: (value) {
                    fieldController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  controller: fieldController2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата закінчення',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate2();
                  },
                  onSaved: (value) {
                    fieldController2.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Підрозділ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть підрозділ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateArmyServ(fieldController3.text, fieldController2.text, fieldController1.text); // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateArmyServ(String unit, String endDate, String startDate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "service_in_army");

    if (records.isNotEmpty) {
      await connHandler.updateArmyServ(widget.id, startDate, endDate, unit);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertArmyServ(endDate, startDate, unit, widget.id);
    }
    await connHandler.close();
  }

  Widget getJobActivityForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4, // 30% of screen width
                child: TextFormField(
                  controller: fieldController1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата початку',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate();
                  },
                  onSaved: (value) {
                    fieldController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4, // 30% of screen width
                child: TextFormField(
                  controller: fieldController2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: 'Дата закінчення',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть дату';
                    }
                    return null;
                  },
                  onTap: () {
                    selectDate2();
                  },
                  onSaved: (value) {
                    fieldController2.text = value!;
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Місце роботи',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть місце роботи';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController4,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Посада',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть посаду';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController4.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  controller: fieldController5,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Номер телефону',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть номер телефону';
                    }
                    if(value.length > 13){
                      return 'Задовгий номер';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController5.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateJobActivity(fieldController1.text, fieldController2.text, fieldController3.text,
                        fieldController4.text, fieldController5.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateJobActivity(String startDate, String endDate, String place, String jobPosition, String phoneNumber) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "job_activity");

    if (records.isNotEmpty) {
      await connHandler.updateJobActivity(widget.id, startDate, endDate, place, jobPosition, phoneNumber);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertJobActivity(widget.id, startDate, endDate, place, jobPosition, phoneNumber);
    }
    await connHandler.close();
  }

  Widget getParentsInfoForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Батько',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть ПІБ батька';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController1.text = value!;
                  },
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Телефон батька',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть телефон батька';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController2.text = value!;
                  },
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Матір',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть ПІБ матері';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController4,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Телефон матері',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть телефон матері';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController4.text = value!;
                  },
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController5,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Примітка',
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Введіть телефон матері';
                  //   }
                  //   return null;
                  // },
                  onSaved: (value) {
                    fieldController5.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateParentsInfo(fieldController1.text, fieldController2.text, fieldController3.text,
                        fieldController4.text, fieldController5.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateParentsInfo(String father, String fathersPhone, String mother, String mothersPhone, String note) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "parents_info");

    if (records.isNotEmpty) {
      await connHandler.updateParentsInfo(widget.id, father, fathersPhone, mother, mothersPhone, note);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertParentsInfo(widget.id, father, fathersPhone, mother, mothersPhone, note);
    }
    await connHandler.close();
  }

  Widget getSocialActivityForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 SizedBox(
                   width: MediaQuery.of(context).size.width * 0.4,
                   child: TextFormField(
                     controller: fieldController1,
                     keyboardType: TextInputType.number,
                     inputFormatters: <TextInputFormatter>[
                       FilteringTextInputFormatter.digitsOnly
                     ],
                     maxLines: null,
                     decoration: const InputDecoration(
                       icon: Icon(Icons.note),
                       labelText: 'Семестр',
                     ),
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Введіть семестр';
                       }
                       return null;
                     },
                     onSaved: (value) {
                       fieldController1.text = value!;
                     },
                   ),
                 ),
                 SizedBox(
                   width: MediaQuery.of(context).size.width * 0.4,
                   child: TextFormField(
                     controller: fieldController2,
                     maxLines: null,
                     decoration: const InputDecoration(
                       icon: Icon(Icons.date_range),
                       labelText: 'Дата',
                     ),
                     readOnly: true,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Введіть дату';
                       }
                       return null;
                     },
                     onTap: () {
                       selectDate2();
                     },
                     onSaved: (value) {
                       fieldController2.text = value!;
                     },
                   ),
                 ),
               ],
             ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Діяльність',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть діяльність';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateSocialActivity(int.parse(fieldController1.text), fieldController2.text, fieldController3.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateSocialActivity(int session, String date, String activity) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "social_activity");

    if (records.isNotEmpty) {
      await connHandler.updateSocialActivity(widget.idTable!, session, date, activity);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertSocialActivity(widget.id, session, date, activity);
    }
    await connHandler.close();
    // Navigator.pop(context);
  }

  Widget getCircleActivityForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      controller: fieldController1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.note),
                        labelText: 'Семестр',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введіть семестр';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fieldController1.text = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: fieldController2,
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.note),
                        labelText: 'Гурток',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введіть гурток';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fieldController2.text = value!;
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Нотатка',
                  ),
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateCircleActivity(int.parse(fieldController1.text), fieldController2.text, fieldController3.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateCircleActivity(int session, String circleName, String note) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "circle_activity");

    if (records.isNotEmpty) {
      await connHandler.updateCircleActivity(widget.id, session, circleName, note);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertCircleActivity(widget.id, session, circleName, note);
    }
    await connHandler.close();
  }

  Widget getIndividualEscortForm(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      controller: fieldController1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.note),
                        labelText: 'Семестр',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введіть семестр';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fieldController1.text = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: fieldController2,
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Дата',
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введіть дату';
                        }
                        return null;
                      },
                      onTap: () {
                        selectDate2();
                      },
                      onSaved: (value) {
                        fieldController2.text = value!;
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Зміст',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть зміст';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController3.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await updateIndividualEscort(int.parse(fieldController1.text), fieldController2.text, fieldController3.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogMessage('Інформацію оновлено у базі даних!');
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Оновити дані'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> updateIndividualEscort(int session, String date, String content) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.selectStudentInfo(widget.id, "individual_escort");

    if (records.isNotEmpty) {
      await connHandler.updateIndividualEscort(widget.id, session, date, content);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertIndividualEscort(widget.id, session, date, content);
    }
    await connHandler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування даних студента'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Center(
                  //   child: Text(
                  //     '${widget.lastName} ${widget.firstName} ${widget.middleName} ${widget.id}',
                  //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  DropdownButton<String>(
                    hint: Text("Виберіть форму заповнення:"),
                    value: widget.selectedValue,
                    items: editForms.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selectedValue = newValue!;
                        clearData();
                        returnFormFields();
                      });
                    },
                  ),

                  getFormContent()

                ],
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
