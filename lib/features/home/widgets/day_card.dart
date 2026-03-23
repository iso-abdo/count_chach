import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final String date;
  final double hours;
  final double rate;
  final double total;
  final VoidCallback onDelete; // 🔥

  const DayCard({
    required this.date,
    required this.hours,
    required this.rate,
    required this.total,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("📅 $date"),
        subtitle: Text("ساعات: $hours | سعر: $rate"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              "$total",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(width: 10),

            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}