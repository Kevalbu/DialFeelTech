import 'package:dial/presentation/crm_screen/controller/crm_screen_controller.dart';

import '../../../core/app_export.dart';

class AddNewContactScreenController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController leadScoreController = TextEditingController();
  TextEditingController quaController = TextEditingController();
  TextEditingController dealController = TextEditingController();
  TextEditingController extraController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void addContact() {
    if (phoneController.text.isEmpty || phone2Controller.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(headerText: AppString.enterPhone);
    } else if (nameController.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(headerText: AppString.enterName);
    } else if (emailController.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(headerText: AppString.enterEmail);
    } else if (companyController.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(headerText: AppString.enterCompany);
    } else if (dealController.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(
          headerText: AppString.enterDealValue);
    } else if (addressController.text.isEmpty) {
      ProgressDialogUtils.showTitleSnackBar(headerText: AppString.enterAddress);
    } else {
      addContactApi();
    }
  }

  Future<void> addContactApi() async {
    String idList = PrefUtils.getString(PrefsKey.selectListId);

    await ApiService().callPostApi(
        body: {
          "address": addressController.text,
          "company": companyController.text,
          "dealValue": int.parse(dealController.text),
          "email": emailController.text,
          "mobile1": phoneController.text,
          "name": nameController.text,
          "mobile2": phone2Controller.text,
          "leadScore": int.parse(leadScoreController.text),
          "listId": idList,
          "districtId": "8b0a34e7-7567-4103-8df9-549a4b7f0ca8",
          "areaId": "8385f2e1-c979-4a54-832a-cc14995c9de5",
          "remarks": remarkController.text,
          "note": noteController.text,
          "qualification": quaController.text,
          "extra": extraController.text
        },
        headerWithToken: true,
        showLoader: true,
        // isBranch: true,
        url: NetworkUrl.getContactNameUrl).then((value) async {
      if (value.statusCode == 200) {
        Get.put(CRMScreenController()).getContactApi();
        Get.back();
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      } else {
        ProgressDialogUtils.showTitleSnackBar(
            headerText: value.body['message']);
      }
    });
  }
}
