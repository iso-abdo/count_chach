import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_provider.dart';

class SettingsView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    // تحميل القيم الحالية
    nameController.text = provider.userName;
    hoursController.text = provider.defaultHours.toString();
    rateController.text = provider.defaultRate.toString();

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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "عدد الساعات الافتراضي"),
            ),

            SizedBox(height: 10),

            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "سعر الساعة الافتراضي"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                provider.updateSettings(
                  name: nameController.text,
                  hours: double.tryParse(hoursController.text) ?? 8,
                  rate: double.tryParse(rateController.text) ?? 50,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم حفظ الإعدادات ✅")),
                );
              },
              child: Text("حفظ الإعدادات"),
            ),
          ],
        ),
      ),
    );
  }
}