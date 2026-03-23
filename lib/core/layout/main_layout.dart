import 'package:flutter/material.dart';
import '../../features/home/home_view.dart';
import '../../features/home/report_view.dart';
import '../../features/home/settings_view.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    ReportView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

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
            label: "الرئيسية",
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