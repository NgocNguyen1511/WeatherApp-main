import 'package:flutter/material.dart';
import 'package:weather_app/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreenApp(),
      title: "weatherapp",
      debugShowCheckedModeBanner: false,
    );
  }
}
