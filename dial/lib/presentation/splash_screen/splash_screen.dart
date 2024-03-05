import 'package:dial/core/app_export.dart';

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
