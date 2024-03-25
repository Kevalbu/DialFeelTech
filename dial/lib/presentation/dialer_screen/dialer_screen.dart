import 'package:dial/core/app_export.dart';
import 'controller/dialer_screen_controller.dart';

class DialerScreen extends GetWidget<DialerScreenController> {
  DialerScreen({super.key});

  DialerScreenController controllerD = Get.put(DialerScreenController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return controllerD.oneContactApi();
      },
      child: SizedBox(
        height: double.maxFinite,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dialer',
                        style: DL.styleDL(
                            fontSize: (30),
                            fontWeight: FontWeight.bold,
                            fontColor: ColorConstant.primaryBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(25),
                  ),
                  Obx(
                    () => Container(
                      width:
                          !controllerD.noContact.value ? double.infinity : null,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: ColorConstant.greyColord3,
                              offset: Offset(
                                5.0,
                                8.0,
                              ),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ), //BoxShadow
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConstant.primaryBlue),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: !controllerD.noContact.value
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getHeight(80)),
                                  child: Text(
                                    'No Contact',
                                    style: DL.styleDL(
                                      fontSize: 18,
                                      fontColor: ColorConstant.primaryWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_pin,
                                        size: 40,
                                        color: ColorConstant.primaryWhite,
                                      ),
                                      SizedBox(
                                        width: getWidth(10),
                                      ),
                                      Text(
                                        controllerD.singleContactModel.value
                                                .name ??
                                            '',
                                        style: DL.styleDL(
                                          fontSize: (15),
                                          fontColor: ColorConstant.primaryWhite,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(10),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.call,
                                        size: 30,
                                        color: ColorConstant.primaryWhite,
                                      ),
                                      SizedBox(
                                        width: getWidth(10),
                                      ),
                                      Text(
                                        controllerD.singleContactModel.value
                                                .mobile2 ??
                                            '',
                                        style: DL.styleDL(
                                          fontSize: (15),
                                          fontColor: ColorConstant.primaryWhite,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(25),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        color: ColorConstant.primaryWhite,
                                      ),
                                      SizedBox(
                                        width: getWidth(10),
                                      ),
                                      Text(
                                        controllerD.changeDateFormat(controllerD
                                                .singleContactModel
                                                .value
                                                .createdDate
                                                .toString() ??
                                            ''),
                                        // 'Feb 24,2024 4:29 PM',
                                        style: DL.styleDL(
                                          fontSize: (12),
                                          fontColor: ColorConstant.primaryWhite,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: getHeight(40)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: getHeight(20),
                                        width: getWidth(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: ColorConstant.primaryWhite,
                                        ),
                                        child: Center(
                                            child: Obx(
                                          () => Text(
                                            controllerD.start.value.toString(),
                                            style: TextStyle(
                                              color: ColorConstant.primaryBlue,
                                            ),
                                          ),
                                        )),
                                      ),
                                      Row(
                                        children: [
                                          Bounce(
                                            onTap: () {
                                              controllerD.skipApi(controllerD
                                                      .singleContactModel
                                                      .value
                                                      .id ??
                                                  '');
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: ColorConstant
                                                      .primaryWhite,
                                                ),
                                                child: Icon(
                                                  Icons.double_arrow,
                                                  color:
                                                      ColorConstant.primaryBlue,
                                                )),
                                          ),
                                          SizedBox(
                                            width: getWidth(20),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color:
                                                    ColorConstant.primaryWhite,
                                              ),
                                              child: Icon(
                                                Icons.history,
                                                size: getHeight(20),
                                                color:
                                                    ColorConstant.primaryBlue,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(40),
                  ),
                  SizedBox(
                      width: getWidth(160),
                      child: Obx(
                        () => AppElevatedButton(
                          icon: Icons.phone_in_talk,
                          buttonName: controllerD.startTime.value
                              ? AppString.stop
                              : AppString.start,
                          buttonColor: !controllerD.noContact.value
                              ? ColorConstant.greyColor72
                              : controllerD.startTime.value
                                  ? ColorConstant.red
                                  : ColorConstant.primaryBlue,
                          onPressed: !controllerD.noContact.value
                              ? null
                              : () {
                                  controllerD.startTime.value
                                      ? controllerD.stopTimer()
                                      : controllerD.startTimer();
                                },
                          showTextIcon: true,
                        ),
                      )),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: getHeight(100),
                        width: getWidth(150),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstant.greyColor72,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pending'),
                            Text(
                              '9',
                              style: DL.styleDL(
                                fontSize: (20),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getHeight(100),
                        width: getWidth(150),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstant.greyColor72,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Done'),
                            Text(
                              '9',
                              style: DL.styleDL(
                                fontSize: (20),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
