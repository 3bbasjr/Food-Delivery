import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/widgets/smallText.dart';
import 'package:food_delivery/common/colors/colors.dart';
import '../space/spaceWidget.dart';
import 'boldText.dart';
import 'iconText.dart';

class appColumn extends StatelessWidget {
  const appColumn({Key? key, required this.text}) : super(key: key);
  final String text;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(text: text,size: Dimensions.font26,),
        VerticalSpace(1),
        Row(
          children: [
            Wrap(children: List.generate(5, (index) => Icon(Icons.star,size: 15,color: colors.primary,)),),
            HorizontalSpace(0.3),
            smallText(text: '4.5'),
            HorizontalSpace(1),
            smallText(text: '1287'),
            HorizontalSpace(0.3),
            smallText(text: 'comments'),

          ],
        ),
        VerticalSpace(1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconText(icon: Icons.circle_sharp, text: 'Normal', iconColor: colors.yellow),
            iconText(icon: Icons.location_on, text: '1.7km', iconColor: colors.primary),
            iconText(icon: Icons.access_time_rounded, text: ' 32min', iconColor: colors.red),
          ],
        )
      ],
    );
  }
}
