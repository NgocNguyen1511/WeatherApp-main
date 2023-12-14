import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ultilities/owned_colors.dart';
import 'detailPage.dart';
import 'package:intl/intl.dart';

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
                      "More",
                      style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
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
    height: 150,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(1, (index) {
        return Column(
          children: [
            Text(
              "Sunday 17/12",
              style: TextStyle(fontSize: 20, color: Color(0xFFCC33CC)),
            ),
            SizedBox(height: 5,),
            Text(
              "Nhiệt độ: 11°C",
              style: TextStyle(fontSize: 20, color: Color(0xFFCC33CC)),
            ),
            SizedBox(height: 5),
            Text(
              "Độ ẩm: 28%",
              style: TextStyle(fontSize: 20, color: Color(0xFFCC33CC)),
            ),
            SizedBox(height: 5),
            Text(
              "Gió: 25km/h",
              style: TextStyle(fontSize: 20, color: Color(0xFFCC33CC)),
            ),
          ],
        );
      }),
    ),
  );
}

