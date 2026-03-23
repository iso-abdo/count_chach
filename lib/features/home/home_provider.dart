import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WorkDay {
  String date;
  double hours;
  double rate;
  double total;

  WorkDay({
    required this.date,
    required this.hours,
    required this.rate,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'hours': hours,
      'rate': rate,
      'total': total,
    };
  }

  factory WorkDay.fromMap(Map<String, dynamic> map) {
    return WorkDay(
      date: map['date'],
      hours: map['hours'],
      rate: map['rate'],
      total: map['total'],
    );
  }
}

class HomeProvider extends ChangeNotifier {
  List<WorkDay> workDays = [];

  String userName = "iso";
  double defaultRate = 300;
  double defaultHours = 8;
  double overtimeRate = 1.5;
  bool isActivated = false;
  List<String> usedCodes = [];

  double calculateDaily(double hours, double rate) {
    if (hours <= defaultHours) {
      return hours * rate;
    } else {
      double normal = defaultHours * rate;
      double overtime = (hours - defaultHours) * rate * overtimeRate;
      return normal + overtime;
    }
  }

  void addDay(double hours, double rate, String date) {
    double total = calculateDaily(hours, rate);

    workDays.add(
      WorkDay(
        date: date,
        hours: hours,
        rate: rate,
        total: total,
      ),
    );

    saveData();
    notifyListeners();
  }

  void deleteDay(int index) {
    workDays.removeAt(index);
    saveData();
    notifyListeners();
  }

  double get totalAll {
    return workDays.fold(0, (sum, d) => sum + d.total);
  }

  // 🔥 حفظ البيانات
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();


    List<String> data =
    workDays.map((day) => jsonEncode(day.toMap())).toList();

    await prefs.setStringList('workDays', data);

    await prefs.setString('userName', userName);
    await prefs.setDouble('defaultRate', defaultRate);
    await prefs.setDouble('defaultHours', defaultHours);
    await prefs.setDouble('overtimeRate', overtimeRate);
    await prefs.setBool('isActivated', isActivated);
    await prefs.setStringList('usedCodes', usedCodes);
  }
  List<WorkDay> filterByDate(DateTime from, DateTime to) {
    return workDays.where((day) {
      DateTime d = DateTime.parse(day.date);

      return (d.isAfter(from) || d.isAtSameMomentAs(from)) &&
          (d.isBefore(to) || d.isAtSameMomentAs(to));
    }).toList();
  }
  // 🔥 تحميل البيانات
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList('workDays');

    if (data != null) {
      workDays = data
          .map((e) => WorkDay.fromMap(jsonDecode(e)))
          .toList();
    }

    userName = prefs.getString('userName') ?? "مستخدم";
    defaultRate = prefs.getDouble('defaultRate') ?? 50;
    defaultHours = prefs.getDouble('defaultHours') ?? 8;
    overtimeRate = prefs.getDouble('overtimeRate') ?? 1.5;
    isActivated = prefs.getBool('isActivated') ?? false;

    usedCodes = prefs.getStringList('usedCodes') ?? [];

    notifyListeners();
  }

  // 🔥 تحديث الإعدادات
  void updateSettings({
    required String name,
    required double hours,
    required double rate,
  }) {
    userName = name;
    defaultHours = hours;
    defaultRate = rate;

    saveData();
    notifyListeners();
  }
}