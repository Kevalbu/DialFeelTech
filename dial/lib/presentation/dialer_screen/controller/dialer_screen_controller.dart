import '../../../core/app_export.dart';

class DialerScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  late Timer timer;
  RxInt start = 5.obs;
  RxBool startTime = false.obs;
  void stopTimer() {
    timer.cancel();
    startTime.value = false;
    start.value = 5;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    startTime.value = true;
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          Get.toNamed(AppRoutes.callDialDetailScreenRout);

          startTime.value = false;

          timer.cancel();
          start.value = 5;
        } else {
          start.value--;
        }
      },
    );
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
