import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/home_provider.dart';
import 'widgets/day_card.dart';


class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {

  DateTime? fromDate;
  DateTime? toDate;

  List<WorkDay> filtered = [];

  bool isFiltering = false;

  Future<void> pickDate(bool isFrom) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void applyFilter(HomeProvider provider) {
    if (fromDate == null || toDate == null) return;

    setState(() {
      filtered = provider.filterByDate(fromDate!, toDate!);
      isFiltering=true;
    });
  }

  double calculateTotal(List<WorkDay> days) {
    double sum = 0;
    for (var d in days) {
      sum += d.total;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<HomeProvider>(context);

    final displayList =
    isFiltering ? filtered : provider.workDays;

    return Scaffold(
      appBar: AppBar(title: Text("التقارير")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => pickDate(true),
                  child: Text(fromDate == null
                      ? "من تاريخ"
                      : fromDate.toString().split(' ')[0]),
                ),
                ElevatedButton(
                  onPressed: () => pickDate(false),
                  child: Text(toDate == null
                      ? "إلى تاريخ"
                      : toDate.toString().split(' ')[0]),
                ),
              ],
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => applyFilter(provider),
              child: Text("فلترة"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  filtered = [];
                  isFiltering=false;
                });
              },
              child: Text("إلغاء الفلترة"),
            ),

            SizedBox(height: 20),

            Text(
              "الإجمالي: ${calculateTotal(displayList)}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final day = displayList[index];

                  return DayCard(
                    date: day.date,
                    hours: day.hours,
                    rate: day.rate,
                    total: day.total,
                    onDelete: () {},
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