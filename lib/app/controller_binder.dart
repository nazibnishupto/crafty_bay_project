import 'package:crafty_bay_project/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:get/get.dart';

import '../core/services/network/network_client.dart';
import '../features/auth/ui/controller/login_controller.dart';
import '../features/auth/ui/controller/sign_up_controller.dart';
import '../features/auth/ui/controller/verify_otp_controller.dart';
import '../features/auth/ui/screens/login_screen.dart';
import '../features/common/controllers/auth_controller.dart';
import '../features/common/controllers/category_list_controller.dart';
import '../features/home/ui/controllers/home_slider_controller.dart';

class ControllerBinder extends Bindings {
  final AuthController _authController = AuthController();

  @override
  void dependencies() {
    Get.put(_authController);
    Get.put(MainBottomNavController());
    Get.put(
      NetworkClient(
        onUnAuthorize: _onUnAuthorize,
        commonHeaders: _commonHeaders,
      ),
    );
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(LoginController());
    Get.put(HomeSliderController());
    Get.put(CategoryListController());
  }

  void _onUnAuthorize() {
    Future<void> _onUnAuthorize() async {
      await _authController.clearUserData();
      Get.to(() => LoginScreen());
    }
  }

  Map<String, String> get _commonHeaders {
    return {
      'content-type': 'application/json',
      'token': _authController.accessToken ?? '',
    };
  }
}
