import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/common/routes/RouteHelper.dart';
import 'package:food_delivery/common/space/spaceWidget.dart';
import 'package:food_delivery/common/widgets/boldText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/sizeConfig/sizeConfig.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    goToNextView();
  }
  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return Scaffold(
      backgroundColor: colors.white,
      body: Container(
        child: Column(
          children: [
            Spacer(),
            FadeTransition(
              opacity: fadingAnimation!,
              child: boldText(text: 'Food Delivery',size: 45,),
            ),
            VerticalSpace(3),
            Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/man'
                      '.png',
                  fit: BoxFit.fill,
                )),
          ],
        ),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(Duration(seconds: 3),(){
      Get.to(()=> RouteHelper.getInitial(),transition: Transition.fade);
    });
  }
}
