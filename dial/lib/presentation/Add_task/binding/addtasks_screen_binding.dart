import 'package:get/get.dart';

import '../controller/addtasks_screen_controller.dart';


class AddTaskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTaskScreenController());
  }
}
