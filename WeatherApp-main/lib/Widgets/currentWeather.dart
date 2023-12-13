import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/models/enums/load_status.dart';

import '../models/entities/info_weather_entity.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  InfoWeatherEntity? infoWeatherEntity;
  LoadStatus loadStatus = LoadStatus.initial;

  // @override
  // void initState() {
  //   super.initState();
  //   getDataWeather();
  // }

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
      height: 200,
      width: 200,
    );
  }


  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: MediaQuery
          .of(context)
          .size
          .height - 230,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
        builder: (context, state) {
          if (state is WeatherBlocSuccess) {
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
                          "${state.weather.areaName}",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(width: 10,),
                        Icon(CupertinoIcons.map_fill, color: Colors.white),
                      ],
                    ),
                    // Icon(Icons.more_vert, color: Colors.white)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "${state.weather.country}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        getWeatherIcon(
                            state.weather.weatherConditionCode!),
                        GlowText(
                          '${state.weather.temperature!.celsius!.round()}°C',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE dd -')
                              .add_jm()
                              .format(state.weather.date!),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 0.9,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(CupertinoIcons.wind, color: Colors.white),
                                Text(
                                    '${state.weather.windSpeed} Km/h'),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Status",
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: Colors.white),),
                                Text(
                                  state.weather.weatherMain!,
                                  style: TextStyle(
                                    fontSize: 15,
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

  // call API
//   void getDataWeather() async {
//     setState(() {
//       loadStatus = LoadStatus.loading;
//     });
//     await Future.delayed(Duration(seconds: 3));
//     try {
//       var url = Uri.parse(
//           'https://api.openweathermap.org/data/2.5/weather?q=HaNoi&units=metric&appid=82d78aef7a2755507e23056a5b7b885f');
//
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         var jsonResponse =
//             convert.jsonDecode(response.body) as Map<String, dynamic>;
//
//         setState(() {
//           infoWeatherEntity = InfoWeatherEntity.fromJson(jsonResponse);
//           setState(() {
//             loadStatus = LoadStatus.success;
//           });
//           print('Tên TP ${infoWeatherEntity?.name ?? ''}.');
//         });
//       } else {
//         print('Request failed with status: ${response.statusCode}.');
//       }
//     } catch (e) {
//       setState(() {
//         loadStatus = LoadStatus.failure;
//       });
//     }
//   }
// }

