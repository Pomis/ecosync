import 'dart:ui';

import 'package:point_in_polygon/point_in_polygon.dart';

class RoomDataModel {
  final String name;
  final List<Point> detectedPeople;
  final List<FanUnit> fanUnits;
  final List<Point> vertices;
  final AirQuality airQuality;

  RoomDataModel(this.name, this.detectedPeople, this.fanUnits, this.airQuality, this.vertices);
}

enum AirQuality {
  poor("Poor (1000+ ppm)"), moderate("Moderate (800-1000)"), good("Good (500-800ppm)"), excellent("Excellent (no more than 500 ppm)");

  final String name;

  const AirQuality(this.name);

}

class FanUnit {
  final String name;
  final double power;

  FanUnit(this.name, this.power);
}

