import 'package:dial/core/app_export.dart';

import 'controller/settings_screen_controller.dart';

class SettingsScreen extends GetWidget<SettingsScreenController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      AppString.dial,
      style: DL.styleDL(
          fontSize: (50),
          fontWeight: FontWeight.bold,
          fontColor: ColorConstant.primaryBlue),
    ));
  }
}
