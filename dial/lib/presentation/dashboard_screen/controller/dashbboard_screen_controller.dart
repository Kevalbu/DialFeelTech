import 'package:dial/presentation/crm_screen/crm_screen.dart';
import 'package:dial/presentation/dashboard_screen/models/list_get_model.dart';
import 'package:dial/presentation/dashboard_screen/models/single_contact_model.dart';
import 'package:dial/presentation/dialer_screen/controller/dialer_screen_controller.dart';
import 'package:dial/presentation/dialer_screen/dialer_screen.dart';
import 'package:dial/presentation/settings_screen/settings_screen.dart';
import 'package:dial/presentation/tasks_screen/tasks_screen.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../../../core/app_export.dart';
import '../../call_dial_detail_screen/models/disposition_model.dart';
import '../../crm_screen/controller/crm_screen_controller.dart';

class DashBoardScreenController extends GetxController {
  var tabIndex = 0.obs;
  DateTime? currentBackPressTime;
  final key = GlobalKey<ExpandableFabState>();
  TextEditingController addListNameController = TextEditingController();

  RxList<ListGetModel> getListModel = <ListGetModel>[].obs;
  RxList<String> dispositionIdList = <String>[].obs;
  RxList<DispositionModel> dispositionList = <DispositionModel>[].obs;

  RxBool dLoading = false.obs;
  RxBool willPop = false.obs;

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

    if (index == 0) {
      Get.put(DialerScreenController()).oneContactApi();
    }
    if (index == 1) {
      Get.put(CRMScreenController()).getContactApi();
    }
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
      willPop.value = false;
      return Future.value(false);
    }
    willPop.value = true;

    return Future.value(true);
  }

  bool onWillPop1() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ProgressDialogUtils.showSnackBar(
          bodyText: AppString.exit, headerText: AppString.error);
      return false;
    }
    return true;
  }

  Future<void> addList() async {
    if (addListNameController.text.isNotEmpty) {
      Get.back();
      await callAddListNameApi();
      getListApi();
    } else {
      ProgressDialogUtils.showTitleSnackBar(
          headerText: AppString.enterNameValidate);
    }
  }

  Future<void> callAddListNameApi() async {
    await ApiService().callPostApi(
        body: {"name": addListNameController.text},
        headerWithToken: true,
        isBranch: true,
        showLoader: true,
        url: NetworkUrl.addListNameUrl).then((value) {
      if (value.statusCode == 200) {
        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }

  Future<void> getListApi() async {
    Get.put(DialerScreenController()).loadingContact.value = true;

    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.getListNameUrl)
        .then((value) async {
      if (value.statusCode == 200) {
        getListModel.value = (value.body as List)
            .map((data) => ListGetModel.fromJson(data))
            .toList();
        selectedListItem.value = getListModel.value[0].label ?? '';
        currentSelectedValue.value = getListModel.value[0].value ?? '';
        await PrefUtils.setString(
            PrefsKey.selectListId, getListModel.value[0].value ?? '');
        Get.put(DialerScreenController()).loadingContact.value = false;
        Get.put(DialerScreenController()).oneContactApi();
        Get.put(CRMScreenController()).getContactApi();
      } else if (value.statusCode == 401) {
        PrefUtils().clearPreferencesData();
        Get.put(DialerScreenController()).loadingContact.value = false;

        await ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
        Get.offAllNamed(AppRoutes.loginScreenRoute);
      }
    });
  }

  Future<void> deleteListApi() async {
    await ApiService()
        .callDeleteApi(
            headerWithToken: true,
            showLoader: true,
            url: '${NetworkUrl.deleteListUrl}${currentSelectedValue.value}')
        .then((value) async {
      if (value.statusCode == 200) {
        await getListApi();
        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }

  void rechurnSubmit() {
    if (dispositionIdList.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(
          headerText: AppString.selectCallStatus);
    } else {
      rechurnListApi();
    }
  }

  void rechurnReset() {
    dispositionIdList.clear();
    dispositionIdList.refresh();
  }

  Future<void> getDispositionApi() async {
    dLoading.value = true;
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.dispositionUrl)
        .then((value) {
      if (value.statusCode == 200) {
        dLoading.value = false;

        dispositionList.value = (value.body as List)
            .map((data) => DispositionModel.fromJson(data))
            .toList();
      } else {
        dLoading.value = false;
      }
    });
  }

  Future<void> rechurnListApi() async {
    await ApiService().callPutApi(
        body: {
          "listId": currentSelectedValue.value,
          "enums": [
            2,
          ],
          "dispositionId": dispositionIdList
        },
        headerWithToken: true,
        showLoader: true,
        url: NetworkUrl.rechurnListUrl).then((value) async {
      if (value.statusCode == 200) {
        // await getListApi();
        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }

  Future<void> emptyListApi() async {
    await ApiService()
        .callDeleteApi(
            headerWithToken: true,
            showLoader: true,
            url: '${NetworkUrl.emptyListUrl}$currentSelectedValue')
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
