import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';

import 'controller/addtasks_screen_controller.dart';

class AddTaskScreen extends GetWidget<AddTaskScreenController> {
  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        surfaceTintColor: ColorConstant.primaryWhite,
        shadowColor: ColorConstant.greyColor72,
        backgroundColor: ColorConstant.primaryWhite,
        title: Text(
          AppString.tasks,
          style: DL.styleDL(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Choose Contact',
                  hintText: 'serch name or phone',
                ),
              ),
              SizedBox(height: getHeight(20)),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Task Name', hintText: 'Task Name'),
              ),
              SizedBox(height: getHeight(20)),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description', hintText: 'Description'),
              ),
              SizedBox(height: getHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppString.setReminder,
                    style:
                        DL.styleDL(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Obx(
                    () => Switch(
                      activeColor: ColorConstant.primaryBlue,
                      value: controller.isReminderEnabled.value,
                      onChanged: controller.toggleReminder,
                    ),
                  ),
                ],
              ),
              Divider(),
              Obx(
                () => Visibility(
                  visible: controller.isReminderEnabled.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.remindon,
                        style: DL.styleDL(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                      TextFormField(
                        readOnly: true,
                        textAlign: TextAlign.center, // Center align the text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorConstant
                                        .primaryBlue, // OK button color
                                    onPrimary: ColorConstant
                                        .primaryWhite, // Text color of OK button
                                    surface: ColorConstant
                                        .primaryWhite, // Cancel button color
                                    onSurface: ColorConstant
                                        .primaryBlack, // Text color of Cancel button
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: ColorConstant
                                          .primaryBlue, // OK button color
                                      onPrimary: ColorConstant
                                          .primaryWhite, // Text color of OK button
                                      surface: ColorConstant
                                          .primaryWhite, // Cancel button color
                                      onSurface: ColorConstant
                                          .primaryBlack, // Text color of Cancel button
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              pickedDate = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );

                              String formattedDateTime =
                                  DateFormat('yyyy-MM-dd hh:mm a')
                                      .format(pickedDate);
                              controller.dateInput.text = formattedDateTime;
                            }
                          }
                        },
                        controller: controller.dateInput,

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                          ), // Adjust vertical padding
                          prefixIcon: Icon(Icons.date_range),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.dateInput.clear();
                            },
                            child: Icon(Icons.close),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppString.addCalendar,
                    style:
                        DL.styleDL(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Obx(
                    () => Switch(
                      activeColor: ColorConstant.primaryBlue,
                      value: controller.isRCalenderEnabled.value,
                      onChanged: controller.Calender,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              AppElevatedButton(buttonName: 'save', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
