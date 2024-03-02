import '../../../core/app_export.dart';

class AddNewContactScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> addContactApi() async {
  //   await ApiService().callPostApi(
  //       body: {
  //         "address": "<string>",
  //         "company": "<string>",
  //         "dealValue": "<double>",
  //         "email": "<email>",
  //         "mobile1": "<string>",
  //         "name": "<string>",
  //         "mobile2": "<string>",
  //         "leadScore": "<integer>",
  //         "listId": "<uuid>",
  //         "districtId": "<uuid>",
  //         "areaId": "<uuid>",
  //         "remarks": "<string>",
  //         "note": "<string>",
  //         "qualification": "<string>",
  //         "extra": "<string>"
  //       },
  //       headerWithToken: false,
  //       showLoader: false,
  //       url: NetworkUrl.loginUrl).then((value) async {
  //     loginModel.value = LoginModel.fromJson(value.body);
  //     if (value.statusCode == 200) {
  //       PrefUtils.setString(
  //           PrefsKey.authToken, loginModel.value.accessToken ?? '');
  //       await PrefUtils.setInt(PrefsKey.isLogin, 1);
  //       Get.offAllNamed(AppRoutes.permissionScreenRout);
  //     } else {
  //       await PrefUtils.setInt(PrefsKey.isLogin, 0);
  //       ProgressDialogUtils.showSnackBar(
  //           bodyText: loginModel.value.message, headerText: AppString.error);
  //     }
  //   });
  // }
}
