import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import 'controller/permission_screen_controller.dart';

class PermissionScreen extends GetWidget<PermissionScreenController> {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.primaryWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
              child: Column(
                children: [
                  SizedBox(
                    height: getHeight(50),
                  ),
                  Center(
                      child: Text(
                    AppString.permissionText,
                    textAlign: TextAlign.center,
                    style: DL.styleDL(
                      fontSize: (16),
                    ),
                  )),
                  SizedBox(
                    height: getHeight(50),
                  ),
                  Obx(
                    () => itemLisTile(
                        title: AppString.phone,
                        description: AppString.phoneText,
                        onPressed: () {
                          controller.requestPhonePermissions();
                        },
                        icons: Icons.phone,
                        isCheck: controller.phone.value),
                  ),
                  Obx(
                    () => itemLisTile(
                        isCheck: controller.contact.value,
                        title: AppString.contact,
                        description: AppString.contactText,
                        onPressed: () {
                          controller.requestContactPermissions();
                        },
                        icons: Icons.person),
                  ),
                  // Obx(
                  //   () => itemLisTile(
                  //       isCheck: controller.microPhone.value,
                  //       title: AppString.microPhone,
                  //       description: AppString.microphoneText,
                  //       onPressed: () {
                  //         controller.requestMicroPhonePermissions();
                  //       },
                  //       icons: Icons.mic),
                  // ),
                  Obx(() => itemLisTile(
                      isCheck: controller.notification.value,
                      title: AppString.notification,
                      description: AppString.notificationText,
                      onPressed: () {
                        controller.requestNotificationPermissions();
                      },
                      icons: Icons.notifications)),
                  Obx(() => itemLisTile(
                      isCheck: controller.location.value,
                      title: AppString.location,
                      description: AppString.locationText,
                      onPressed: () {
                        controller.requestLocationPermissions();
                      },
                      icons: Icons.location_on)),
                  Obx(() => itemLisTile(
                      isCheck: controller.callLog.value,
                      title: AppString.callLog,
                      description: AppString.callLogText,
                      onPressed: () {
                        controller.requestCallLogPermissions();
                      },
                      icons: Icons.phone_callback_sharp)),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  AppElevatedButton(
                    buttonName: AppString.finish,
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.dashboardScreenRout);
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget itemLisTile(
      {required String title,
      required String description,
      required bool isCheck,
      required void Function() onPressed,
      required IconData icons}) {
    return Container(
      margin: EdgeInsets.only(bottom: getHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.greyColord3),
        color: ColorConstant.primaryWhite,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(10), vertical: getHeight(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isCheck ? Icons.check_circle : Icons.info,
                    color: isCheck
                        ? ColorConstant.primaryBlue
                        : ColorConstant.yellow,
                  ),
                  SizedBox(
                    width: getWidth(8),
                  ),
                  Icon(icons),
                  SizedBox(
                    width: getWidth(3),
                  ),
                  Text(
                    title,
                    style: DL.styleDL(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: getHeight(35),
                width: getWidth(100),
                child: AppElevatedButton(
                  buttonName: AppString.check,
                  onPressed: onPressed,
                ),
              )
            ],
          ),
          SizedBox(
            height: getHeight(5),
          ),
          Text(
            description,
            style: DL.styleDL(fontColor: ColorConstant.greyText),
          )
        ],
      ),
    );
  }
}
