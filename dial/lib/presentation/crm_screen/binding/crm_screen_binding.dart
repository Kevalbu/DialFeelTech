import 'package:get/get.dart';

import '../controller/crm_screen_controller.dart';

class CRMScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CRMScreenController());
  }
}
