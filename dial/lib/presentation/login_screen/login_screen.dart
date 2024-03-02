import 'package:dial/core/app_export.dart';

import 'controller/login_screen_controller.dart';

class LoginScreen extends GetWidget<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return Scaffold(
        backgroundColor: ColorConstant.primaryWhite,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppString.login,
                  style: DL.styleDL(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_pin,
                      size: getHeight(30),
                    ),
                    SizedBox(
                      width: getWidth(20),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.emailController,
                        cursorColor: ColorConstant.primaryBlack,
                        decoration: InputDecoration(
                          hintText: AppString.userNameEmail,
                          hintStyle: DL.styleDL(
                              fontColor: ColorConstant.greyColor72,
                              fontWeight: FontWeight.w600),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: ColorConstant.greyColorB3,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: ColorConstant.greyColorB3,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: getHeight(28),
                    ),
                    SizedBox(
                      width: getWidth(20),
                    ),
                    Expanded(
                      child: Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          cursorColor: ColorConstant.primaryBlack,
                          obscureText: controller.isShow.value,
                          decoration: InputDecoration(
                            hintText: AppString.password,
                            hintStyle: DL.styleDL(
                                fontColor: ColorConstant.greyColor72,
                                fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: ColorConstant.greyColorB3,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: ColorConstant.greyColorB3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    Obx(
                      () => Bounce(
                          onTap: () {
                            controller.changeShowHide();
                          },
                          child: Icon(!controller.isShow.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(30),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => AppElevatedButton(
                          isLoading: isLoading.value,
                          buttonName: AppString.loginC,
                          onPressed: () {
                            controller.next();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(20),
                    ),
                    Expanded(
                      child: AppElevatedButton(
                        shadow: true,
                        buttonColor: ColorConstant.primaryWhite,
                        textColor: ColorConstant.primaryBlue,
                        buttonName: AppString.cancelC,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppString.forgotPassword,
                          style: DL.styleDL(
                              fontSize: 16,
                              fontColor: ColorConstant.primaryBlue),
                        )),
                    Icon(
                      Icons.bug_report_sharp,
                      color: ColorConstant.primaryBlue,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
