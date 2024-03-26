import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/utils/app_date_format.dart';
import 'controller/tasks_screen_controller.dart';

class TaskScreen extends GetWidget<TaskScreenController> {
  TaskScreen({super.key});
  TaskScreenController controllerT = Get.put(TaskScreenController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return controllerT.getTaskApi();
        },
        child: SizedBox(
            height: double.maxFinite,
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppString.tasks,
                            style: DL.styleDL(
                                fontSize: (30),
                                fontWeight: FontWeight.bold,
                                fontColor: ColorConstant.primaryBlack),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => InkWell(
                              onTap: () {
                                controllerT.changeContact(0);
                              },
                              child: Container(
                                height: getHeight(35),
                                width: getWidth(100),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    border: Border.all(
                                        color: ColorConstant.primaryBlue,
                                        width: 2),
                                    color:
                                        controllerT.selectedContacts.value == 0
                                            ? ColorConstant.primaryBlue
                                            : Colors.white),
                                child: Center(
                                  child: Text(
                                    AppString.Todo,
                                    style: DL.styleDL(
                                      fontSize: (10),
                                      fontColor:
                                          controllerT.selectedContacts.value ==
                                                  0
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: () {
                                controllerT.changeContact(1);
                              },
                              child: Container(
                                height: getHeight(35),
                                width: getWidth(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  border: Border.all(
                                      color: ColorConstant.primaryBlue,
                                      width: 2),
                                  color: controllerT.selectedContacts.value == 1
                                      ? ColorConstant.primaryBlue
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    AppString.Done,
                                    style: DL.styleDL(
                                      fontSize: (10),
                                      fontColor:
                                          controllerT.selectedContacts.value ==
                                                  1
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(40),
                      ),

                      /// horizontal ListView DateTime
                      /* SizedBox(
            height: getHeight(100),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 30, // Number of dates you want to display
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = true;
                DateTime now = DateTime.now();
                String day = DateFormat('EEEE')
                    .format(DateTime.now().add(Duration(days: index)));
                String date = DateFormat('d')
                    .format(DateTime.now().add(Duration(days: index)));
                String month = DateFormat('MMMM')
                    .format(DateTime.now().add(Duration(days: index)));
                return Bounce(
                  onTap: () {
                    controllerT.changeDate(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: controllerT.selectDate.value == index
                              ? ColorConstant.primaryBlue
                              : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              day.substring(0, 3),
                              style: DL.styleDL(
                                fontSize: (12),
                                fontWeight: FontWeight.w500,
                                fontColor: controllerT.selectDate.value == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Center(
                              child: Text(
                                date,
                                style: DL.styleDL(
                                  fontSize: (12),
                                  fontWeight: FontWeight.w900,
                                  fontColor:
                                      controllerT.selectDate.value == index
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              month.substring(0, 3),
                              style: DL.styleDL(
                                fontSize: (12),
                                fontWeight: FontWeight.w500,
                                fontColor: controllerT.selectDate.value == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),*/

                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          controllerT.getCurrentDate();
                          var results = await showCalendarDatePicker2Dialog(
                            context: context,
                            config: CalendarDatePicker2WithActionButtonsConfig(
                                calendarType: CalendarDatePicker2Type.range),
                            dialogSize: const Size(325, 400),
                            value: controllerT.initialDateTimeList.value,
                            borderRadius: BorderRadius.circular(15),
                          );
                          if (results != null && results.isNotEmpty) {
                            controllerT.fromDate.value = DateFormat(
                                    AppDateFormats.DATE_FORMAT_YYYY_MM_DD)
                                .format(results.first!);
                            controllerT.toDate.value = DateFormat(
                                    AppDateFormats.DATE_FORMAT_YYYY_MM_DD)
                                .format(results.last!);
                          }
                          controllerT.dateInput.text =
                              '${controllerT.fromDate.value} to ${controllerT.toDate}';
                          controllerT.getTaskApi();
                          print(results);
                        },
                        controller: controller.dateInput,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                          ), // Adjust vertical padding
                          prefixIcon: Icon(Icons.date_range),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(40),
                      ),
                      Obx(
                        () => controllerT.taskLoading.value
                            ? Padding(
                                padding: EdgeInsets.only(top: getHeight(150)),
                                child: ProgressDialogUtils.loading(),
                              )
                            : controllerT.taskList.isEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: getHeight(150)),
                                    child: Text(
                                      AppString.contactEmpty,
                                      style: DL.styleDL(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: controllerT.taskList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(15),
                                              vertical: getHeight(5)),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConstant.primaryWhite,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controllerT.taskList[index]
                                                            .title ??
                                                        '',
                                                    style: DL.styleDL(
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: getWidth(10),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: ColorConstant
                                                          .primaryBlue,
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                        // vertical: getHeight(5),
                                                        horizontal: getWidth(10)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.person_outline,
                                                          size: getHeight(15),
                                                          color: ColorConstant
                                                              .primaryWhite,
                                                        ),
                                                        SizedBox(
                                                          width: getWidth(5),
                                                        ),
                                                        Text(
                                                          controllerT
                                                                  .taskList[
                                                                      index]
                                                                  .contact ??
                                                              '',
                                                          style: DL.styleDL(
                                                              fontSize: 12,
                                                              fontColor:
                                                                  ColorConstant
                                                                      .primaryWhite),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    controllerT.taskList[index]
                                                            .accountName ??
                                                        '',
                                                    style: DL.styleDL(
                                                        fontSize: 12,
                                                        fontColor: ColorConstant
                                                            .greyText),
                                                  ),
                                                  Text(
                                                    ' | ${controllerT.changeDateFormat(controllerT.taskList[index].createdDate.toString())}',
                                                    style: DL.styleDL(
                                                        fontSize: 12,
                                                        fontColor: ColorConstant
                                                            .greyText),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                controllerT.taskList[index]
                                                        .description ??
                                                    '',
                                                style: DL.styleDL(
                                                    fontSize: 12,
                                                    fontColor:
                                                        ColorConstant.greyText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ))));
  }
}
