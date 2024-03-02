import 'package:get/get.dart';

import '../controller/call_dial_detail_screen_controller.dart';

class CallDialDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallDialDetailScreenController());
  }
}
