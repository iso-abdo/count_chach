import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  double result = 0;

  // 🔥 دالة حساب اليومية (مع أوفر تايم)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حساب اليومية",style: TextStyle(
        color: Colors.red,
        backgroundColor: Colors.blueAccent,
        fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "عدد الساعات",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "سعر الساعة",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: handleCalculate,
              child: Text("احسب"),
            ),

            SizedBox(height: 30),

            Text(
              "اليومية: $result",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: result > 0 ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}