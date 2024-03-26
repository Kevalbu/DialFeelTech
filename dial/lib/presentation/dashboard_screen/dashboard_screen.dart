import 'package:dial/core/app_export.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../crm_screen/controller/crm_screen_controller.dart';
import '../dialer_screen/controller/dialer_screen_controller.dart';
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
                                                    .currentSelectedValue.value,
                                                title: Text(v.label ?? ''),
                                                value: v.value ?? '',
                                                onChanged: (val) async {
                                                  debugPrint('VAL = $val');
                                                  controller
                                                      .currentSelectedValue
                                                      .value = val!;
                                                  await PrefUtils.setString(
                                                      PrefsKey.selectListId,
                                                      val ?? '');
                                                  controller.selectedListItem
                                                      .value = v.label ?? '';
                                                  Get.put(DialerScreenController())
                                                      .oneContactApi();
                                                  Get.put(CRMScreenController())
                                                      .getContactApi();

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
      body: Obx(
        () => PopScope(
            canPop: controller.willPop.value,
            onPopInvoked: controller.onWillPop,
            child: Stack(
              children: [
                Obx(
                  () => controller.pages[controller.tabIndex.value],
                ),
                Obx(() => controller.tabIndex.value == 0 ||
                        controller.tabIndex.value == 2
                    ? Positioned(
                        bottom: 17,
                        right: 17,
                        child: InkWell(
                          onTap: () {
                            if (controller.tabIndex.value == 0) {
                              Get.toNamed(AppRoutes.customDialerScreenRout);
                            } else {
                              Get.toNamed(AppRoutes.addTaskScreenRout);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorConstant.primaryBlue),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              controller.tabIndex.value == 0
                                  ? Icons.call
                                  : Icons.add,
                              color: ColorConstant.primaryWhite,
                              size: getHeight(30),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink())
              ],
            )),
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
                onTap: () {
                  Get.back();
                  controller.dispositionList.clear();
                  controller.dispositionIdList.clear();
                  dispositionList(context);
                  // controller.rechurnListApi();
                },
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
                onTap: () {
                  Get.back();
                  showConfirmDeleteBox(context, false);
                },
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
                onTap: () {
                  Get.back();
                  showConfirmDeleteBox(context, true);
                  // controller.deleteListApi();
                },
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

  dispositionList(BuildContext context) {
    controller.getDispositionApi();
    return showModalBottomSheet(
        backgroundColor: ColorConstant.primaryWhite,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getHeight(15), horizontal: getWidth(20)),
                  child: Text(
                    AppString.resetStatus,
                    style:
                        DL.styleDL(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: getHeight(400),
                  child: Obx(
                    () => controller.dLoading.value
                        ? Center(
                            child: SizedBox(
                              height: getHeight(25),
                              width: getHeight(25),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: ColorConstant.primaryBlue,
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dispositionList.value.length,
                            itemBuilder: (_, int index) {
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: getWidth(16),
                                    vertical: getHeight(5)),
                                color: Colors.white,
                                elevation: 2.0,
                                child: Obx(
                                  () => CheckboxListTile(
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: getWidth(10),
                                          backgroundColor:
                                              ColorConstant.fromHex(controller
                                                      .dispositionList[index]
                                                      .color ??
                                                  ''),
                                        ),
                                        SizedBox(
                                          width: getWidth(15),
                                        ),
                                        Text(controller
                                                .dispositionList[index].name ??
                                            ''),
                                      ],
                                    ),
                                    value: controller.dispositionIdList
                                        .contains(controller
                                                .dispositionList[index].id ??
                                            ''),
                                    activeColor: ColorConstant.primaryBlue,
                                    onChanged: (_) {
                                      if (controller.dispositionIdList.contains(
                                          controller
                                                  .dispositionList[index].id ??
                                              '')) {
                                        controller.dispositionIdList.remove(
                                            controller.dispositionList[index]
                                                    .id ??
                                                ''); // unselect
                                      } else {
                                        controller.dispositionIdList.add(
                                            controller.dispositionList[index]
                                                    .id ??
                                                ''); // select
                                      }
                                      setState(() {});
                                      controller.dispositionIdList.refresh();
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.platform,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                SizedBox(
                  height: getHeight(15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  child: AppElevatedButton(
                    buttonName: AppString.submit,
                    onPressed: () {
                      controller.rechurnSubmit();
                    },
                  ),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          buttonName: AppString.reset,
                          buttonColor: ColorConstant.primaryWhite,
                          hasGradient: false,
                          borderColor: ColorConstant.greyText,
                          textColor: ColorConstant.primaryBlue,
                          onPressed: () {
                            controller.rechurnReset();
                          },
                        ),
                      ),
                      SizedBox(
                        width: getWidth(20),
                      ),
                      Expanded(
                        child: AppElevatedButton(
                          buttonName: AppString.cancel,
                          buttonColor: ColorConstant.primaryWhite,
                          hasGradient: false,
                          borderColor: ColorConstant.greyText,
                          textColor: ColorConstant.red,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  showConfirmDeleteBox(BuildContext context, bool isDelete) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: ColorConstant.primaryWhite,
          backgroundColor: ColorConstant.primaryWhite,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getHeight(15),
              ),
              Icon(
                Icons.info_outline_rounded,
                color: ColorConstant.orange86,
                size: getHeight(70),
              ),
              SizedBox(
                height: getHeight(15),
              ),
              Text(
                AppString.areYouSure,
                textAlign: TextAlign.center,
                style: DL.styleDL(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getHeight(8),
              ),
              Text(
                isDelete ? AppString.contactSure : AppString.deleteSure,
                textAlign: TextAlign.center,
                style: DL.styleDL(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: getHeight(20),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: AppElevatedButton(
                    buttonName: AppString.yesDeleteIt,
                    onPressed: () {
                      if (isDelete) {
                        controller.deleteListApi();
                      } else {
                        controller.emptyListApi();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: getWidth(10),
                ),
                Expanded(
                  child: AppElevatedButton(
                    buttonName: AppString.cancel,
                    buttonColor: ColorConstant.primaryWhite,
                    hasGradient: false,
                    borderColor: ColorConstant.greyText,
                    textColor: ColorConstant.red,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
