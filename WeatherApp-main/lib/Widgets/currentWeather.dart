import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'package:intl/intl.dart';


class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  late Future<Weather> myWeather;

  @override
  void initState() {
    super.initState();
    myWeather = fetchWeather();
  }

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=HaNoi&units=metric&appid=407fa1e3b2fa2564942ff62581808bd8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = convert.jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Không thể tải được dữ liệu...');
    }
  }
  String getWeatherImage(int code) {
    if (code >= 200 && code < 300) {
      return 'assets/1.png';
    } else if (code >= 300 && code < 400) {
      return 'assets/2.png';
    } else if (code >= 500 && code < 600) {
      return 'assets/3.png';
    } else if (code >= 600 && code < 700) {
      return 'assets/4.png';
    } else if (code >= 700 && code < 800) {
      return 'assets/5.png';
    } else if (code == 800) {
      return 'assets/6.png';
    } else if (code > 800 && code <= 804) {
      return 'assets/7.png';
    } else {
      return 'assets/7.png';
    }
  }

  Widget getWeatherIcon(int code) {
    return Image.asset(
      getWeatherImage(code),
      height: 250,
      width: 250,
    );
  }
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: MediaQuery.of(context).size.height - 230,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      ),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: FutureBuilder<Weather>(
        future: myWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Weather weather = snapshot.data!;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      CupertinoIcons.square_grid_2x2,
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Text(
                          "${snapshot.data!.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(CupertinoIcons.map_fill, color: Colors.white),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                      getWeatherIcon(snapshot.data!.weather[0]['id']),
                        // Image.asset("assets/1.png",width: 200,height: 200,),
                        GlowText(
                          '${snapshot.data!.main['temp']}°C',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE dd/MM - hh:mm a').format(currentDate),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 0.9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                    CupertinoIcons.wind,
                                    color: Colors.white,
                                    size: 30,
                                ),
                                Text(
                                    '${snapshot.data!.wind['speed']} Km/h',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.weather[0]['main'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Độ ẩm",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.main['humidity']}%',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

