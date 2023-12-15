import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the column
        children: [
          TomorrowWeather(),
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatefulWidget {
  @override
  _TomorrowWeatherState createState() => _TomorrowWeatherState();
}

class _TomorrowWeatherState extends State<TomorrowWeather> {
  late Future<List<WeatherInfo>> weeklyWeather;

  @override
  void initState() {
    super.initState();
    weeklyWeather = fetchWeeklyWeather();
  }

  Future<List<WeatherInfo>> fetchWeeklyWeather() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=HaNoi&units=metric&appid=407fa1e3b2fa2564942ff62581808bd8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> list = jsonResponse['list'];

      // Danh sách để lưu trữ thông tin thời tiết cho mỗi ngày
      List<WeatherInfo> uniqueWeatherList = [];

      for (var weatherJson in list) {
        WeatherInfo weatherInfo = WeatherInfo.fromJson(weatherJson);

        // Lấy ngày từ thông tin thời tiết
        String day = weatherInfo.day;

        // Kiểm tra xem ngày đã được thêm vào danh sách chưa
        if (!uniqueWeatherList.any((element) => element.day == day)) {
          uniqueWeatherList.add(weatherInfo);
        }
      }

      return uniqueWeatherList;
    } else {
      throw Exception('Không thể tải thông tin thời tiết hàng tuần');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlowContainer(
        color: Color(0xff00A1FF),
        glowColor: Color(0xff00A1FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      Text(
                        " Weakly",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<WeatherInfo>>(
              future: weeklyWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('lỗi hiển thị: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<WeatherInfo> weeklyWeather = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: weeklyWeather.length,
                      itemBuilder: (context, index) {
                        WeatherInfo weatherInfo = weeklyWeather[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weatherInfo.day,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Nhiệt độ: ${weatherInfo.temperature}°C',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.cloud,
                                color: Colors.green
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo {
  final String day;
  final double temperature;

  WeatherInfo({required this.day, required this.temperature});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    // Lấy thời gian từ timestamp
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    String formattedDay = '${dateTime.day}/${dateTime.month}';

    return WeatherInfo(
      day: formattedDay,
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
