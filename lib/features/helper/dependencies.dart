import 'package:food_delivery/features/constants/appConstants.dart';
import 'package:food_delivery/features/controllers/CartController.dart';
import 'package:food_delivery/features/controllers/PopularProductController.dart';
import 'package:food_delivery/features/data/repository/CartRepo.dart';
import 'package:food_delivery/features/data/repository/PopularProductRepo.dart';
import 'package:get/get.dart';
import '../../features/data/api/api.dart';
import '../controllers/RecommendedProductController.dart';
import '../data/repository/RecommendedProdecutReop.dart';

Future<void> init()async{
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));

  Get.lazyPut(()=>PopularProductRepo(apiClient:Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient:Get.find()));
  Get.lazyPut(()=>CartRepo());
  
  
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(()=>CartController(cartRepo: Get.find()));

}