import 'package:flutter/material.dart';

AssetImage backChange(temp) {
  if (temp > 30) {
    return const AssetImage('assets/images/Hot.jpg');
  } else if (temp >= 20 && temp <= 30) {
    return const AssetImage('assets/images/Spring.jpg');
  } else if (temp >= 5 && temp <= 20) {
    return const AssetImage('assets/images/rainy.jpg');
  } else {
    return const AssetImage('assets/images/Snowy.jpg');
  }
}


AssetImage iconChange(String description) {
  if (description == "dust") {
    return const AssetImage('assets/icons/partly_cloudy.png');
  } else if (description == "few clouds") {
    return const AssetImage('assets/icons/rain_s_cloudy.png');
  } else if (description == "clear sky") {
    return const AssetImage('assets/icons/sunny_s_cloudy.png');
  } else if (description == "overcast clouds") {
    return const AssetImage('assets/icons/cloudy.png');
  } else if (description == "scattered clouds") {
    return const AssetImage('assets/icons/rain_light.png');
  } else if (description == 'sunny') {
    return const AssetImage('assets/icons/sunny.png');
  } else {
    return const AssetImage('assets/icons/snow_s_cloudy.png');
  }
}