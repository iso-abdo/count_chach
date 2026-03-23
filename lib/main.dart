import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/home/home_provider.dart';
import 'features/home/home_view.dart';
import 'features/home/report_view.dart';
import 'features/home/settings_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = HomeProvider();
            provider.loadData(); // 🔥 دي أهم سطر
            return provider;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int currentIndex = 0;

  final List<Widget> screens = [
    HomePage(),
    ReportView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "اليومية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "التقارير",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "الإعدادات",
          ),
        ],
      ),
    );
  }
}