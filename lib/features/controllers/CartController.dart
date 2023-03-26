import 'package:food_delivery/features/data/repository/CartRepo.dart';
import 'package:get/get.dart';
import 'package:food_delivery/common/colors/colors.dart';
import '../models/CartModel.dart';
import '../models/productModel.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int , CartModel> _items={};
  Map<int , CartModel>get items  =>_items;

  void addItem({required ProductModel product,required int quantity}){
var totalQuantity=0;
    if(_items.containsKey(product.id!)){
    _items.update(product.id!, (value) {
      totalQuantity=value.quantity!+quantity;
      return CartModel(
          id : value.id,
          name : value.name,
          price: value.price,
          img : value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
        product: product,
      );
    });
    if(totalQuantity<=0){
      _items.remove(product.id!);
    }
    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {

          return CartModel(
              id : product.id,
              name : product.name,
              price: product.price,
              img : product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
            product: product,
          );});
      }else{
        Get.snackbar('Item count', "You should add at least one item",
                  backgroundColor: colors.primary,
                  colorText: colors.white
              );

      }
    }
    update();
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
      return quantity;
    }
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
     return e.value;
    }).toList();
  }
}