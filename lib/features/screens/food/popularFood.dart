import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/sizeConfig/sizeConfig.dart';
import 'package:food_delivery/common/widgets/appColumn.dart';
import 'package:food_delivery/common/widgets/appIcon.dart';
import 'package:food_delivery/common/widgets/expandableText.dart';
import 'package:food_delivery/features/constants/appConstants.dart';
import 'package:food_delivery/features/controllers/CartController.dart';
import 'package:food_delivery/features/controllers/PopularProductController.dart';
import 'package:food_delivery/features/screens/cart/CartPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/routes/RouteHelper.dart';
import '../../../common/space/spaceWidget.dart';
import '../../../common/widgets/boldText.dart';
import '../../../common/widgets/smallText.dart';
import '../home/mainFood.dart';

class popularFood extends StatefulWidget {
  int pageID;
  popularFood({Key? key,required this.pageID,}) : super(key: key);

  @override
  State<popularFood> createState() => _popularFoodState();
}

class _popularFoodState extends State<popularFood> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    var product=Get.find<PopularProductController>().popularProductList[widget.pageID];
    Get.find<PopularProductController>().initProduct(product ,Get.find<CartController>());
    return Scaffold(
      backgroundColor: colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
            width: double.maxFinite,
                height: Dimensions.popularFoodImg,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(
                        AppConstants.BASE_URL+AppConstants.UPLOAD+product.img
                      ))
                ),
          )),
          Positioned(
            top: Dimensions.height45,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        Get.toNamed(RouteHelper.getInitial());
                       },
                      child: appIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems >=1)
                        Get.toNamed(RouteHelper.getCartPage());

                      } ,
                      child: Stack(
                        children: [
                          appIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >=1?
                      Positioned(
                          right:0,top:0,
                          child: appIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,backgroundColor: colors.primary,)):
                          Container(),
                          Get.find<PopularProductController>().totalItems >=1?
                          Positioned(
                              right:3,top:3,
                              child:
                              boldText(text:Get.find<PopularProductController>().totalItems.toString(),
                              size: 12, color: colors.white,
                              )
                          ):
                          Container()

                        ],
                      ),
                    );
                  })

                ],
          )),
          Positioned(
              left: 0,
              right: 0,
              top:Dimensions.popularFoodImg -20 ,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.height20,top: Dimensions.height20,right: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appColumn(text: product.name,),
                    VerticalSpace(2),
                    boldText(text:'Introduce' ),
                    VerticalSpace(2),
                    Expanded(child: SingleChildScrollView(child:
                    Wrap(
                      children: [
                        Text(product.description!,
                          style: TextStyle(
                            height:1.8,color: colors.grey3,fontSize: Dimensions.font16,
                          ),

                        maxLines:hidden?1: null ,
                        ),
                        InkWell(
                            onTap:  (){
                              hidden = !hidden;
                              setState(() {

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
                    )
                    ))
                  ],
                )
              ),

          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,right: Dimensions.height20,left: Dimensions.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              ),
              color: colors.shadowGrey
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.height15),
                decoration: BoxDecoration(
                    color: colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: colors.grey,)),
                    HorizontalSpace(1.5),
                    boldText(text: popularProduct.inCartItems.toString()),
                    HorizontalSpace(1.5),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: colors.grey,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height15),
                  child: boldText(text: "\$ ${product.price!}  "+"| Add to cart",color: colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: colors.primary
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
