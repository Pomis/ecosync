import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junction2023/room_data_model.dart';

import 'common/card_container.dart';
import 'common/colors.dart';

class FanUnitGridItem extends StatelessWidget {
  final FanUnit fanUnit;
  final Color color;

  const FanUnitGridItem(this.fanUnit, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CardContainer(
        margin: EdgeInsets.zero,
        color: color,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              fanUnit.name,
              style: TextStyle(color: ColorStore.secondaryColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset('assets/ventilation-fan-svgrepo-com.svg', color: ColorStore.secondaryColor, height: 60,),
            SizedBox(width: double.infinity),
            Text(
              "${fanUnit.power * 100}%",
              style: TextStyle(color: ColorStore.secondaryColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}