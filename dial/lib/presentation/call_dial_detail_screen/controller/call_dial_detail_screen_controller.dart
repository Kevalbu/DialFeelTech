import '../../../core/app_export.dart';

class CallDialDetailScreenController extends GetxController {
  TextEditingController dateInput = TextEditingController();
  RxString sliderValue = '0'.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> afterCallApi() async {
    await ApiService().callPutApi(
        body: {
          "calledOn": "<dateTime>",
          "direction": 1,
          "duration": "<long>",
          "timeSpentOnCall": "<long>",
          "defaultDialer": 0,
          "recordingFile": "<string>",
          "dnc": "<boolean>",
          "callBack": "<boolean>",
          "remindOn": "<dateTime>",
          "dispositionId": "<uuid>"
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
}
