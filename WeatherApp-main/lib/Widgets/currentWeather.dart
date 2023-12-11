import 'package:flutter/cupertino.dart';
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
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: Column(
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
                  Icon(CupertinoIcons.map_fill, color: Colors.white),
                  Text(
                    "${infoWeatherEntity?.name ?? ''}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.white)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Updating",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/sunny.png",
                    fit: BoxFit.fill,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GlowText(
                            '${infoWeatherEntity?.main?.temp ?? ''}',
                            style: TextStyle(
                              fontSize: 150,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${infoWeatherEntity?.dateTime ?? ''}",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text("km/h")
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
