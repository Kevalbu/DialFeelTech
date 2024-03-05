import 'package:dial/presentation/crm_screen/crm_screen.dart';
import 'package:dial/presentation/dashboard_screen/models/list_get_model.dart';
import 'package:dial/presentation/dialer_screen/dialer_screen.dart';
import 'package:dial/presentation/settings_screen/settings_screen.dart';
import 'package:dial/presentation/tasks_screen/tasks_screen.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/network_url.dart';

class DashBoardScreenController extends GetxController {
  var tabIndex = 0.obs;
  DateTime? currentBackPressTime;
  final key = GlobalKey<ExpandableFabState>();
  TextEditingController addListNameController = TextEditingController();

  RxList<ListGetModel> getListModel = <ListGetModel>[].obs;

  final pages = [
    DialerScreen(),
    CRMScreen(),
    TaskScreen(),
    const SettingsScreen()
  ];

  @override
  void onInit() {
    getListApi();
    super.onInit();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  RxString currentSelectedValue = ''.obs;
  RxString selectedListItem = ''.obs;

  final List<TimeValue> lists = [
    TimeValue(30, "Default"),
    TimeValue(60, "List2"),
    TimeValue(120, "TestList"),
    TimeValue(240, "SameList"),
    TimeValue(480, "TeamFeelTechList"),
    TimeValue(720, "Solution"),
  ];

  Future<bool> onWillPop(bool value) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ProgressDialogUtils.showSnackBar(
          bodyText: AppString.exit, headerText: AppString.error);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void addList() {
    if (addListNameController.text.isNotEmpty) {
    } else {
      ProgressDialogUtils.showTitleSnackBar(
          headerText: AppString.enterNameValidate);
    }
  }

  // Future<void> callAddListNameApi() async {
  //   await ApiService().callPostApi(
  //       body: {"name": addListNameController.text},
  //       headerWithToken: true,
  //       showLoader: false,
  //       url: NetworkUrl.addListNameUrl).then((value) {
  //     if (value.statusCode == 200) {
  //       PrefUtils.setString(
  //           PrefsKey.authToken, loginModel.value.accessToken ?? '');
  //       PrefUtils.setString(PrefsKey.isLogin, '1');
  //       Get.offAllNamed(AppRoutes.permissionScreenRout);
  //     } else {
  //       PrefUtils.setString(PrefsKey.isLogin, '0');
  //       ProgressDialogUtils.showSnackBar(
  //           bodyText: loginModel.value.message, headerText: AppString.error);
  //     }
  //   });
  // }

  Future<void> getListApi() async {
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.getListNameUrl)
        .then((value) {
      if (value.statusCode == 200) {
        getListModel.value = (value.body as List)
            .map((data) => ListGetModel.fromJson(data))
            .toList();
        selectedListItem.value = getListModel.value[0].label ?? '';
        currentSelectedValue.value = getListModel.value[0].value ?? '';
      }
    });
  }

  Future<void> deleteListApi() async {
    await ApiService()
        .callDeleteApi(
            headerWithToken: true,
            showLoader: true,
            url: '${NetworkUrl.deleteListUrl}$currentSelectedValue')
        .then((value) async {
      if (value.statusCode == 200) {
        await getListApi();
        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }
}

class TimeValue {
  final int key;
  final String value;
  TimeValue(this.key, this.value);
}
