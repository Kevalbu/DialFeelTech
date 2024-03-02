import 'package:get/get.dart';

import '../controller/dashbboard_screen_controller.dart';

class DashBoardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardScreenController());
  }
}
