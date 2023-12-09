import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/models/enums/load_status.dart';

import '../models/entities/info_weather_entity.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  InfoWeatherEntity? infoWeatherEntity;
  LoadStatus loadStatus = LoadStatus.initial;

  @override
  void initState() {
    super.initState();
    getDataWeather();
  }

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.grid_view,
                color: Colors.white,
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  Text(
                    "${infoWeatherEntity?.name ?? ''}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
          Expanded(
            child: Center(
              child: loadStatus == LoadStatus.loading
                  ? Container(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                  : loadStatus == LoadStatus.failure
                      ? Text("Lấy dữ liệu không thành công!")
                      : Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            GlowText(
                              '${infoWeatherEntity?.main?.temp ?? ''}' + "°C",
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GlowText(
                              "${infoWeatherEntity?.dateTime ?? ''}",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }

  // call API
  void getDataWeather() async {
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    await Future.delayed(Duration(seconds: 3));
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=HaNoi&units=metric&appid=82d78aef7a2755507e23056a5b7b885f');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          infoWeatherEntity = InfoWeatherEntity.fromJson(jsonResponse);
          setState(() {
            loadStatus = LoadStatus.success;
          });
          print('Tên TP ${infoWeatherEntity?.name ?? ''}.');
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }
}
