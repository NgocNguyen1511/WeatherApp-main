import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ultilities/owned_colors.dart';
import 'detailPage.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class TodayWeather extends StatelessWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(
                  color: CustomColors.textColors,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return DetailPage();
                          }));
                    },
                    child: Text(
                      "7 days",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          hourlyList(),
        ],
      ),
    );
  }
}

Widget hourlyList() {
  return Container(
    height: 120,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: Border.all(width: 2, color: Colors.white),
      borderRadius: BorderRadius.circular(35),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Column(
          children: [
            Text(
              "24 do",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              "12h10",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        );
      }),
    ),
  );
}

