import 'dart:math';

import 'package:flutter/material.dart';
import 'package:junction2023/common/card_container.dart';
import 'package:junction2023/common/colors.dart';
import 'package:junction2023/dashboard_store.dart';
import 'package:junction2023/room_data_model.dart';
import 'package:junction2023/room_page.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

class DashboardGridItem extends StatelessWidget {
  final RoomDataModel model;
  final DashboardStore store;

  const DashboardGridItem(this.model, this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CardContainer(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RoomPage(model.name, store))),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              model.name,
              style: TextStyle(
                  color: model.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: RoomPainer(
                      model.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor,
                      model.airQuality == AirQuality.poor ? accentWarningColor : ColorStore.accentColor,
                      model.vertices,
                      model.detectedPeople),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomPainer extends CustomPainter {
  final Color wallsColor;
  final Color peopleColor;
  final List<Point> vertices;
  final List<Point> detectedPeople;

  RoomPainer(this.wallsColor, this.peopleColor, this.vertices, this.detectedPeople);

  late final peoplePaint = Paint()
    ..color = peopleColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  late final wallsPaint = Paint()
    ..color = wallsColor
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < detectedPeople.length; i++) {
      drawPoint(detectedPeople[i], size, canvas);
    }

    final path = Path();
    path.moveTo(relativeToAbsolute(vertices[0], size).dx, relativeToAbsolute(vertices[0], size).dy);

    for (int i = 0; i < vertices.length; i++) {
      // final point = relativeToAbsolute(vertices[i], size), relativeToAbsolute(vertices[i + 1], size;
      path.lineTo(relativeToAbsolute(vertices[i], size).dx, relativeToAbsolute(vertices[i], size).dy);
      // canvas.drawLine(relativeToAbsolute(vertices[i], size), relativeToAbsolute(vertices[i + 1], size), paint);
    }
    path.lineTo(relativeToAbsolute(vertices[0], size).dx, relativeToAbsolute(vertices[0], size).dy);

    canvas.drawPath(path, wallsPaint);
    // canvas.drawLine(
    //     relativeToAbsolute(vertices[0], size), relativeToAbsolute(vertices[vertices.length - 1], size), paint);
  }

  Offset relativeToAbsolute(Point relative, Size size) {
    final x = (relative.x + 1) * size.width / 2;
    final y = (relative.y + 1) * size.height / 2;
    return Offset(x, y);
  }

  void drawPoint(Point point, Size size, Canvas canvas) {
    // final x = (random.nextDouble() * (maxX - minX) + minX) / 2;
    // final y = random.nextDouble() * (maxY - minY) + minY;
    // if (Poly.isPointInPolygon(Point(x: x, y: y), vertices)) {
    canvas.drawCircle(relativeToAbsolute(point, size), 3, peoplePaint);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
