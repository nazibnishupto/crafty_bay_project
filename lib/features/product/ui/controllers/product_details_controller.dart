import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../app/urls.dart';
import '../../../../core/services/network/network_client.dart';
import '../../data/models/product_details_model.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  late ProductDetailsModel _productDetails;

  ProductDetailsModel get productDetails => _productDetails;

  Future<bool> getProductDetails(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      Urls.productDetailsUrl(id),
    );
    if (response.isSuccess) {
      _productDetails = ProductDetailsModel.fromJson(
        response.responseData!['data'],
      );
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
