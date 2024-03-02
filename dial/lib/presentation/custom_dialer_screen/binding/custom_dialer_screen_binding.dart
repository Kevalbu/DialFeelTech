import 'package:get/get.dart';

import '../controller/custom_dialer_screen_controller.dart';

class CustomDialerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomDialerScreenController());
  }
}
