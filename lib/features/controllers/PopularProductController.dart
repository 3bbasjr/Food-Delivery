import 'dart:convert';

import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/features/controllers/CartController.dart';
import 'package:food_delivery/features/data/repository/PopularProductRepo.dart';
import 'package:food_delivery/features/models/productModel.dart';
import 'package:get/get.dart';

import '../models/CartModel.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  int _quantity=0; 
  int get quantity => _quantity;
  int _inCartItems=0;
  int get inCartItems =>_inCartItems+_quantity;

  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();

    if(response.statusCode==200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded=true;
      update();
    }else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar('Item count', "You can't reduce more",
      backgroundColor: colors.primary,
        colorText: colors.white
      );
      if(_inCartItems>0){
        _quantity= -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar('Item count', "You can't add more",
          backgroundColor: colors.primary,
          colorText: colors.white
      );
      return 20;
    }else{
      return quantity;
    }
  }


  void initProduct(ProductModel product , CartController cart){
  _quantity=0;
  _inCartItems=0;
  _cart = cart;
  var exist = false;
  exist = _cart.existInCart(product);
  //get from storage to ^^
    print("//////////'''''''exist"+ exist.toString());
    if(exist){
      _inCartItems=_cart.getQuantity(product);
      print("//////////'''''''quantity in cart"+ _inCartItems.toString());
    }
  }

  void addItem(ProductModel product){
      _cart.addItem(product: product, quantity: _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("////////ID is " + value.id.toString() +"//////quantity is"+value.quantity.toString());
      });
    update();

  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}