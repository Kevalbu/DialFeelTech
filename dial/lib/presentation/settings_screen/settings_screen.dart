import 'package:dial/core/app_export.dart';

import 'controller/settings_screen_controller.dart';

class SettingsScreen extends GetWidget<SettingsScreenController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppString.settings,
                style: DL.styleDL(
                    fontSize: (30),
                    fontWeight: FontWeight.bold,
                    fontColor: ColorConstant.primaryBlack),
              ),
            ],
          ),
          Spacer(),
          AppElevatedButton(
            buttonName: AppString.logout,
            onPressed: () {
              PrefUtils().clearPreferencesData();
              Get.offAllNamed(AppRoutes.loginScreenRoute);
            },
          ),
          SizedBox(
            height: getHeight(20),
          )
        ],
      ),
    );
  }
}
