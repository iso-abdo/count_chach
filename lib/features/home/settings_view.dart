import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "اسم العامل"),
            ),

            SizedBox(height: 10),

            TextField(
              controller: hoursController,
              decoration: InputDecoration(labelText: "عدد الساعات الافتراضي"),
            ),

            SizedBox(height: 10),

            TextField(
              controller: rateController,
              decoration: InputDecoration(labelText: "سعر الساعة الافتراضي"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: Text("حفظ الإعدادات"),
            ),
          ],
        ),
      ),
    );
  }
}