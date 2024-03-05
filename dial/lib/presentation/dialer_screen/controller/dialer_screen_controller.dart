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

  Future<void> skipApi() async {
    await ApiService().callPutApi(
        body: {"communication": 0},
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

  Future<void> oneContactApi() async {
    String idList = PrefUtils.getString(PrefsKey.selectListId);

    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: '${NetworkUrl.oneContactUrl}$idList')
        .then((value) async {
      if (value.statusCode == 200) {
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }
}
