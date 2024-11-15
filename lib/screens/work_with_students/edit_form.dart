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
    required this.selectedValue,
    this.action
    
  });

  final int id;
  final int? idTable;
  String selectedValue;
  final bool? action;

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

  bool isDone = false;
  bool adminConfirmation = false;


  final formKey = GlobalKey<FormState>();

  final List<String> editForms = ["Загальні дані", 'Дані про освіту', 'Служба в ЗСУ', 'Трудова діяльність',
    'Інформація про батьків', 'Громадська діяльність',
    'Гурткова діяльність', 'Індивідуальний супровід', 'Заохочення', 'Соціальний паспорт', 'План роботи'];

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
    if(widget.selectedValue == editForms[8]){
      return getEncouragementForm();
    }
    if(widget.selectedValue == editForms[9]){
      return getSocialPassportForm();
    }
    if(widget.selectedValue == editForms[10]){
      return getWorkPlanForm();
    }

    else return Text('This page is in developing...');
  }

  Future<void> returnFormFields() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    if(widget.selectedValue == editForms[0]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'general_info');
      print(records.isEmpty);
      if(records.isNotEmpty){
        fieldController1.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['address'] ?? 'No ';
        fieldController2.text = records[0]['phone_number'] ?? 'No ';
      }
    }
    if(widget.selectedValue == editForms[1]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'education_data');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['end_date'] ?? 'No ';
        fieldController2.text = records[0]['average_score'] ?? 'No  ';
        fieldController3.text = records[0]['institution_name'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[2]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'service_in_army');
      if(records.isNotEmpty){
        fieldController2.text = records[0]['end_date'] ?? 'No ';
        fieldController1.text = records[0]['start_date'] ?? 'No ';
        fieldController3.text = records[0]['unit'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[3]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'job_activity');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['start_date'] ?? 'No ';
        fieldController2.text = records[0]['end_date'] ?? 'No ';
        fieldController3.text = records[0]['place'] ?? 'No ';
        fieldController4.text = records[0]['job_position'] ?? 'No ';
        fieldController5.text = records[0]['phone_number'] ?? 'No ';
      }
    }
    if(widget.selectedValue == editForms[4]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'parents_info');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['father'] ?? '';
        fieldController2.text = records[0]['fathers_phone'] ?? '';
        fieldController3.text = records[0]['mother'] ?? '';
        fieldController4.text = records[0]['mothers_phone'] ?? '';
        fieldController5.text = records[0]['note'] ?? '';
      }
    }

    if(widget.selectedValue == editForms[5]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'social_activity');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['activity'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[6]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'circle_activity');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['circle_name'] ?? 'No ';
        fieldController3.text = records[0]['note'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[7]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'individual_escort');
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['content'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[8]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'encouragement');
      print(records.isEmpty);
      if(records.isNotEmpty){
        fieldController1.text = records[0]['session'] ?? 'No ';
        fieldController2.text = records[0]['date'] ?? 'No ';
        fieldController3.text = records[0]['content'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[9]){
      List<Map<String, dynamic>> records = await connHandler.selectStudentInfoByPkId(widget.id, 'social_passport');
      print(records.isEmpty);
      if(records.isNotEmpty){
        fieldController3.text = records[0]['session'] ?? 'No ';
        fieldController4.text = records[0]['category'] ?? 'No ';
        fieldController1.text = records[0]['start_date'] ?? 'No ';
        fieldController2.text = records[0]['end_date'] ?? 'No ';
        fieldController5.text = records[0]['note'] ?? 'No ';
      }
    }

    if(widget.selectedValue == editForms[10]){
      List<Map<String, dynamic>> records = await connHandler.selectWorkPlan();
      print(records.isEmpty);
      if(records.isNotEmpty){
        for(var record in records) {
          if (record['id'] == widget.idTable.toString()) {
            fieldController2.text = record['session'] ?? 'No ';
            fieldController1.text = record['execution_date'] ?? 'No ';
            fieldController3.text = record['event_name'] ?? 'No ';
            fieldController4.text = record['executor'] ?? 'No ';
            setState(() {
              isDone = record['isDone'] == "1";
              adminConfirmation = record['admin_confirmation'] == "1";
            });
          }
        }
      }
    }


    await connHandler.close();
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
                    await updateGenInfo(fieldController2.text, fieldController1.text, fieldController3.text, widget.action!);
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
  Future<void> updateGenInfo(String phone_number, String date, String address, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    doUpdate ?
    await connHandler.updateGenInfo(widget.id, phone_number, date, address) :
    await connHandler.insertGenInfo(phone_number, date, address, false, widget.id);

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
                    await updateEduData(fieldController3.text, fieldController1.text, fieldController2.text, widget.action!);
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
  Future<void> updateEduData(String institutionName, String endDate, String averageScore, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateEduData(widget.id, institutionName, endDate, averageScore) :
    await connHandler.insertEduDate(endDate, institutionName, averageScore, widget.id);

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
                    await updateArmyServ(fieldController3.text, fieldController2.text, fieldController1.text, widget.action!); // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
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
  Future<void> updateArmyServ(String unit, String endDate, String startDate, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateArmyServ(widget.id, startDate, endDate, unit):
    await connHandler.insertArmyServ(endDate, startDate, unit, widget.id);

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
                        fieldController4.text, fieldController5.text, widget.action!);
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
  Future<void> updateJobActivity(String startDate, String endDate, String place, String jobPosition, String phoneNumber, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateJobActivity(widget.id, startDate, endDate, place, jobPosition, phoneNumber):
    await connHandler.insertJobActivity(widget.id, startDate, endDate, place, jobPosition, phoneNumber);

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
                        fieldController4.text, fieldController5.text, widget.action!);
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
  Future<void> updateParentsInfo(String father, String fathersPhone, String mother, String mothersPhone, String note, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate?
    await connHandler.updateParentsInfo(widget.id, father, fathersPhone, mother, mothersPhone, note):
    await connHandler.insertParentsInfo(widget.id, father, fathersPhone, mother, mothersPhone, note);

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
                    await updateSocialActivity(int.parse(fieldController1.text), fieldController2.text, fieldController3.text, widget.action!);
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
  Future<void> updateSocialActivity(int session, String date, String activity, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateSocialActivity(widget.id, session, date, activity) :
    await connHandler.insertSocialActivity(widget.id, session, date, activity);

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
                    await updateCircleActivity(int.parse(fieldController1.text), fieldController2.text, fieldController3.text, widget.action!);
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
  Future<void> updateCircleActivity(int session, String circleName, String note, bool doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateCircleActivity(widget.id, session, circleName, note) :
    await connHandler.insertCircleActivity(widget.id, session, circleName, note);

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
                    await updateIndividualEscort(int.parse(fieldController1.text), fieldController2.text, fieldController3.text, widget.action!);
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
  Future<void> updateIndividualEscort(int session, String date, String content, doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateIndividualEscort(widget.id, session, date, content) :
    await connHandler.insertIndividualEscort(widget.id, session, date, content);

    await connHandler.close();
  }

  Widget getEncouragementForm(){
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
                    await updateEncouragement(int.parse(fieldController1.text), fieldController2.text, fieldController3.text, widget.action!);
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
  Future<void> updateEncouragement(int session, String date, String content, doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateEncouragement(widget.id, session, date, content) :
    await connHandler.insertEncouragement(widget.id, session, date, content);

    await connHandler.close();
  }

  Widget getSocialPassportForm(){
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
                  controller: fieldController3,
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
                    icon: Icon(Icons.note),
                    labelText: 'Категорія',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть зміст';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController4.text = value!;
                  },
                ),
              ),
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
                    width: MediaQuery.of(context).size.width * 0.45, // 30% of screen width
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController5,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Примітка',
                  ),
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
                    await updateSocialPassport(int.parse(fieldController3.text), fieldController4.text, fieldController1.text, fieldController2.text, fieldController5.text, widget.action!);
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
  Future<void> updateSocialPassport(int session, String category, String startDate, String endDate, String note, doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateSocialPassport(widget.idTable!, session, category, startDate, endDate, note) :
    await connHandler.insertSocialPassport(widget.id, session, category, startDate, endDate, note);

    await connHandler.close();
  }

  Widget getWorkPlanForm(){

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
                      controller: fieldController2,
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
                        fieldController2.text = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5, // 30% of screen width
                    child: TextFormField(
                      controller: fieldController1,
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Дата проведення',
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
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: fieldController3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    labelText: 'Назва заходу',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть захід';
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
                    icon: Icon(Icons.note),
                    labelText: 'Виконавець',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть виконавця';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fieldController4.text = value!;
                  },
                ),
              ),

              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                      value: isDone,
                      onChanged: (bool? value) {
                        setState(() {
                          isDone = value!;
                        });
                      }
                  ),
                  Text('Статус виконання заходу', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),

                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: adminConfirmation,
                      onChanged: (bool? value) {
                        setState(() {
                          adminConfirmation = value!;
                        });
                      }
                  ),
                  Text('Підтвердження адміністратора', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),

                ],
              )

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
                    await updateWorkPlan(int.parse(fieldController2.text), fieldController3.text, fieldController1.text, fieldController4.text, isDone, adminConfirmation, widget.action);
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
  Future<void> updateWorkPlan(int session, String eventName, String executionDate, String executor, bool isDone, bool adminConfirmation, doUpdate) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    doUpdate ?
    await connHandler.updateWorkPlan(widget.idTable!, session, eventName, executionDate, executor, isDone, adminConfirmation) :
    await connHandler.insertWorkPlan(session, eventName, executionDate, executor, isDone, adminConfirmation);

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
