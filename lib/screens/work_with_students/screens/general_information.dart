import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  static const loremIpsum =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et 
  malorum', a 1st century BC text by the Roman statesman and philosopher Cicero,
   with words altered, added, and removed to make it nonsensical and improper Latin.''';
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  // static const contentStyle = TextStyle(
  //     color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {

    return Accordion(
        children: [
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 0,
            contentHorizontalPadding: 0,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Загальні Дані', style: headerStyle),
            content: Column(
              children: [
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: false),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
                GeneralDataCard(id: 32323, firstName: 'Illia', lastName: 'Muravets',
                    middleName: 'Andriyovich', date: '17.07.2006', address: 'м. Нововолинськ, вул. Незалежності',
                    phone: '+380683590633', status: true),
              ],
            ),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Дані про освіту', style: headerStyle),
            content: const Text(loremIpsum),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Служба в ЗСУ', style: headerStyle),
            content: const Text(loremIpsum),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Трудова діяльність', style: headerStyle),
            content: const Text(loremIpsum),
          ),
          AccordionSection(
            // isOpen: true,
            contentVerticalPadding: 20,
            contentHorizontalPadding: 20,
            headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            leftIcon:
            const Icon(Icons.text_fields_rounded, color: Colors.white),
            header: const Text('Інформація про батьків', style: headerStyle),
            content: const Text(loremIpsum),
          )
        ]);
  }
}

class GeneralDataCard extends StatelessWidget {
  // Конструктор з обов'язковими параметрами
  const GeneralDataCard({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.date,
    required this.address,
    required this.phone,
    required this.status,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String date;
  final String address;
  final String phone;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Запис №$id',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$lastName $firstName $middleName',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  '$phone',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              '$address',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            status ?
                Row(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Вибув',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ): Container()


          ],
        ),
      ),
    );
  }
}
