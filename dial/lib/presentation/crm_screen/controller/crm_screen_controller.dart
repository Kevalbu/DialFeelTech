import '../../../core/app_export.dart';
import '../../../core/utils/network_url.dart';
import '../Model/GetContactModel.dart';

class CRMScreenController extends GetxController {
  RxInt selectedContacts = 0.obs;
  RxList<GetContactModel> getContactModel = <GetContactModel>[].obs;
  void changeContact(int index) {
    selectedContacts.value = index;
  }

  @override
  void onInit() {
    getContactApi();
    super.onInit();
  }
Future<void> getContactApi() async {
  await ApiService()
      .callGetApi(
      headerWithToken: true,
      showLoader: false,
      url: NetworkUrl.getContactNameUrl)
      .then((value) {
    if (value.statusCode == 200) {
      getContactModel.value = (value.body as List)
          .map((data) => GetContactModel.fromJson(data))
          .toList();


    }
  });
}}

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
