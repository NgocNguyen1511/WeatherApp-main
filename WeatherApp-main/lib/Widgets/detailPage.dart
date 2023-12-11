import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          TomorrowWeather(),
          SevenDays(),
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xff00A1FF),
      glowColor: Color(0xff00A1FF),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 days",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(Icons.more_vert, color: Colors.white)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/sunny.png"))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 30, height: 0.1),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            "24",
                            style: TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "gi do",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.3),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "gi do",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50,
              left: 50,
            ),
            child: Column(
              children: [
                Divider(color: Colors.white),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("days", style: TextStyle(fontSize: 20,color: Colors.white)),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   "assets/images/sunny.png",
                          //   fit: BoxFit.fill,
                          // ),
                        ],
                      ),
                    ),
                    Text(
                      "24",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "7 days",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    )
                  ],
                ));
          }),
    );
  }
}
