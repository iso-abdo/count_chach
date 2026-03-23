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

  double calculateDaily(double hours, double rate) {
    if (hours <= 8) {
      return hours * rate;
    } else {
      double normal = 8 * rate;
      double overtime = (hours - 8) * rate * 1.5;
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

    saveData(); // 🔥 مهم

    notifyListeners();
  }

  void deleteDay(int index) {
    workDays.removeAt(index);

    saveData(); // 🔥 مهم

    notifyListeners();
  }

  List<WorkDay> filterByDate(DateTime from, DateTime to) {
    return workDays.where((day) {
      DateTime d = DateTime.parse(day.date);

      return (d.isAfter(from) || d.isAtSameMomentAs(from)) &&
          (d.isBefore(to) || d.isAtSameMomentAs(to));
    }).toList();
  }

  double get totalAll {
    double sum = 0;
    for (var d in workDays) {
      sum += d.total;
    }
    return sum;
  }

  // 🔥 حفظ البيانات
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data =
    workDays.map((day) => jsonEncode(day.toMap())).toList();

    await prefs.setStringList('workDays', data);
  }

  // 🔥 تحميل البيانات
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList('workDays');

    if (data != null) {
      workDays = data
          .map((e) => WorkDay.fromMap(jsonDecode(e)))
          .toList();

      notifyListeners();
    }
  }
}