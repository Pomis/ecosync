import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:junction2023/room_data_model.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

class DashboardStore extends ChangeNotifier {
  List<RoomDataModel> rooms = [];
  final random = math.Random();

  late final case1 = [
    _createRoom(
        "Green Hall",
        24,
        [
          Point(x: -1, y: 1),
          Point(x: 1, y: 1),
          Point(x: 1, y: -0.3),
          Point(x: -1, y: -0.3),
        ],
        AirQuality.poor,
        [FanUnit('Fan 1', 1)]),
    _createRoom(
      "Meeting Room",
      3,
      [
        Point(x: -1, y: 0.6),
        Point(x: 0.2, y: 0.6),
        Point(x: 1, y: 0.2),
        Point(x: 1, y: -0.6),
        Point(x: -1, y: -0.6),
      ],
      AirQuality.moderate,
      [FanUnit('Fan 1', 0.2)],
    ),
    _createRoom(
        "Kitchen",
        1,
        [
          Point(x: -1, y: 0.5),
          Point(x: -0.8, y: 0.5),
          Point(x: -0.8, y: 0),
          Point(x: 0.8, y: 0),
          Point(x: 0.8, y: 0.5),
          Point(x: 1, y: 0.5),
          Point(x: 1, y: -0.5),
          Point(x: -1, y: -0.5),
        ],
        AirQuality.excellent,
        [FanUnit('Fan 1', 0.1)]),
    _createRoom(
        "Red Hall",
        4,
        [
          Point(x: -1, y: 0.7),
          Point(x: 1, y: 0.7),
          Point(x: 1, y: -0.7),
          Point(x: -1, y: -0.7),
        ],
        AirQuality.good,
        [
          FanUnit('Fan 1', 0.87),
          FanUnit('Fan 2', 0.3),
        ]),
    _createRoom(
        "Lounge",
        1,
        [
          Point(x: -1, y: 0.4),
          Point(x: 1, y: 0.4),
          Point(x: 1, y: -0.4),
          Point(x: -1, y: -0.4),
        ],
        AirQuality.excellent,
        [FanUnit('Fan 1', 0)])
  ];

  late final case2 = [
    _createRoom(
        "Green Hall",
        12,
        [
          Point(x: -1, y: 1),
          Point(x: 1, y: 1),
          Point(x: 1, y: -0.3),
          Point(x: -1, y: -0.3),
        ],
        AirQuality.good,
        [FanUnit('Fan 1', 1)]),
    _createRoom(
      "Meeting Room",
      3,
      [
        Point(x: -1, y: 0.6),
        Point(x: 0.2, y: 0.6),
        Point(x: 1, y: 0.2),
        Point(x: 1, y: -0.6),
        Point(x: -1, y: -0.6),
      ],
      AirQuality.moderate,
      [FanUnit('Fan 1', 0.2)],
    ),
    _createRoom(
        "Kitchen",
        1,
        [
          Point(x: -1, y: 0.5),
          Point(x: -0.8, y: 0.5),
          Point(x: -0.8, y: 0),
          Point(x: 0.8, y: 0),
          Point(x: 0.8, y: 0.5),
          Point(x: 1, y: 0.5),
          Point(x: 1, y: -0.5),
          Point(x: -1, y: -0.5),
        ],
        AirQuality.excellent,
        [FanUnit('Fan 1', 0.1)]),
    _createRoom(
        "Red Hall",
        4,
        [
          Point(x: -1, y: 0.7),
          Point(x: 1, y: 0.7),
          Point(x: 1, y: -0.7),
          Point(x: -1, y: -0.7),
        ],
        AirQuality.good,
        [
          FanUnit('Fan 1', 0.87),
          FanUnit('Fan 2', 0.3),
        ]),
    _createRoom(
        "Lounge",
        1,
        [
          Point(x: -1, y: 0.4),
          Point(x: 1, y: 0.4),
          Point(x: 1, y: -0.4),
          Point(x: -1, y: -0.4),
        ],
        AirQuality.excellent,
        [FanUnit('Fan 1', 0)])
  ];

  void loadData(bool badScenario) async {
    rooms.clear();
    rooms.addAll(badScenario ? case1 : case2);
    notifyListeners();

    Timer.periodic(Duration(milliseconds: 300), (timer) {
      final updatedRooms = rooms.map((it) => _randomizeRoom(it)).toList();
      rooms.clear();
      rooms.addAll(updatedRooms);
      notifyListeners();
    });
  }

  RoomDataModel _createRoom(
      String name, int initialPeople, List<Point> vertices, AirQuality airQuality, List<FanUnit> fanUnits) {
    final maxX = vertices.map((e) => e.x).reduce(math.max);
    final minX = vertices.map((e) => e.x).reduce(math.min);
    final maxY = vertices.map((e) => e.y).reduce(math.max);
    final minY = vertices.map((e) => e.y).reduce(math.min);

    final people = <Point>[
      for (int i = 0; i < initialPeople; i++)
        Point(
          x: minX + (random.nextDouble() * (maxX - minX)),
          y: minY + (random.nextDouble() * (maxY - minY)),
        ),
    ];
    // final occupancy = people.where((it) => it.rssi > 0.5).fold(0.0, (acc, it) => acc + it.rssi) / people.length;
    return RoomDataModel(name, people, fanUnits, airQuality, vertices);
  }

  RoomDataModel _randomizeRoom(RoomDataModel model) {
    final maxX = model.vertices.map((e) => e.x).reduce(math.max);
    final minX = model.vertices.map((e) => e.x).reduce(math.min);
    final maxY = model.vertices.map((e) => e.y).reduce(math.max);
    final minY = model.vertices.map((e) => e.y).reduce(math.min);

    final movement = random.nextDouble() * 0.05;

    final detectedPeople = model.detectedPeople.map((it) {
      var x = it.x + random.nextDouble() * movement - movement / 2;
      var y = it.y + random.nextDouble() * movement - movement / 2;
      if (x < minX) x = minX;
      if (x > maxX) x = maxX;
      if (y < minY) y = minY;
      if (y > maxY) y = maxY;

      return Point(
        x: x,
        y: y,
      );
    }).toList();
    return RoomDataModel(model.name, detectedPeople, model.fanUnits, model.airQuality, model.vertices);
  }
}
