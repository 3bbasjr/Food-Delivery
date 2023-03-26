import 'package:get/get.dart';

import '../../constants/appConstants.dart';
import '../api/api.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList()async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}