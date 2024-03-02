import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dial/core/app_export.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import 'controller/call_dial_detail_screen_controller.dart';

class CallDialDetailScreen extends GetWidget<CallDialDetailScreenController> {
  const CallDialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];

    String? selectedValue;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryWhite,
          title: Text(
            AppString.disposeCall,
            style: DL.styleDL(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        backgroundColor: ColorConstant.primaryWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: getHeight(100),
                          width: getWidth(100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: ColorConstant.primaryBlue,
                          ),
                          child: Center(
                            child: Text(
                              'NA',
                              style: DL.styleDL(
                                fontSize: (40),
                                fontColor: ColorConstant.primaryWhite,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Unknow',
                          style: DL.styleDL(
                            fontSize: (15),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: getWidth(30)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'you just speak to ',
                          style: DL.styleDL(
                            fontSize: (15),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: getHeight(35),
                              width: getWidth(50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: ColorConstant.primaryBlue,
                              ),
                              child: Icon(
                                Icons.phone_callback,
                                color: ColorConstant.primaryWhite,
                              ),
                            ),
                            Text(
                              '1234567890',
                              style: DL.styleDL(
                                fontSize: (15),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: getHeight(20)),
                Text(
                  'Whtas heppand on call',
                  style: DL.styleDL(
                    fontSize: (12),
                    fontColor: ColorConstant.primaryBlack,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10), // Adjust padding as needed
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Adjust circle radius
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'CALLBACK',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.primaryBlack,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your other UI elements
                    SizedBox(height: getHeight(10)),
                    Text(
                      'Remind On',
                      style: DL.styleDL(
                        fontSize: 12,
                        fontColor: ColorConstant.primaryBlack,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: getHeight(10)),
                    Container(
                      height: 40,
                      child: TextFormField(
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
                    ),

                    // Your other UI elements
                  ],
                ),
                SizedBox(
                  width: getWidth(20),
                ),
                Obx(
                  () => Text(
                    'Lead Score ${controller.sliderValue.value.toString()}%',
                    style: DL.styleDL(
                      fontSize: 12,
                      fontColor: ColorConstant.yellow,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
// width: 100,
// height: 50,
                  padding: EdgeInsets.zero,
                  child: FlutterSlider(
                    handler: FlutterSliderHandler(
                        child: Icon(
                      Icons.emoji_emotions,
                      color: ColorConstant.yellow,
                    )),
                    trackBar: FlutterSliderTrackBar(
                        activeTrackBarHeight: getHeight(6),
                        inactiveTrackBar: BoxDecoration(
                            color: ColorConstant.greyColord3,
                            borderRadius: BorderRadius.circular(10)),
                        inactiveTrackBarHeight: getHeight(6),
                        activeTrackBar: BoxDecoration(
                            color: ColorConstant.primaryBlue,
                            borderRadius: BorderRadius.circular(10))),
                    tooltip: FlutterSliderTooltip(disabled: true),
                    onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                      controller.sliderValue.value = lowerValue.toString();
                      print('handlerIndex $handlerIndex');
                      print('handlerIndex $lowerValue');
                      print('handlerIndex $upperValue');
                    },
                    values: [0],
                    max: 100,
                    min: 0,
                  ),
                ),
                AppElevatedButton(
                    showTextIcon: true,
                    icon: Icons.save,
                    buttonName: 'SAVE',
                    onPressed: () {
                      Get.toNamed(AppRoutes.callDialDetailScreenRout);
                    }),
              ],
            ),
          ),
        ));
  }
}
