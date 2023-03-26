import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/common/routes/RouteHelper.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/widgets/boldText.dart';
import 'package:food_delivery/common/widgets/smallText.dart';
import 'package:food_delivery/features/constants/appConstants.dart';
import 'package:food_delivery/features/controllers/CartController.dart';
import 'package:food_delivery/features/screens/home/mainFood.dart';
import 'package:get/get.dart';

import '../../../common/sizeConfig/sizeConfig.dart';
import '../../../common/space/spaceWidget.dart';
import '../../../common/widgets/appIcon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.height20,
              top: Dimensions.height20*3,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> mainFood());
                    } ,
                    child: appIcon(icon: Icons.arrow_back_ios,
                    iconColor: colors.white,
                    backgroundColor: colors.primary,
                        iconSize: Dimensions.iconSize24,),
                  ),
                  HorizontalSpace(10),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    } ,
                    child: appIcon(icon: Icons.home_outlined,
                      iconColor: colors.white,
                      backgroundColor: colors.primary,
                      iconSize: Dimensions.iconSize24,),
                  ),
                  appIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: colors.white,
                    backgroundColor: colors.primary,
                    iconSize: Dimensions.iconSize24,),
                ],
          )),
          Positioned(
              top: Dimensions.height100,
              left: Dimensions.height20,
              right: Dimensions.height20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),

                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList =cartController.getItems  ;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_,index){
                          return Container(
                            height: Dimensions.height100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.height100,
                                  height: Dimensions.height100,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            AppConstants.BASE_URL+AppConstants.UPLOAD+cartController.getItems[index].img!
                                          )),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: colors.white
                                  ),
                                ),
                                HorizontalSpace(1),
                                Expanded(child: Container(
                                  height: Dimensions.height100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      boldText(text: cartController.getItems[index].name!,color: colors.grey2,),
                                      smallText(text: 'Spicy'),
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                        children: [
                                          boldText(text: cartController.getItems[index].price!.toString(),color: colors.red,),
                                          Container(
                                            padding: EdgeInsets.all(Dimensions.height10),
                                            decoration: BoxDecoration(
                                                color: colors.white,
                                                borderRadius: BorderRadius.circular(Dimensions.radius20)
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: (){
                                                      cartController.addItem(product: _cartList[index].product!, quantity: -1);
                                                    },
                                                    child: Icon(Icons.remove,color: colors.grey,)),
                                                HorizontalSpace(1.5),
                                                boldText(text: _cartList[index].quantity.toString(),//"popularProduct.inCartItems.toString()"
                                                ),
                                                HorizontalSpace(1.5),
                                                GestureDetector(
                                                    onTap: (){
                                                      cartController.addItem(product: _cartList[index].product!, quantity: 1);
                                                    },
                                                    child: Icon(Icons.add,color: colors.grey,)),
                                              ],
                                            ),
                                          ),
                                        ],)
                                    ],
                                  ),
                                ))
                              ],
                            ),);
                        });
                  },)
                ),
          ))
        ],
      ),
    );
  }
}
