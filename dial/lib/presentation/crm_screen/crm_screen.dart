import 'package:dial/core/app_export.dart';
import 'controller/crm_screen_controller.dart';

class CRMScreen extends GetWidget<CRMScreenController> {
  CRMScreen({super.key});
  CRMScreenController controllerC = Get.put(CRMScreenController());
  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.contacts,
                    style: DL.styleDL(
                        fontSize: (30),
                        fontWeight: FontWeight.bold,
                        fontColor: ColorConstant.primaryBlack),
                  ),
                  const Icon(
                    Icons.contactless,
                    color: ColorConstant.primaryBlue,
                    size: 40,
                  )
                ],
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Bounce(
                    onTap: () {
                      controllerC.changeContact(0);
                    },
                    child: Container(
                      height: getHeight(40),
                      width: getWidth(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controllerC.selectedContacts.value == 0
                              ? ColorConstant.primaryBlue
                              : Colors.grey.shade400),
                      child: Center(
                        child: Text(
                          AppString.allContacts,
                          style: DL.styleDL(
                              fontSize: (10),
                              fontColor: ColorConstant.primaryWhite),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Bounce(
                    onTap: () {
                      controllerC.changeContact(1);
                    },
                    child: Container(
                      height: getHeight(40),
                      width: getWidth(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controllerC.selectedContacts.value == 1
                            ? ColorConstant.primaryBlue
                            : Colors.grey.shade400,
                      ),
                      child: Center(
                        child: Text(
                          AppString.myContacts,
                          style: DL.styleDL(
                              fontSize: (10),
                              fontColor: ColorConstant.primaryWhite),
                        ),
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.filter_list_outlined,
                  color: ColorConstant.primaryBlue,
                  size: 40,
                ),
                const Icon(
                  Icons.search_rounded,
                  color: ColorConstant.primaryBlue,
                  size: 40,
                ),
              ],
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          // height: getHeight(40),
                          // width: getWidth(double.infinity),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            color: ColorConstant.primaryBlue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.label_important,
                                      color: ColorConstant.primaryWhite,
                                    ),
                                    Text(
                                      'New',
                                      style: DL.styleDL(
                                        fontSize: (15),
                                        fontColor: ColorConstant.primaryWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.call,
                                  color: ColorConstant.primaryWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // height: getHeight(110),
                          // width: getWidth(double.infinity),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: ColorConstant.primaryWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  2.0,
                                  1.0,
                                ),
                                blurRadius: 10,
                                spreadRadius: 0.20,
                              ), //BoxShadow
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kishan',
                                      style: DL.styleDL(
                                        fontSize: (15),
                                        fontColor: ColorConstant.primaryBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(40),
                                    ),
                                    Center(
                                      child: Container(
                                        height: getHeight(30),
                                        width: getWidth(70),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: ColorConstant.greyColorB3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.emoji_emotions,
                                              color: ColorConstant.yellow,
                                            ),
                                            Text(
                                              '64',
                                              style: DL.styleDL(
                                                  fontSize: (15),
                                                  fontColor: ColorConstant
                                                      .primaryBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '+911234567890',
                                  style: DL.styleDL(
                                    fontSize: (15),
                                    fontColor: ColorConstant.primaryBlack,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: ColorConstant.greyColor72,
                                    ),
                                    SizedBox(
                                      width: getWidth(10),
                                    ),
                                    Text(
                                      'Feb 24,2024 4:29 PM',
                                      style: DL.styleDL(
                                        fontSize: (12),
                                        fontColor: ColorConstant.greyColor72,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(20),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
