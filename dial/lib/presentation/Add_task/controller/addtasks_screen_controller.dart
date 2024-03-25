import '../../../core/app_export.dart';

class AddTaskScreenController extends GetxController {
  TextEditingController dateInput = TextEditingController();
  RxString sliderValue = '0'.obs;
  var isReminderEnabled = false.obs;
  var isRCalenderEnabled = false.obs;
  var selectedDate = DateTime.now().obs;

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
}

