import 'package:permission_handler/permission_handler.dart';

import '../../../core/app_export.dart';

class PermissionScreenController extends GetxController {
  RxBool phone = false.obs;
  RxBool contact = false.obs;
  RxBool microPhone = false.obs;
  RxBool notification = false.obs;
  RxBool location = false.obs;
  RxBool callLog = false.obs;

  @override
  void onInit() {
    setValue();
    super.onInit();
  }

  setValue() async {
    var phoneStatus = await Permission.phone.status;
    var contactStatus = await Permission.contacts.status;
    // var microPhoneStatus = await Permission.microphone.status;
    var locationStatus = await Permission.location.status;
    var notificationStatus = await Permission.notification.status;
    var callLogStatus = await Permission.phone.status;
    if (phoneStatus.isGranted) {
      phone.value = true;
    }
    if (contactStatus.isGranted) {
      contact.value = true;
    }
    // if (microPhoneStatus.isGranted) {
    //   microPhone.value = true;
    // }
    if (locationStatus.isGranted) {
      location.value = true;
    }
    if (notificationStatus.isGranted) {
      notification.value = true;
    }
    if (callLogStatus.isGranted) {
      callLog.value = true;
    }
  }

  void requestPhonePermissions() async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      phone.value = true;
    } else if (status.isDenied) {
      phone.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestContactPermissions() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      contact.value = true;
    } else if (status.isDenied) {
      contact.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestMicroPhonePermissions() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      microPhone.value = true;
    } else if (status.isDenied) {
      microPhone.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestNotificationPermissions() async {
    var status = await Permission.notification.request();
    if (status.isGranted) {
      notification.value = true;
    } else if (status.isDenied) {
      notification.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestLocationPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      location.value = true;
    } else if (status.isDenied) {
      location.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestCallLogPermissions() async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      callLog.value = true;
    } else if (status.isDenied) {
      callLog.value = false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
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
