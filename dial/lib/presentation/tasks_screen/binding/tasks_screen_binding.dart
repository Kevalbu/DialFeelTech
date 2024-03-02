import 'package:get/get.dart';

import '../controller/tasks_screen_controller.dart';

class TaskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskScreenController());
  }
}
