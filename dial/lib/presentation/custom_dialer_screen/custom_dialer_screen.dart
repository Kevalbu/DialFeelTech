import 'package:call_log/call_log.dart';
import 'package:dial/core/app_export.dart';
import '../../widgets/numPad.dart';
import 'controller/custom_dialer_screen_controller.dart';
import 'dart:math' as math;

class CustomDialerScreen extends GetWidget<CustomDialerScreenController> {
  const CustomDialerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorConstant.primaryWhite,
          appBar: AppBar(
            backgroundColor: ColorConstant.primaryWhite,
            title: Text(
              AppString.manual,
              style: DL.styleDL(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              onTap: (value) {
                if (value == 1) {
                  controller.callLogs();
                }
              },
              indicatorColor: ColorConstant.primaryBlue,
              tabs: const [
                Tab(
                    icon: Column(
                  children: [
                    Icon(Icons.dialpad_rounded),
                    Text(AppString.dialPad)
                  ],
                )),
                Tab(
                    icon: Column(
                  children: [
                    Icon(Icons.phone_callback),
                    Text(AppString.recentCalls)
                  ],
                )),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(25)),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: controller.pinController,
                        style: DL.styleDL(
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2, //<-- SEE HERE
                              color: ColorConstant.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    NumPad(
                      type: '-',
                      controller: controller.pinController,
                      delete: () {
                        HapticFeedback.lightImpact();

                        if (controller.pinController.text.isNotEmpty) {
                          controller.pinController.text =
                              controller.pinController.text.substring(
                                  0, controller.pinController.text.length - 1);
                        }
                      },
                      // do something with the input numbers
                      onSubmit: () {
                        debugPrint(
                            'Your code: ${controller.pinController.text}');
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Bounce(
                          onTap: () {
                            controller
                                .callNumber(controller.pinController.text);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorConstant.green),
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.call,
                              color: ColorConstant.primaryWhite,
                              size: getHeight(35),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Obx(
                () => controller.callLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorConstant.primaryBlue,
                      ))
                    : ListView.builder(
                        itemCount: controller.callLogList.length,
                        itemBuilder: (context, index) {
                          controller.getRandomColor();
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(16),
                                vertical: getHeight(10)),
                            child: Bounce(
                              onTap: () {
                                controller.callNumber(
                                    controller.callLogList[index].number ?? '');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: getHeight(50),
                                      width: getHeight(50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: controller.color.value
                                              .withOpacity(0.2)),
                                      // color: ColorConstant.primaryWhiteBlue),
                                      padding: EdgeInsets.all(10),
                                      child: controller.callLogList[index]
                                                      .name ==
                                                  null ||
                                              controller.callLogList[index]
                                                  .name!.isEmpty
                                          ? Icon(
                                              Icons.person,
                                              color: controller.color.value,
                                            )
                                          : Center(
                                              child: Text(
                                                controller.callLogList[index]
                                                        .name?[0] ??
                                                    '',
                                                style: DL.styleDL(
                                                    fontSize: 16,
                                                    fontColor:
                                                        controller.color.value,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                  SizedBox(
                                    width: getWidth(20),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              controller.getIconData(controller
                                                      .callLogList[index]
                                                      .callType ??
                                                  CallType.outgoing),
                                              color: controller
                                                  .getIconDataColor(controller
                                                          .callLogList[index]
                                                          .callType ??
                                                      CallType.outgoing),
                                              size: getHeight(15),
                                            ),
                                            SizedBox(
                                              width: getWidth(3),
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller.callLogList[index]
                                                                .name ==
                                                            null ||
                                                        controller
                                                            .callLogList[index]
                                                            .name!
                                                            .isEmpty
                                                    ? controller
                                                            .callLogList[index]
                                                            .number ??
                                                        ''
                                                    : controller
                                                            .callLogList[index]
                                                            .name ??
                                                        '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: DL.styleDL(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getHeight(5),
                                        ),
                                        Text(
                                          controller.formatTimestamp(controller
                                                  .callLogList[index].timestamp
                                                  ?.toInt() ??
                                              000000000),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: DL.styleDL(
                                              fontColor:
                                                  ColorConstant.greyText),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: getWidth(20),
                                  ),
                                  Container(
                                      height: getHeight(22),
                                      width: getHeight(22),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: ColorConstant.green),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: ColorConstant.primaryWhite,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
