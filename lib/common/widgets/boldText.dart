import 'package:flutter/cupertino.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';

class boldText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
   boldText ({Key? key, this.color = const Color(0xFF2f2e41),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize:size==0? Dimensions.font20:size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto'
      ),
    );
  }
}
