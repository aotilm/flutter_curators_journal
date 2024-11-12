import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';
import 'package:test_journal/screens/password_recovery_html.dart';

class RecoverPassPage extends StatefulWidget {
  const RecoverPassPage({super.key});

  @override
  State<RecoverPassPage> createState() => _RecoverPassPageState();
}

class _RecoverPassPageState extends State<RecoverPassPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  int page = 0;
  int randomNumber = 0;
  String? email;

  Future<void> sendRecoverCode() async {
    String username = 'aotilm@gmail.com';
    String password = 'hjeo cyed jrwm tuzi';

    var random = Random();
    randomNumber = random.nextInt(100000);

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Журнал куратора')
      ..recipients.add('muravets.i@nemk.ukr.education')
      ..subject = 'Відновлення пароля'
      ..text = 'Лист відновлення пароля'
      ..html = PasswordRecoveryHtml.html(randomNumber);


    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Widget recoverForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextFormField(
            controller: textController,
            maxLines: null,
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              labelText: 'Email для відновлення',
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
              textController.text = value!;
            },
          ),
        ),
        SizedBox(height: 10),
        FilledButton(
            onPressed: (){
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                email = textController.text;
                sendRecoverCode();
                setState(() {
                  page=1;
                });
              }
            },
            child: Text('Надіслати код відновлення')
        )

      ],
    );
  }

  Widget codeConfirmForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextFormField(
            controller: textController,
            maxLines: null,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Код підтвердження',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введіть код';
              }
              if(int.parse(value) != randomNumber){
                return 'Невірний код';
              }
              return null;
            },
            onSaved: (value) {
              textController.text = value!;
            },
          ),
        ),
        SizedBox(height: 10),
        FilledButton(
            onPressed: (){
              if (formKey.currentState!.validate()) {
                // formKey.currentState!.save();
                // sendRecoverCode();
                // setState(() {
                //   page=1;
                // });
                Navigator.pop(context);
              }
            },
            child: Text('Підтвердити')
        )

      ],
    );
  }

  Widget getBodyContent() {
    switch (page) {
      case 1:
        return codeConfirmForm();
      default:
        return recoverForm();


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Відновлення пароля'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: getBodyContent(),
          ),
        ),
      )
    );
  }
}
