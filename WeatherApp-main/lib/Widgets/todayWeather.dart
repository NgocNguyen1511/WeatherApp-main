import 'package:flutter/material.dart';

import '../ultilities/owned_colors.dart';
import 'detailPage.dart';

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
    height: 160,
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(left: 20, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Days"
                ),
              ],
            ),
          );
        }),
  );
}