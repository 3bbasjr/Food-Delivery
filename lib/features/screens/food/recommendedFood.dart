import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';
import 'package:food_delivery/common/routes/RouteHelper.dart';
import 'package:food_delivery/common/sizeConfig/Dimensions.dart';
import 'package:food_delivery/common/sizeConfig/sizeConfig.dart';
import 'package:food_delivery/common/widgets/appIcon.dart';
import 'package:food_delivery/common/widgets/boldText.dart';
import 'package:food_delivery/features/controllers/PopularProductController.dart';
import 'package:food_delivery/features/screens/cart/CartPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/space/spaceWidget.dart';
import '../../../common/widgets/expandableText.dart';
import '../../../common/widgets/smallText.dart';
import '../../constants/appConstants.dart';
import '../../controllers/CartController.dart';
import '../../controllers/RecommendedProductController.dart';

class recommendedFood extends StatefulWidget {
  int pageID;
  recommendedFood({Key? key,required this.pageID}) : super(key: key);

  @override
  State<recommendedFood> createState() => _recommendedFoodState();
}

class _recommendedFoodState extends State<recommendedFood> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {

    sizeConfig().init(context);
    var product=Get.find<RecommendedProductController>().recommendedProductList[widget.pageID];
    Get.find<PopularProductController>().initProduct(product ,Get.find<CartController>());
    print('page id is :'+widget.pageID.toString());
    print('product name is :'+product.name.toString());
    return Scaffold(
      backgroundColor: colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: appIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems >=1)
                      Get.toNamed(RouteHelper.getCartPage());
                    } ,
                    child: Stack(
                      children: [
                        appIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >=1?
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
            ),
            bottom: PreferredSize(
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                  ),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5,bottom: 10),
                    child: Center(child: boldText(text: product.name,size: Dimensions.font26,))),
                preferredSize: Size.fromHeight(20)),
        pinned: true,
            backgroundColor: colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD+product.img,
              width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:Column(
              children: [
            Container(
              margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
              child:
              Wrap(
                children: [
                  Text(product.description!,
                    style: TextStyle(
                      height:1.8,color: colors.grey3,fontSize: Dimensions.font16,
                    ),

                    maxLines:hidden?1: null
                    ,
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
            )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.height20*2.5,
                right: Dimensions.height20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                onTap: (){
                controller.setQuantity(false);
                },
                child:
                  appIcon(icon: Icons.remove,backgroundColor: colors.primary,iconColor: colors.white,iconSize: Dimensions.iconSize24,)),
                  boldText(text: "\$ ${product.price!}  X  ${controller.inCartItems} ",color: colors.grey3,size: Dimensions.font26,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: appIcon(icon: Icons.add,backgroundColor: colors.primary,iconColor: colors.white,iconSize: Dimensions.iconSize24,)),
                ],
              ),
            ),
            Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: colors.primary,

                      )
                  ),
                  GestureDetector(
                    onTap:(){
                      controller.addItem(product);
                    } ,
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height15),
                      child: boldText(text: '\$ ${product.price!}  | Add to cart',color: colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: colors.primary
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}
