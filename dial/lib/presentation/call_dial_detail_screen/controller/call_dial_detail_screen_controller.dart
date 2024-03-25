import 'dart:ffi';

import 'package:intl/intl.dart';

import '../../../core/app_export.dart';
import 'package:call_log/call_log.dart';

import '../../../core/utils/app_date_format.dart';
import '../../dialer_screen/controller/dialer_screen_controller.dart';
import '../models/disposition_model.dart';

class CallDialDetailScreenController extends GetxController {
  TextEditingController dateInput = TextEditingController();
  RxString sliderValue = '0'.obs;
  Rx<DateTime> pickDates = DateTime.now().obs;
  var arguments = Get.arguments;
  RxString name = ''.obs;
  RxString number = ''.obs;
  RxString id = ''.obs;
  Rx<CallLogEntry> callLogList = CallLogEntry().obs;
  RxList<DispositionModel> dispositionList = <DispositionModel>[].obs;

  @override
  void onInit() {
    name.value = arguments["name"];
    number.value = arguments["number"];
    id.value = arguments["id"];
    getDispositionApi();
    super.onInit();
  }

  Future<void> save() async {
    await callLogs();
    afterCallApi();
    print('dateInput ${dateInput.text}');
  }

  Future<void> callLogs() async {
    // Iterable<CallLogEntry> entries = await CallLog.get();
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 2)).millisecondsSinceEpoch;
    int to = now.subtract(Duration(days: 0)).millisecondsSinceEpoch;
    print('=========> ${from}   ${to}');
    Iterable<CallLogEntry> entries =
        await CallLog.query(dateFrom: from, dateTo: to);
    for (var item in entries) {
      print(item.name);

      callLogList.value = entries.first;
    }
  }

  String callTime(int date) {
    DateTime dates = DateTime.fromMillisecondsSinceEpoch(date);

    // Format the DateTime object into a desired date format
    String formattedDate =
        DateFormat(AppDateFormats.DATE_FORMAT_YYYY_MM_DD).format(dates);

    return formattedDate;
  }

  Future<void> getDispositionApi() async {
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.dispositionUrl)
        .then((value) {
      if (value.statusCode == 200) {
        dispositionList.value = (value.body as List)
            .map((data) => DispositionModel.fromJson(data))
            .toList();
      } else {}
    });
  }

  Future<void> afterCallApi() async {
    await ApiService().callPutApi(
        body: {
          "calledOn": callTime(callLogList.value.timestamp ?? 000000),
          "direction": 1,
          "duration": '${callLogList.value.duration.toString()}',
          "timeSpentOnCall": '${callLogList.value.duration.toString()}',
          "defaultDialer": 0,
          // "recordingFile": "",
          "dnc": false,
          "leadScore": int.parse(sliderValue.value.split(".")[0]),
          "callBack": true,
          "remindOn": DateFormat(AppDateFormats.DATE_FORMAT_YYYY_MM_DD)
              .format(pickDates.value),
          "dispositionId": "7b79db88-bacc-4c07-de07-08dc2b961fc3"
        },
        headerWithToken: true,
        showLoader: true,
        url: '${NetworkUrl.recordCallUrl}${id.value}').then((value) async {
      if (value.statusCode == 200) {
        // await getListApi();
        Get.put(DialerScreenController()).oneContactApi();

        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      } else {
        ProgressDialogUtils.hideProgressDialog();
      }
    });
  }
}
