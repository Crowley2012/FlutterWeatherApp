import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather/widgets/widgets.dart';
import 'package:flutter_weather/blocs/blocs.dart';

import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoaded) {
              BlocProvider.of<ThemeBloc>(context).add(
                WeatherChanged(condition: state.weather[0].condition),
              );
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return GradientContainer(
                    color: themeState.color,
                    child: RefreshIndicator(
                      onRefresh: () {
                        BlocProvider.of<WeatherBloc>(context).add(
                          RefreshWeather(city: weather[0].location),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Location(location: weather[0].location),
                            ),
                          ),
                          Center(
                            child: LastUpdated(dateTime: weather[0].lastUpdated),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                            child: Center(
                              child: CombinedWeatherTemperature(
                                weather: weather[0],
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: 
                                Text(
                                  DateFormat('EEEE').format(DateTime.now().add(Duration(days: 1))), 
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.65,
                            child: 
                              Center(
                                child: CombinedWeatherTemperature(weather:weather[1]),
                              ),
                          ),
                          Container(
                            height: 1.0,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: 
                                Text(
                                  DateFormat('EEEE').format(DateTime.now().add(Duration(days: 2))), 
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.65,
                            child: 
                              Center(
                                child: CombinedWeatherTemperature(weather:weather[2]),
                              ),
                          ),
                          Container(
                            height: 1.0,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: 
                                Text(
                                  DateFormat('EEEE').format(DateTime.now().add(Duration(days: 3))), 
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.65,
                            child: 
                              Center(
                                child: CombinedWeatherTemperature(weather:weather[3]),
                              ),
                          ),
                          Container(
                            height: 1.0,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: 
                                Text(
                                  DateFormat('EEEE').format(DateTime.now().add(Duration(days: 4))), 
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.65,
                            child: 
                              Center(
                                child: CombinedWeatherTemperature(weather:weather[4]),
                              ),
                          ),
                          Container(
                            height: 1.0,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: 
                                Text(
                                  DateFormat('EEEE').format(DateTime.now().add(Duration(days: 5))), 
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.65,
                            child: 
                              Center(
                                child: CombinedWeatherTemperature(weather:weather[5]),
                              ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(child: Text('Please Select a Location'));
          },
        ),
      ),
    );
  }
}
