import 'dart:convert';

import 'package:food_delivery/features/models/productModel.dart';
import 'package:get/get.dart';

import '../data/repository/RecommendedProdecutReop.dart';


class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _RecommendedProductList = [];
  List<dynamic> get recommendedProductList => _RecommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;


  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();

    if(response.statusCode==200){
      _RecommendedProductList = [];
      _RecommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_RecommendedProductList);
      _isLoaded=true;
      update();
    }else{
      print('/////Recommended products faileed loading///////////////);');

    }
  }
}