import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Створення групи', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)],
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Призвіще',
                          ),
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                      ),

                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Ім`я',
                          ),
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                      ),

                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Побатькові',
                          ),
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            Accordion(
                children: [
                  AccordionSection(
                      isOpen: true,
                      contentVerticalPadding: 0,
                      contentHorizontalPadding: 0,
                      headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
                      header: const Text('Додані студенти', style: headerStyle),
                      content: Text('lkjsdflkjsdlkjfsdlfjsdlkfj;sdjlkjfsdlkfjsdlj')
                  )
                ]
            ),
            // SizedBox(height: 3),

            FilledButton(
                onPressed: () {},
                child: Text('Створити групу')
            ),
          ],
        ),
      ),
    );
  }
}
