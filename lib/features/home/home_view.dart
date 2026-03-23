import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_button.dart';
import 'widgets/day_card.dart';
import 'home_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  double result = 0;

  DateTime selectedDate = DateTime.now();
  // 🔥 حساب اليومية
  double calculateDaily(double hours, double rate) {
    if (hours <= 8) {
      return hours * rate;
    } else {
      double normal = 8 * rate;
      double overtime = (hours - 8) * rate * 1.5;
      return normal + overtime;
    }
  }

  void handleCalculate() {
    double hours = double.tryParse(hoursController.text) ?? 0;
    double rate = double.tryParse(rateController.text) ?? 0;

    setState(() {
      result = calculateDaily(hours, rate);
    });
  }

  void handleReset() {
    setState(() {
      hoursController.clear();
      rateController.clear();
      result = 0;
    });
  }

  void saveDay() {
    double hours = double.tryParse(hoursController.text) ?? 0;
    double rate = double.tryParse(rateController.text) ?? 0;

    if (hours == 0 || rate == 0) return;

    String selected = selectedDate.toString().split(' ')[0];

    final provider = Provider.of<HomeProvider>(context, listen: false);

    provider.addDay(hours, rate, selected);
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    // ✅ هنا المكان الصح
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("اليومية"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            ElevatedButton(
              onPressed: pickDate,
              child: Text(
                "📅 ${selectedDate.toString().split(' ')[0]}",
              ),
            ),

            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "عدد الساعات",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "سعر الساعة",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            CustomButton(
              text: "احسب",
              onPressed: handleCalculate,
              color: Colors.blue,
            ),

            SizedBox(height: 10),

            CustomButton(
              text: "حفظ اليوم",
              onPressed: saveDay,
              color: Colors.green,
            ),

            SizedBox(height: 10),

            CustomButton(
              text: "تصفير",
              onPressed: handleReset,
              color: Colors.red,
            ),

            SizedBox(height: 20),

            Text(
              "اليومية: $result",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: result > 0 ? Colors.green : Colors.black,
              ),
            ),

            SizedBox(height: 10),

            if (double.tryParse(hoursController.text) != null &&
                double.tryParse(hoursController.text)! > 8)
              Text(
                "فيه أوفر تايم 🔥",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: provider.workDays.length,
                itemBuilder: (context, index) {

                  final day = provider.workDays[index];

                  return DayCard(
                    date: day.date,
                    hours: day.hours,
                    rate: day.rate,
                    total: day.total,
                    onDelete: () {
                      provider.deleteDay(index);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}