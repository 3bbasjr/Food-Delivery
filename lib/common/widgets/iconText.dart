import 'package:flutter/cupertino.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/space/spaceWidget.dart';
import 'package:food_delivery/common/widgets/smallText.dart';

class iconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const iconText({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        HorizontalSpace(0.2),
        smallText(text: text,),

      ],
    );
  }
}
