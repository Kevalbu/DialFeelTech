import 'package:dial/presentation/tasks_screen/models/task_get_model.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/app_date_format.dart';

class TaskScreenController extends GetxController {
  TextEditingController dateInput = TextEditingController();

  RxInt selectedContacts = 0.obs;
  RxInt selectDate = 0.obs;
  Rx<DateTime> fistDate = DateTime.now().obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxList<DateTime> initialDateTimeList = <DateTime>[].obs;
  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxList<Datum> taskList = <Datum>[].obs;
  Rx<GetTaskModel> taskModel = GetTaskModel().obs;
  RxBool taskLoading = false.obs;
  void changeContact(int index) {
    selectedContacts.value = index;
  }

  void changeDate(int index) {
    selectDate.value = index;
  }

  var isClicked = false.obs;

  void changeColor() {
    isClicked.value = !isClicked.value;
  }

  @override
  void onInit() {
    getCurrentDate();
    getTaskApi();
    super.onInit();
  }

  void getCurrentDate() {
    final now = DateTime.now();
    currentDate.value = DateTime.now();
    var date = DateTime(now.year, now.month, 1).toString();
    fistDate.value = DateTime.parse(date);
    initialDateTimeList.value = [fistDate.value, currentDate.value];
    fromDate.value = DateFormat(AppDateFormats.DATE_FORMAT_YYYY_MM_DD)
        .format(fistDate.value);
    toDate.value = DateFormat(AppDateFormats.DATE_FORMAT_YYYY_MM_DD)
        .format(currentDate.value);
    dateInput.text = '${fromDate.value} to ${toDate}';
  }

  String changeDateFormat(String dates) {
    DateTime date = DateTime.parse(dates);
    String formattedDate =
        DateFormat(AppDateFormats.APP_PLAN_DATE_FORMAT_MMM_DD).format(date);

    return formattedDate;
  }

  String dateFormat(String value) {
    DateTime date = DateTime.parse(value);
    return DateFormat(AppDateFormats.DATE_FORMAT_HH_MM_A_N).format(date);
  }

  Future<void> getTaskApi() async {
    taskLoading.value = true;
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url:
                '${NetworkUrl.getTaskUrl}?fromDate=${fromDate.value}&toDate=${toDate.value}')
        // &page=1&pageSize=10
        .then((value) {
      if (value.statusCode == 200) {
        taskLoading.value = false;
        taskModel.value = GetTaskModel.fromJson(value.body);
        if (taskModel.value.data != null) {
          taskList.value = taskModel.value.data!;
        }
      } else {
        taskLoading.value = false;
      }
    });
  }
}
// Future<void> callDeleteAccountApi() async {
//   isLoadingDelete.value = true;
//   ApiService()
//       .callGetApi(
//       body: await ApiService().getBlankApiBody(),
//       headerWithToken: true,
//       showLoader: true,
//       url: NetworkUrl.getDeleteAccountUrl)
//       .then((value) {
//     if (value.body != null && value.body["status"] == true) {
//       isLoadingDelete.value = false;
//       PrefUtils().clearPreferencesData();
//       Get.offAllNamed(AppRoutes.welcomeScreenRoute);
//     } else {
//       isLoadingDelete.value = false;
//       ProgressDialogUtils.showSnackBar(
//           bodyText: value.body["message"], headerText: AppString.error);
//     }
//   });
// }

// Future<void> callUpdateShowMeOnPetMeetApi({required int isOn}) async {
//   await ApiService()
//       .callPostApi(
//       body: FormData({'show_me_on_petmeet': isOn}),
//       headerWithToken: true,
//       showLoader: true,
//       url: NetworkUrl.updateShowMeOnPetMeet)
//       .then((value) {
//     if (value != null && value["status"] == true) {
//       PrefUtils.setInt(AppString.SHOWMEONPETMEET, isOn);
//
//       ProgressDialogUtils.showSnackBar(
//           bodyText: value["message"], headerText: "SUCCESS");
//     } else {
//       ProgressDialogUtils.showSnackBar(
//           bodyText: value["message"], headerText: AppString.error);
//     }
//   });
// }
