import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../app/urls.dart';
import '../../../../core/services/network/network_client.dart';
import '../../../common/controllers/auth_controller.dart';
import '../../../common/models/user_model.dart';
import '../../data/models/login_request_model.dart';

class LoginController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> login(LoginRequestModel model) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkClient>()
        .postRequest(Urls.loginUrl, body: model.toJson());
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserData(
        response.responseData!['data']['token'],
        UserModel.fromJson(response.responseData!['data']['user']),
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
