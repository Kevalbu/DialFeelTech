import 'package:dial/core/utils/app_date_format.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';
import '../../dashboard_screen/models/single_contact_model.dart';

class DialerScreenController extends GetxController {
  RxBool noContact = false.obs;

  Rx<SingleContactModel> singleContactModel = SingleContactModel().obs;

  late Timer timer;
  RxInt start = 5.obs;
  RxBool startTime = false.obs;
  void stopTimer() {
    timer.cancel();
    startTime.value = false;
    start.value = 5;
  }

  String changeDateFormat(String dates) {
    DateTime date = DateTime.parse(dates);

    // Formatting the date
    String formattedDate =
        DateFormat(AppDateFormats.APP_PLAN_DATE_FORMAT_MMM).format(date);

    return formattedDate;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    startTime.value = true;
    timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (start.value == 0) {
          await FlutterPhoneDirectCaller.callNumber(
              singleContactModel.value.mobile2 ?? '');
          // await FlutterPhoneDirectCaller.callNumber('9106148880');
          Get.toNamed(AppRoutes.callDialDetailScreenRout, arguments: {
            "name": singleContactModel.value.name,
            "number": singleContactModel.value.mobile2,
            "id": singleContactModel.value.id
          });
          startTime.value = false;

          timer.cancel();
          start.value = 5;
        } else {
          start.value--;
        }
      },
    );
  }

  Future<void> skipApi(String contactId) async {
    await ApiService().callPutApi(
        body: {"communication": 4},
        headerWithToken: true,
        showLoader: true,
        url: '${NetworkUrl.skipUrl}$contactId').then((value) async {
      if (value.statusCode == 200) {
        oneContactApi();
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
        noContact.value = true;

        singleContactModel.value = SingleContactModel.fromJson(value.body);
      } else {
        noContact.value = false;
      }
    });
  }
}
