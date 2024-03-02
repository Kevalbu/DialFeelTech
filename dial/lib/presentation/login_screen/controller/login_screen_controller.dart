import 'dart:async';

import 'package:dial/ApiServices/api_service.dart';
import 'package:dial/core/app_export.dart';
import 'package:dial/core/utils/app_prefs_key.dart';
import 'package:dial/core/utils/common_constant.dart';
import 'package:dial/presentation/login_screen/models/login_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/network_url.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../core/utils/progress_dialog_utils.dart';
import '../../../core/utils/string_constant.dart';

class LoginScreenController extends GetxController {
  RxBool isShow = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<LoginModel> loginModel = LoginModel().obs;

  void changeShowHide() {
    isShow.value = !isShow.value;
  }

  void next() {
    if (emailController.text.isEmpty) {
      ProgressDialogUtils.showSnackBar(
          bodyText: AppString.enterEmail, headerText: AppString.error);
    } else if (!CommonConstant.instance.validateEmail(emailController.text)) {
      ProgressDialogUtils.showSnackBar(
          bodyText: AppString.validEmail, headerText: AppString.error);
    } else if (emailController.text.isEmpty) {
      ProgressDialogUtils.showSnackBar(
          bodyText: AppString.validEmail, headerText: AppString.error);
    } else {
      callUpdateShowMeOnPetMeetApi();
    }
  }

  Future<void> callUpdateShowMeOnPetMeetApi() async {
    await ApiService().callPostApi(
        body: {
          "email": emailController.text,
          "password": passwordController.text,
          "rememberMe": true
        },
        headerWithToken: false,
        showLoader: false,
        url: NetworkUrl.loginUrl).then((value) async {
      loginModel.value = LoginModel.fromJson(value.body);
      if (value.statusCode == 200) {
        PrefUtils.setString(
            PrefsKey.authToken, loginModel.value.accessToken ?? '');
        await PrefUtils.setInt(PrefsKey.isLogin, 1);
        Get.offAllNamed(AppRoutes.permissionScreenRout);
      } else {
        await PrefUtils.setInt(PrefsKey.isLogin, 0);
        ProgressDialogUtils.showSnackBar(
            bodyText: loginModel.value.message, headerText: AppString.error);
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
