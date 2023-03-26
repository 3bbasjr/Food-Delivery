import 'package:flutter/material.dart';
import 'package:food_delivery/features/controllers/PopularProductController.dart';
import 'package:food_delivery/features/screens/cart/CartPage.dart';
import 'package:food_delivery/features/screens/splash/splashScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common/routes/RouteHelper.dart';
import 'features/controllers/RecommendedProductController.dart';
import 'features/screens/food/popularFood.dart';
import 'features/screens/food/recommendedFood.dart';
import 'features/screens/home/mainFood.dart';
import 'features/helper/dependencies.dart' as dep;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto'
      ),
      home: mainFood(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes


    );
  }
}
