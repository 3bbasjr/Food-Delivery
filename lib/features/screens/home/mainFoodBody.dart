
import 'package:food_delivery/common/routes/RouteHelper.dart';
import 'package:food_delivery/features/controllers/PopularProductController.dart';
import 'package:food_delivery/features/controllers/RecommendedProductController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../common/sizeConfig/Dimensions.dart';
import '../../../common/space/spaceWidget.dart';
import '../../../common/widgets/appColumn.dart';
import '../../../common/widgets/boldText.dart';
import '../../../common/widgets/iconText.dart';
import '../../../common/widgets/smallText.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors/colors.dart';

import '../../constants/appConstants.dart';
import '../food/popularFood.dart';
import '../food/recommendedFood.dart';

class mainFoodBody extends StatefulWidget {
  const mainFoodBody({Key? key}) : super(key: key);

  @override
  State<mainFoodBody> createState() => _mainFoodBodyState();
}

class _mainFoodBodyState extends State<mainFoodBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _pageValue = 0.0;
  double _scaleFactor=0.8;
 double height= Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState((){
        _pageValue =  pageController.page!;
      });
    });
  }
  @override
  void dispose() {
  pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context , position){
                  return buildPageItem(position,popularProducts.popularProductList[position]);
                }),
          ):CircularProgressIndicator(
            color: colors.primary,
          );
        }),
        //dotsIndicator
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _pageValue,
            decorator: DotsDecorator(
              activeColor: colors.primary,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        VerticalSpace(3),
        Container(
          margin: EdgeInsets.only(left: Dimensions.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              boldText(text: 'Recommended'),
              HorizontalSpace(1),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: boldText(text: '.',color: colors.grey,),
              ),
              HorizontalSpace(1),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: smallText(text: 'Food pairing',),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20,bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image
                        Container(
                          height:Dimensions.listViewImg,
                          width:Dimensions.listViewImg,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: colors.white,
                              image: DecorationImage(image: NetworkImage(
                                  AppConstants.BASE_URL + AppConstants.UPLOAD + recommendedProducts.recommendedProductList[index].img!),fit: BoxFit.cover)
                          ),
                        ),
                        //  text
                        Expanded(
                          child: Container(
                            height:Dimensions.listViewText,
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                )
                            ),
                            child: Padding(padding: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  boldText(text: recommendedProducts.recommendedProductList[index].name!),
                                  VerticalSpace(1),
                                  smallText(text: recommendedProducts.recommendedProductList[index].description!),
                                  VerticalSpace(1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      iconText(icon: Icons.circle_sharp, text: 'Normal', iconColor: colors.yellow),
                                      iconText(icon: Icons.location_on, text: '1.7km', iconColor: colors.primary),
                                      iconText(icon: Icons.access_time_rounded, text: ' 32min', iconColor: colors.red),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: colors.primary,
          );
        })
      ],
    );
  }
  Widget buildPageItem(int index, popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_pageValue.floor()){
      var currentScale = 1-(_pageValue-index)*(1-_scaleFactor);
      var currentTrans = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else if(index == _pageValue.floor()+1){
      var currentScale = _scaleFactor +(_pageValue-index+1)*(1-_scaleFactor);
      var currentTrans = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
    }else if(index == _pageValue.floor()-1){
      var currentScale = 1-(_pageValue-index)*(1-_scaleFactor);
      var currentTrans = height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
    }else{
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, height*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
          Get.toNamed(RouteHelper.getPopularFood(index));

        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin:EdgeInsets.only(left: Dimensions.height10, right:Dimensions.height10) ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven? colors.yellow : colors.blueWhite,
                  image: DecorationImage(
                      fit: BoxFit.cover,

                      image: NetworkImage(
                        AppConstants.BASE_URL +AppConstants.UPLOAD + popularProduct.img!)
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin:EdgeInsets.only(left:Dimensions.height30, right:Dimensions.height30, bottom: Dimensions.height30) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadowGrey,
                      offset: Offset(0, 5),
                      blurRadius: 5
                    ),
                  BoxShadow(
                      color: colors.white,
                      offset: Offset(-5, 0),
                    ),
                  BoxShadow(
                      color: colors.white,
                      offset: Offset(5, 0),

                    )
                  ]

                ),
                child: Padding(
                  padding:  EdgeInsets.only(top: Dimensions.height10 ,left: Dimensions.height10,right: Dimensions.height10),
                  child: appColumn(text: popularProduct.name!,)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
