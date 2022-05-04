import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../widgets/back_change.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TextEditingController cityController = TextEditingController();

  late String Status = '............';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: FutureBuilder(
        future: changeWeather(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.hasData
          ) {
            http.Response response = snapshot.data ?? http.Response('', 420);
            Map map = convert.json.decode(response.body);

            final list = map['weather'];
            Map mapW = list[0];

            Map mapM = map['main'];
            final Temp = (mapM['feels_like'] - 273.15);
            String temp =
            Temp.toString().substring(0, Temp.toString().indexOf('.') + 2);

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  height: size.height * 0.90,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: backChange(double.parse(temp)),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: size.height * 0.7,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: iconChange(mapW['description'].toString()),
                          ),
                          Text(
                            '${temp}°',
                            style: TextStyle(
                                fontSize: 90, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (mapW['description']).toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          // Text(
                          //   'Tehran',
                          //   style: TextStyle(
                          //     fontSize: 30,
                          //   ),
                          // ),
                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 40,
                                child: TextField(
                                  controller: cityController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    hintText: 'City Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: 150,
                                height: 30,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.black26,
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    changeCity(cityController.text);
                                  },
                                  child: Text('OK'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }
        },
      ),
    );
  }

  void changeCity(City) async {
    print(City);
    if (City.length == 0) {
      City = 'tehran';
    }

    http.Response response = await http.post(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/weather?q=${City}&appid=bad4ad67fe76157b5bc1ef846793019d'),
        body: convert.json.encode({"name": City}),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        });

    print(response.statusCode);
    print(response.body);
  }

  Future<http.Response> changeWeather() async {
    String City = cityController.text;
    print(City);
    if (City.length == 0) {
      City = 'tehran';
    }

    http.Response response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=${City}&appid=bad4ad67fe76157b5bc1ef846793019d'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
}
