import 'package:get/get.dart';

import '../controller/add_new_contact_screen_controller.dart';

class AddNewContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewContactScreenController());
  }
}
