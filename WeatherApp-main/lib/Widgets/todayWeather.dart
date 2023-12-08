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
          Container(
              margin: EdgeInsets.only(
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListWeather(),
                ],
              )),
        ],
      ),
    );
  }
}

class ListWeather extends StatelessWidget {
  const ListWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 2.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text("27°C", style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(
            height: 5,
          ),
          Text("anh"),
          SizedBox(
            height: 5,
          ),
          Text(
            "12h10",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
