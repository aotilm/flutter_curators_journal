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

  DateTime? selectedDate;
  String? phoneNumber;
  String? address;
  String? date;
  final formKey = GlobalKey<FormState>();

  final List<String> editForms = ["Загальні відомості", "Громадська та гурткова діяльність",
    "Індивідуальний супровід", "Заохочення", "Соціальний паспорт"];

  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Widget getFormContent(){
    if(selectedValue == editForms[0]){
      returnFormFields('general_info');
      return getGenInfoForm();
    }
    if(selectedValue == editForms[1]){
      return Text('second');
    }
    else return Text('0');
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
        selectedDate = date;
        dateController.text = '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
      });
    }
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
                  controller: dateController,
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
                    date = value;
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
                    phoneNumber = value;
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
                    address = value;
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
                    await updateGenInfo(phoneNumber!, date!, address!);  // Додаємо await, щоб переконатися, що оновлення завершується до показу діалогу
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

  Future<void> returnFormFields(String table) async {
    final connHandler = MySqlConnectionHandler();
    await connHandler.connect();

    // Get the records
    List<Map<String, dynamic>> records = await connHandler.checkIfExists(widget.id, table);

    if (records.isNotEmpty) {
      dateController.text = records[0]['date'] ?? 'No Date';
      addressController.text = records[0]['address'] ?? 'No Address';
      phoneNumberController.text = records[0]['phone_number'] ?? 'No Phone';
    }

    await connHandler.close(); // Close the connection
    // return generalDataCards; // Return the list of GeneralDataCard objects
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
