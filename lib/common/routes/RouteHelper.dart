import 'package:food_delivery/features/screens/food/recommendedFood.dart';
import 'package:food_delivery/features/screens/home/mainFood.dart';
import 'package:food_delivery/features/screens/food/popularFood.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../features/screens/cart/CartPage.dart';

class RouteHelper{
  static const String initial = '/';
  static const String popularfood  = '/popular-food';
  static const String recommendedfood  = '/recommended-food';
  static const String cartpage  = '/cart-page';

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageID)=> '$popularfood?pageID=$pageID';
  static String getRecommendedFood(int pageID)=> '$recommendedfood?pageID=$pageID';
  static String getCartPage()=> '$cartpage';
  static List<GetPage> routes = [
    GetPage(name: '/', page: ()=>mainFood()),
    GetPage(name: popularfood, page: (){
      var pageID=Get.parameters['pageID'];
      return popularFood(pageID: int.parse(pageID!));
    }
    ,transition: Transition.fadeIn
    ),
    GetPage(name: recommendedfood, page: (){
      var pageID=Get.parameters['pageID'];
      return recommendedFood(pageID: int.parse(pageID!));
    }
    ,transition: Transition.fadeIn
    ),
    GetPage(name: cartpage, page: (){
      var pageID=Get.parameters['pageID'];
      return  CartPage();
    }
    ,transition: Transition.fadeIn
    ),
  ];
}