import 'package:dial/presentation/Add_task/model/employee_model.dart';

import '../../../core/app_export.dart';
import '../../crm_screen/Model/GetContactModel.dart';
import '../../dashboard_screen/models/list_get_model.dart';

class AddTaskScreenController extends GetxController {
  TextEditingController dateInput = TextEditingController();
  RxString sliderValue = '0'.obs;
  var isReminderEnabled = false.obs;
  var isRCalenderEnabled = false.obs;
  RxString selectedListId = ''.obs;
  var selectedDate = DateTime.now().obs;
  RxList<ListGetModel> getListModel = <ListGetModel>[].obs;
  RxList<GetContactModel> getContactModel = <GetContactModel>[].obs;
  RxList<EmployeeModel> getEmployeeModel = <EmployeeModel>[].obs;
  RxBool isLoading = false.obs;

  void toggleReminder(bool value) {
    isReminderEnabled.value = value;
    if (!value) {
      selectedDate.value = DateTime.now();
    }
  }

  void Calender(bool value) {
    isRCalenderEnabled.value = value;
    if (!value) {
      selectedDate.value = DateTime.now();
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> getListApi() async {
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.getListNameUrl)
        .then((value) async {
      if (value.statusCode == 200) {
        getListModel.value = (value.body as List)
            .map((data) => ListGetModel.fromJson(data))
            .toList();
      } else {}
    });
  }

  Future<void> getContactApi() async {
    isLoading.value = true;

    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: '${NetworkUrl.getContactNameUrl}?ListId=$selectedListId')
        .then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;

        getContactModel.value = (value.body as List)
            .map((data) => GetContactModel.fromJson(data))
            .toList();
      } else {
        isLoading.value = false;
      }
    });
  }

  Future<void> getEmployeeApi() async {
    await ApiService()
        .callGetApi(
            headerWithToken: true,
            showLoader: false,
            url: NetworkUrl.getEmployeeUrl)
        .then((value) {
      if (value.statusCode == 200) {
        getEmployeeModel.value = (value.body as List)
            .map((data) => EmployeeModel.fromJson(data))
            .toList();
      } else {}
    });
  }
}
