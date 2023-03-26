import 'package:flutter/cupertino.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';

class smallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  smallText(
      {Key? key,
      this.color = const  Color(0xff8d8d8d),
      this.height = 1.2,
      required this.text,
      this.size = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: Dimensions.font15, height: height,),
      );
  }
}
