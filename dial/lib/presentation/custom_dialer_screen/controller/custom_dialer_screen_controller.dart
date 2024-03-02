import 'dart:math' as math;

import 'package:call_log/call_log.dart';
import 'package:dial/core/utils/app_date_format.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';

class CustomDialerScreenController extends GetxController {
  TextEditingController pinController = TextEditingController();
  RxList<CallLogEntry> callLogList = <CallLogEntry>[].obs;
  Rx<Color> color = Colors.white.obs;
  RxBool callLoading = false.obs;

  final List<Color> colorCollection = <Color>[
    Colors.green,
    ColorConstant.primaryBlue,
    Colors.grey,
    Colors.red,
    Colors.black87,
    Colors.purple,
    Colors.teal,
    Colors.lightGreen,
    Colors.orange,
  ];

  @override
  void onInit() {
    callLogs();
    super.onInit();
  }

  callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);

    // print('=======>> $res');
    print('=======>> ${DateTime.now().day}');
  }

  void callLogs() async {
    // Iterable<CallLogEntry> entries = await CallLog.get();
    callLoading.value = true;
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 2)).millisecondsSinceEpoch;
    int to = now.subtract(Duration(days: 0)).millisecondsSinceEpoch;
    print('=========> ${from}   ${to}');
    Iterable<CallLogEntry> entries =
        await CallLog.query(dateFrom: from, dateTo: to);
    for (var item in entries) {
      print(item.name);

      callLogList.add(item);
      callLogList.refresh();
      callLoading.value = false;
    }
  }

  IconData getIconData(CallType iconName) {
    switch (iconName) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
      case CallType.rejected:
        return Icons.call_missed_outgoing_outlined;
      default:
        return Icons.error; // Default icon in case of unknown iconName
    }
  }

  Color getIconDataColor(CallType iconName) {
    switch (iconName) {
      case CallType.incoming:
        return ColorConstant.green;
      case CallType.outgoing:
        return ColorConstant.primaryBlack;
      case CallType.missed:
        return ColorConstant.red;
      case CallType.rejected:
        return ColorConstant.red;
      default:
        return ColorConstant.primaryBlack;
    }
  }

  final rnd = math.Random();

  void getRandomColor() {
    color.value = colorCollection[rnd.nextInt(9)];
    // color.value = Color(rnd.nextInt(0xffffffff));
  }

  String formatTimestamp(int timestamp) {
    // Create a DateTime object from the timestamp (assuming it's in milliseconds)
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the DateTime object into a desired date format
    String formattedDate =
        DateFormat(AppDateFormats.DATE_FORMAT_DD_MMM_COMMA_A).format(date);

    return formattedDate;
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
