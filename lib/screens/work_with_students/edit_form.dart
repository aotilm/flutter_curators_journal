import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../MySqlConnection.dart';

class EditForm extends StatefulWidget {
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
  EditFormState createState() => EditFormState();
}

class EditFormState extends State<EditForm> {
  String? selectedValue;

  DateTime? selectedDate1;
  DateTime? selectedDate2;

  // String? phoneNumber;
  // String? address;
  // String? date;
  final formKey = GlobalKey<FormState>();

  // final List<String> editForms = ["Загальні відомості", "Громадська та гурткова діяльність",
  //   // "Індивідуальний супровід", "Заохочення", "Соціальний паспорт"];

  final List<String> editForms = ["Загальні дані", 'Дані про освіту', 'Служба в ЗСУ', 'Трудова діяльність',
    'Інформація про батьків', 'Громадська діяльність',
    'Гурткова ідяльність', 'Індивідуальний супровід', 'Заохочення', 'Соціальний паспорт'];

  // Загальні відомості
  final TextEditingController dateController1 = TextEditingController();
  final TextEditingController dateController2 = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Дані про освіту
  final TextEditingController averageScoreController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();

  final TextEditingController unitController = TextEditingController();


  Widget getFormContent(){
    if(selectedValue == editForms[0]){
      // returnFormFields('general_info');
      return getGenInfoForm();
    }
    if(selectedValue == editForms[1]){
      // returnFormFields('education_data');
      return getEduDataForm();
    }
    if(selectedValue == editForms[2]){
      // returnFormFields('service_in_army');
      return getArmyServForm();
    }
    else return Text('0');
  }

  Widget dialogMessage(String message) {
    return AlertDialog(
      title: const Text('Інформаційне вікно'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
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
        dateController1.text = '${selectedDate1!.year}-${selectedDate1!.month}-${selectedDate1!.day}';
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
        dateController2.text = '${selectedDate2!.year}-${selectedDate2!.month}-${selectedDate2!.day}';
      });
    }
  }
  
  Future<void> returnFormFields() async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    if(selectedValue == editForms[0]){
      List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, 'general_info');
      if(records.isNotEmpty){
        dateController1.text = records[0]['date'] ?? 'No Date';
        addressController.text = records[0]['address'] ?? 'No Address';
        phoneNumberController.text = records[0]['phone_number'] ?? 'No Phone';
      }
    }
    if(selectedValue == editForms[1]){
      List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, 'education_data');
      if(records.isNotEmpty){
        dateController1.text = records[0]['end_date'] ?? 'No Date';
        averageScoreController.text = records[0]['average_score'] ?? 'No end data';
        institutionController.text = records[0]['institution_name'] ?? 'No institution';
      }
    }

    if(selectedValue == editForms[2]){
      List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, 'service_in_army');
      if(records.isNotEmpty){
        dateController2.text = records[0]['end_date'] ?? 'No Date';
        dateController1.text = records[0]['start_date'] ?? 'No Date';
        unitController.text = records[0]['unit'] ?? 'No unit';
      }
    }


    await connHandler.close(); // Close the connection
    // return generalDataCards; // Return the list of GeneralDataCard objects
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
                width: 185,
                child: TextFormField(
                  controller: dateController1,
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
                    dateController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: 175,
                child: TextFormField(
                  controller: phoneNumberController,
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
                    phoneNumberController.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: addressController,
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
                    addressController.text = value!;
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
                    await updateGenInfo(phoneNumberController.text, dateController1.text, addressController.text);  // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
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
  Future<void> updateGenInfo(String phone_number, String date, String address) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();
    List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, "general_info");

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
                width: 185,
                child: TextFormField(
                  controller: dateController1,
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
                    dateController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: 175,
                child: TextFormField(
                  controller: averageScoreController,
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
                    averageScoreController.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: institutionController,
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
                    institutionController.text = value!;
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
                    await updateEduData(institutionController.text, dateController1.text, averageScoreController.text);  // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
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
    List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, "education_data");

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
                width: 185,
                child: TextFormField(
                  controller: dateController1,
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
                    dateController1.text = value!;
                  },
                ),
              ),
              SizedBox(
                width: 185,
                child: TextFormField(
                  controller: dateController2,
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
                    dateController2.text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: unitController,
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
                    institutionController.text = value!;
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
                    await updateArmyServ(unitController.text, dateController2.text, dateController1.text); // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
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
    List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, "service_in_army");

    if (records.isNotEmpty) {
      await connHandler.updateArmyServ(widget.id, startDate, endDate, unit);
    } else if(records.isEmpty){
      print('Запис не знайдено.');
      await connHandler.insertArmyServ(endDate, startDate, unit, widget.id);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    '${widget.lastName} ${widget.firstName} ${widget.middleName} ${widget.id}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  hint: Text("Виберіть форму заповнення:"),
                  value: selectedValue,
                  items: editForms.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
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
    );
  }
}
