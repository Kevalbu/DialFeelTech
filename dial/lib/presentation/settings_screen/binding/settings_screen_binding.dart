import 'package:get/get.dart';

import '../controller/settings_screen_controller.dart';

class SettingsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsScreenController());
  }
}
