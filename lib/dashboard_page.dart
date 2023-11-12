import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junction2023/dashboard_store.dart';
import 'package:junction2023/room_data_model.dart';

import 'common/colors.dart';
import 'dashboard_grid_item.dart';

class DashboardPage extends StatefulWidget {
  final bool badScenario;

  const DashboardPage(this.badScenario, {super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _store = DashboardStore();

  @override
  void initState() {
    super.initState();
    _store.loadData(widget.badScenario);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _store,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: _store.rooms.any((element) => element.airQuality == AirQuality.poor) ? primaryWarningColor : ColorStore.primaryColor,
          body: ListenableBuilder(
              listenable: _store,
              builder: (context, _) {
                return SafeArea(
                  child: Column(children: [
                    ..._header(),
                    ..._grid(),
                  ]),
                );
              }),
        );
      }
    );
  }

  List<Widget> _header() {
    if (_store.rooms.any((element) => element.airQuality == AirQuality.poor)) {
      return [
        const SizedBox(width: double.infinity),
        SvgPicture.asset(
          'assets/warning-circle-svgrepo-com.svg',
          color: secondaryWarningColor,
          height: 100,
          width: 100,
        ),
        Text(
          "Air quality requires attention",
          style: TextStyle(
            color: secondaryWarningColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        )
      ];
    }
    return [
      const SizedBox(width: double.infinity),
      SvgPicture.asset(
        'assets/check-circle-svgrepo-com.svg',
        color: ColorStore.secondaryColor,
        height: 100,
        width: 100,
      ),
      Text(
        "All good now",
        style: TextStyle(
          color: ColorStore.secondaryColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      )
    ];
  }

  List<Widget> _grid() {
    return [
      if (_store.rooms.isNotEmpty)
        AlignedGridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(20),
          itemCount: _store.rooms.length,
          itemBuilder: (BuildContext context, int index) {
            return DashboardGridItem(_store.rooms[index], _store);
          },
        ),
    ];
  }
}
