import 'package:flutter/material.dart';
import '../Widgets/currentWeather.dart';
import '../Widgets/todayWeather.dart';
import '../ultilities/owned_colors.dart';


class HomeScreenApp extends StatefulWidget {
  const HomeScreenApp({Key? key}) : super(key: key);

  @override
  State<HomeScreenApp> createState() => _HomeScreenAppState();
}

class _HomeScreenAppState extends State<HomeScreenApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.gradientbackground,
      body: Column(
        children: [
          CurrentWeather(),
          TodayWeather(),
        ],
      ),
    );
  }
}
