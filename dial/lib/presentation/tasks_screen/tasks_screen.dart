import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';
import 'package:intl/intl.dart';

import 'controller/tasks_screen_controller.dart';

class TaskScreen extends GetWidget<TaskScreenController> {
  TaskScreen({super.key});
  TaskScreenController controllerT = Get.put(TaskScreenController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: getWidth(16),),
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
          SizedBox(height: getHeight(40),),
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
                            color: ColorConstant.primaryBlue, width: 2),
                        color: controllerT.selectedContacts.value == 0
                            ? ColorConstant.primaryBlue
                            : Colors.white),
                    child: Center(
                      child: Text(
                        AppString.Todo,
                        style: DL.styleDL(
                          fontSize: (10),
                          fontColor: controllerT.selectedContacts.value == 0
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
                      border:
                          Border.all(color: ColorConstant.primaryBlue, width: 2),
                      color: controllerT.selectedContacts.value == 1
                          ? ColorConstant.primaryBlue
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        AppString.Done,
                        style: DL.styleDL(
                          fontSize: (10),
                          fontColor: controllerT.selectedContacts.value == 1
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
          SizedBox(height: getHeight(40),),
          SizedBox(
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                  fontColor: controllerT.selectDate.value == index
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
          ),
          SizedBox(height: getHeight(40),),
          Expanded(
            child: InkWell(onTap: (){
              Get.toNamed(AppRoutes.addTaskScreenRout);
            },
              child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                return  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('11:23\nPM'),
                    SizedBox(width: getWidth(40),),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: getWidth(150),
                        child: Center(child: Text('Hemal Ramani,\nFlutter\njf\ncf')),
                        decoration: BoxDecoration(  boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
