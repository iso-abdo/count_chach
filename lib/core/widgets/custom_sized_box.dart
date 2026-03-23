import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double height;

  const CustomSizedBox({this.height = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}