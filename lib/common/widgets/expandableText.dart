import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/widgets/smallText.dart';
import 'package:food_delivery/common/colors/colors.dart';

class expandableText extends StatefulWidget {
  const expandableText({Key? key, required this.text}) : super(key: key);
final String text;

  @override
  State<expandableText> createState() => _expandableTextState();
}

class _expandableTextState extends State<expandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hidden = true;
  double textHeight = Dimensions.screenHeight/5.63;
  @override
  void initState() {
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?smallText(
        height:1.8,
        size: Dimensions.font16,
        text: firstHalf,
        color: colors.grey3,):Column(
        children: [
          smallText(height:1.8,color: colors.grey3,size: Dimensions.font16,text: hidden?(firstHalf+'...'):(firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hidden = !hidden;
              });
            },
            child: hidden? Row(
              children: [
                smallText(text: 'Show more',color: colors.primary,),
                Icon(Icons.arrow_drop_down,color: colors.primary,)
              ],
            ):
            Row(
              children: [
                smallText(text: 'Show less',color: colors.primary,),
                Icon(Icons.arrow_drop_up,color: colors.primary,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
