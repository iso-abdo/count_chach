import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/home/home_provider.dart';
import 'features/home/home_view.dart';
import 'core/layout/main_layout.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final homeProvider = HomeProvider();
  await homeProvider.loadData();

  runApp(
    ChangeNotifierProvider.value(
      value: homeProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainLayout(),
      ),
    ),
  );
}