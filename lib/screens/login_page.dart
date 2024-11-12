import 'package:flutter/material.dart';
import 'package:test_journal/screens/recover_pass_page.dart';
import 'package:test_journal/screens/work_with_students/admin_work_with_students.dart';
import 'package:test_journal/screens/work_with_students/curators_work_with_students.dart';

import '../MySqlConnection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> logining() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(loginController.text);
      print(passController.text);
      final connHandler = MySqlConnectionHandler();
      await connHandler.connect();
      // bool result = await connHandler.loginUser(loginController.text, passController.text);
      List<Map<String, dynamic>> records = await connHandler.selectCuratorInfo(loginController.text, passController.text);

      await connHandler.close();
      if(records.isNotEmpty){
        switch (records[0]["role"]){
          case 'Адміністратор':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminWorkWithStudents()
              ),
            );
          case 'Куратор':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CuratorsWorkWithStudents(group: records[0]['group'])
              ),
            );
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Theme.of(context).primaryColor, content: Text('Skill issue!')),
            );
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Theme.of(context).primaryColor, content: Text('Невірні дані для входу!')),
        );
      }
    }

  }

  @override
  void initState() {
    super.initState();
    loginController.text = "admin@";
    passController.text = "admin";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Сторінка авторизації'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Вітаємо з поверненням!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Введіть дані для входу в додаток',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    controller: loginController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введіть Email';
                      }
                      if(!value.contains("@")){
                        return 'Email має містити @';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      loginController.text = value!;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    obscureText: true,
                    // obscuringCharacter: "!",
                    controller: passController,
                    // maxLines: null,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      labelText: 'Пароль',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введіть пароль';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      passController.text = value!;
                    },
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: FilledButton(
                    onPressed: () {
                      logining();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Центрування тексту
                      children: [
                        Icon(Icons.login),
                        SizedBox(width: 5),
                        Text('Увійти'),
                      ],
                    ),
                  ),
                ),

                TextButton(
                    onPressed: () async {
                      // await recoverPassword();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => RecoverPassPage()
                      ));
                    },
                    child: Text('Забув пароль'))

              ],
            ),
          )
        )
      )
    );
  }
}
