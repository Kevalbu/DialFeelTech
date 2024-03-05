import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dial/core/network/network_info.dart';
import 'package:dial/core/utils/pref_utils.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    // Get.put(ApiClient());
    Connectivity connectivity = Connectivity();

    Get.put(NetworkInfo(connectivity));
  }
}
