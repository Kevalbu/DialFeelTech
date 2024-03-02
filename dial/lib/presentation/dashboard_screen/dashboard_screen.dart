import 'dart:ffi';

import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'controller/dashbboard_screen_controller.dart';

class DashBoardScreen extends GetWidget<DashBoardScreenController> {
  DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return Scaffold(
      backgroundColor: ColorConstant.primaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primaryWhite,
        surfaceTintColor: ColorConstant.primaryWhite,
        actions: [
          Obx(
            () => controller.tabIndex.value == 0 ||
                    controller.tabIndex.value == 1
                ? InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: ColorConstant.primaryWhite,
                          context: context,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: getHeight(20),
                                ),
                                AppBar(
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        AppString.close,
                                        style: DL.styleDL(
                                            fontWeight: FontWeight.w500,
                                            fontColor:
                                                ColorConstant.primaryBlue,
                                            fontSize: 16),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(
                                      width: getWidth(10),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: ListView(
                                    padding: EdgeInsets.all(8.0),
                                    children: controller.getListModel
                                        .map((v) => Obx(
                                              () => RadioListTile<String>(
                                                groupValue: controller
                                                    .currentTimeValue.value,
                                                title: Text(v.label ?? ''),
                                                value: v.value ?? '',
                                                onChanged: (val) {
                                                  debugPrint('VAL = $val');
                                                  controller.currentTimeValue
                                                      .value = val!;
                                                  controller.selectedListItem
                                                      .value = v.label ?? '';
                                                  Get.back();
                                                },
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: ColorConstant.primaryBlue)),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              'List: ${controller.selectedListItem.value}',
                              style: DL.styleDL(
                                  fontSize: 14,
                                  fontColor: ColorConstant.primaryBlue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(4),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: ColorConstant.primaryBlue,
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          SizedBox(
            width: getWidth(16),
          )
        ],
      ),
      body: Stack(
        children: [
          PopScope(
            canPop: true,
            onPopInvoked: controller.onWillPop,
            child: Obx(
              () => controller.pages[controller.tabIndex.value],
            ),
          ),
          Obx(() => controller.tabIndex.value == 0
              ? Positioned(
                  bottom: 17,
                  right: 17,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.customDialerScreenRout);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstant.primaryBlue),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.call,
                        color: ColorConstant.primaryWhite,
                        size: getHeight(30),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink())
        ],
      ),

      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: Obx(
        () => controller.tabIndex.value == 1
            ? ExpandableFab(
                key: controller.key,
                // duration: const Duration(milliseconds: 500),
                distance: 60.0,
                type: ExpandableFabType.up,
                // pos: ExpandableFabPos.left,
                childrenOffset: const Offset(0, 0),
                fanAngle: 0,
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.add),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: ColorConstant.primaryWhite,
                  backgroundColor: ColorConstant.primaryBlue,
                  shape: const CircleBorder(),
                  angle: 3.14 * 2,
                ),
                closeButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.close),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: ColorConstant.primaryWhite,
                  backgroundColor: ColorConstant.primaryBlue,
                  shape: const CircleBorder(),
                  angle: 3.14 * 2,
                ),
                // overlayStyle: ExpandableFabOverlayStyle(
                //   // color: Colors.black.withOpacity(0.5),
                //   blur: 5,
                // ),
                onOpen: () {
                  debugPrint('onOpen');
                },
                afterOpen: () {
                  debugPrint('afterOpen');
                },
                onClose: () {
                  debugPrint('onClose');
                },
                afterClose: () {
                  debugPrint('afterClose');
                },
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: ColorConstant.primaryWhite,
                          context: context,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight(15),
                                      horizontal: getWidth(20)),
                                  child: Text(
                                    AppString.options,
                                    style: DL.styleDL(fontSize: 14),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.person_pin,
                                    size: getHeight(30),
                                    color: ColorConstant.primaryBlue,
                                  ),
                                  title: Text(
                                    AppString.add,
                                    style: DL.styleDL(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontColor: ColorConstant.primaryBlue),
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(
                                        AppRoutes.addNewContactScreenRout);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.person_pin_rounded,
                                    size: getHeight(30),
                                    color: ColorConstant.primaryBlue,
                                  ),
                                  title: Text(
                                    AppString.phonebook,
                                    style: DL.styleDL(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontColor: ColorConstant.primaryBlue),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.download,
                                    size: getHeight(30),
                                    color: ColorConstant.primaryBlue,
                                  ),
                                  title: Text(
                                    AppString.importExel,
                                    style: DL.styleDL(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontColor: ColorConstant.primaryBlue),
                                  ),
                                  onTap: () {},
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight(20),
                                      horizontal: getWidth(10)),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      AppString.cancel,
                                      style: DL.styleDL(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontColor: ColorConstant.red),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: ColorConstant.primaryBlue),
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(18), vertical: getHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_pin_rounded,
                            color: ColorConstant.primaryWhite,
                          ),
                          SizedBox(
                            width: getWidth(10),
                          ),
                          Text(
                            AppString.contact,
                            style: DL.styleDL(
                                fontSize: 14,
                                fontColor: ColorConstant.primaryWhite,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bottomSheetList(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: ColorConstant.primaryBlue),
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(18), vertical: getHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.list,
                            color: ColorConstant.primaryWhite,
                          ),
                          SizedBox(
                            width: getWidth(10),
                          ),
                          Text(
                            AppString.lists,
                            style: DL.styleDL(
                                fontSize: 14,
                                fontColor: ColorConstant.primaryWhite,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ), // Bounce(
      //   onTap: () {
      //     Get.toNamed(AppRoutes.customDialerScreenRout);
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(100),
      //         color: ColorConstant.primaryBlue),
      //     padding: EdgeInsets.all(10),
      //     child: Icon(
      //       Icons.call,
      //       color: ColorConstant.primaryWhite,
      //       size: getHeight(30),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Container(
        height: getHeight(80),
        decoration: const BoxDecoration(
          color: ColorConstant.primaryWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconWidget(index: 0, icon: Icons.call, label: AppString.dialer),
                iconWidget(
                    index: 1,
                    icon: Icons.person_pin_rounded,
                    label: AppString.crm),
                iconWidget(
                    index: 2, icon: Icons.check_box, label: AppString.tasks),
                iconWidget(
                    index: 3, icon: Icons.settings, label: AppString.settings),
              ],
            )),
      ),
    );
  }

  Widget iconWidget(
      {required int index, required IconData icon, required String label}) {
    return Bounce(
      onTap: () {
        controller.changeTabIndex(index);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: controller.tabIndex.value == index
                    ? ColorConstant.primaryBlue
                    : ColorConstant.primaryBlack,
              ),
              SizedBox(
                height: getHeight(5),
              ),
              Text(
                label,
                style: controller.tabIndex.value == index
                    ? DL.styleDL(fontColor: ColorConstant.primaryBlue)
                    : DL.styleDL(fontColor: ColorConstant.primaryBlack),
              )
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetList(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: ColorConstant.primaryWhite,
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getHeight(15), horizontal: getWidth(20)),
                child: Text(
                  AppString.list,
                  style: DL.styleDL(fontSize: 14),
                ),
              ),
              ListTile(
                leading: Container(
                    height: getHeight(22),
                    width: getHeight(22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorConstant.primaryBlue),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: ColorConstant.primaryWhite,
                      ),
                    )),
                title: Text(
                  AppString.ne0w,
                  style: DL.styleDL(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorConstant.primaryBlue),
                ),
                onTap: () {
                  showDialogAddList(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.sync,
                  size: getHeight(30),
                  color: ColorConstant.primaryBlue,
                ),
                title: Text(
                  AppString.rechurn,
                  style: DL.styleDL(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorConstant.primaryBlue),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_circle_up_rounded,
                  size: getHeight(30),
                  color: ColorConstant.primaryBlue,
                ),
                title: Text(
                  AppString.export,
                  style: DL.styleDL(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorConstant.primaryBlue),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.clear_all,
                  size: getHeight(30),
                  color: ColorConstant.primaryBlue,
                ),
                title: Text(
                  AppString.clear,
                  style: DL.styleDL(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorConstant.primaryBlue),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_forever,
                  size: getHeight(30),
                  color: ColorConstant.red,
                ),
                title: Text(
                  AppString.delete,
                  style: DL.styleDL(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorConstant.red),
                ),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getHeight(20), horizontal: getWidth(10)),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppString.cancel,
                    style: DL.styleDL(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorConstant.red),
                  ),
                ),
              )
            ],
          );
        });
  }

  showDialogAddList(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: ColorConstant.primaryWhite,
          backgroundColor: ColorConstant.primaryWhite,
          title: Text(
            AppString.dial,
            style: DL.styleDL(
                fontWeight: FontWeight.w600,
                fontColor: ColorConstant.primaryBlue,
                fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.enterNameList,
                style: DL.styleDL(fontSize: 14),
              ),
              TextFormField(
                controller: controller.addListNameController,
              )
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                AppString.close,
                style: DL.styleDL(
                    fontSize: 14,
                    fontColor: ColorConstant.red,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                AppString.save,
                style: DL.styleDL(
                    fontSize: 14,
                    fontColor: ColorConstant.primaryBlue,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                controller.addList();
              },
            ),
          ],
        );
      },
    );
  }
}
