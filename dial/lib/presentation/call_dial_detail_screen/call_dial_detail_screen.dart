import 'dart:developer';

import 'package:dial/core/app_export.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

import 'controller/call_dial_detail_screen_controller.dart';
import 'models/disposition_model.dart';

class CallDialDetailScreen extends GetWidget<CallDialDetailScreenController> {
  const CallDialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

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
                              '${controller.name.value[0].toUpperCase()}${controller.name.value[1].toUpperCase()}',
                              style: DL.styleDL(
                                fontSize: (40),
                                fontColor: ColorConstant.primaryWhite,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          controller.name.value,
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
                              child: const Icon(
                                Icons.phone_callback,
                                color: ColorConstant.primaryWhite,
                              ),
                            ),
                            Text(
                              controller.number.value,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Adjust padding as needed
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Adjust circle radius
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.white,
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2<DispositionModel>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  AppString.selectStatus,
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
                          items: controller.dispositionList
                              .map((DispositionModel item) =>
                                  DropdownMenuItem<DispositionModel>(
                                    value: item,
                                    child: Text(
                                      item.name?.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: controller.selectedValue?.value,
                          onChanged: (DispositionModel? value) {
                            controller.selectedValue?.value = value!;
                            controller.dispositionId.value = value?.id ?? '';
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Obx(
                  () => controller.selectedValue.value.name == 'CallBack'
                      ? Column(
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

                                textAlign:
                                    TextAlign.start, // Center align the text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                    builder:
                                        (BuildContext context, Widget? child) {
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
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
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
                                      controller.pickDates.value =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);

                                      print('121212  ${pickedDate}');
                                      print(pickedTime);
                                      controller.dateInput.text =
                                          formattedDateTime;
                                    }
                                  }
                                },
                                controller: controller.dateInput,

                                decoration: InputDecoration(
                                  hintText: AppString.selectDateTime,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ), // Adjust vertical padding
                                  prefixIcon: const Icon(Icons.date_range),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.dateInput.clear();
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),

                            // Your other UI elements
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                Obx(() => controller.selectedValue.value.name == 'CallBack'
                    ? SizedBox(
                        height: getHeight(20),
                      )
                    : SizedBox.shrink()),
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
                        child: const Icon(
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
                      controller.save();
                      // Get.toNamed(AppRoutes.callDialDetailScreenRout);
                    }),
              ],
            ),
          ),
        ));
  }
}
