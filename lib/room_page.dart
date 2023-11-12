import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junction2023/common/colors.dart';
import 'package:junction2023/dashboard_grid_item.dart';
import 'package:junction2023/dashboard_store.dart';
import 'package:junction2023/fan_unit_grid_item.dart';

import 'room_data_model.dart';

class RoomPage extends StatefulWidget {
  final String roomId;
  final DashboardStore store;

  const RoomPage(this.roomId, this.store, {super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    final room = widget.store.rooms.firstWhere((element) => element.name == widget.roomId);

    return Scaffold(
      backgroundColor: ColorStore.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorStore.secondaryColor,
        title: Text(
          widget.roomId,
          style: TextStyle(
            color: room.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListenableBuilder(
          listenable: widget.store,
          builder: (context, _) {
            final room = widget.store.rooms.firstWhere((element) => element.name == widget.roomId);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: CustomPaint(
                      painter: RoomPainer(
                          room.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor,
                          room.airQuality == AirQuality.poor ? accentWarningColor : ColorStore.accentColor,
                          room.vertices,
                          room.detectedPeople),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Air quality',
                    style: TextStyle(fontSize: 20, color: room.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor),
                  ),
                  Text(room.airQuality.name,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: room.airQuality == AirQuality.poor ? accentWarningColor : ColorStore.accentColor)),
                  SizedBox(height: 40),
                  _grid(room),
                ],
              ),
            );
          }),
    );
  }

  Widget _grid(RoomDataModel room) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: room.fanUnits.length,
      itemBuilder: (BuildContext context, int index) {
        return FanUnitGridItem(room.fanUnits[index], room.airQuality == AirQuality.poor ? primaryWarningColor : ColorStore.primaryColor);
      },
    );
  }
}
