import 'package:get/get.dart';

import '../controller/dialer_screen_controller.dart';

class DialerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DialerScreenController());
  }
}
