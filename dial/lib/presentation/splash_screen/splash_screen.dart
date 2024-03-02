import 'package:dial/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dial/core/utils/app_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return Scaffold(
        backgroundColor: ColorConstant.primaryWhite,
        body: Center(
            child: Text(
          AppString.dial,
          style: DL.styleDL(
              fontSize: (50),
              fontWeight: FontWeight.bold,
              fontColor: ColorConstant.primaryBlue),
        )));
  }
}
