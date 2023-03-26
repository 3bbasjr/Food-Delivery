import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/sizeConfig/sizeConfig.dart';
import 'package:food_delivery/common/space/spaceWidget.dart';
import 'package:food_delivery/common/widgets/boldText.dart';
import 'package:food_delivery/common/widgets/smallText.dart';

import 'mainFoodBody.dart';

class mainFood extends StatefulWidget {
  const mainFood({Key? key}) : super(key: key);

  @override
  State<mainFood> createState() => _mainFoodState();
}

class _mainFoodState extends State<mainFood> {
  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
           VerticalSpace(5),
          Container(
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.height15,right:Dimensions.height15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      boldText(text: 'Egypt', color: colors.primary,size: Dimensions.font30,),
                      VerticalSpace(0.7),
                      Row(
                        children: [
                          smallText(text: 'Cairo'),
                          HorizontalSpace(0.3),
                          Icon(Icons.arrow_drop_down_circle_rounded , size: Dimensions.font15,)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search,color: colors.white,size: Dimensions.iconSize24,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: colors.primary
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: mainFoodBody(),
          ))
        ],
      ),
    );
  }
}
