import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather.dart';

import 'package:meta/meta.dart';

class FutureWeather extends StatelessWidget {
  final Weather weather;

  FutureWeather({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      weather.formattedCondition.toString(),
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
