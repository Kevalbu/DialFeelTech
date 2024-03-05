import 'package:dial/core/app_export.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  ///common method for showing progress dialog
  static void showProgressDialog({isCancellable = false}) async {
    if (!isProgressVisible) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorConstant.primaryBlue,
            ),
          ),
        ),
        barrierDismissible: isCancellable,
      );
      isProgressVisible = true;
    }
  }

  static void showProgressDialogSmall({isCancellable = false}) async {
    if (!isProgressVisible) {
      Get.dialog(
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorConstant.primaryBlue,
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: isCancellable,
      );
      isProgressVisible = true;
    }
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    if (isProgressVisible) Get.back();
    isProgressVisible = false;
  }

  static void showSnackBar({headerText, bodyText, EdgeInsets? margin}) {
    Get.closeAllSnackbars();
    Get.snackbar(headerText, bodyText,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstant.primaryBlack,
        backgroundColor: ColorConstant.primaryBlue.withOpacity(0.4),
        margin: margin ?? EdgeInsets.only(bottom: 26, left: 16, right: 16));
  }

  static void showSnackBar2({headerText, bodyText, EdgeInsets? margin}) {
    Get.closeAllSnackbars();
    Get.snackbar(headerText, bodyText,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstant.primaryBlack,
        backgroundColor: ColorConstant.primaryBlue.withOpacity(0.4),
        margin: EdgeInsets.only(bottom: 26, left: 150, right: 150));
  }

  static void showTitleSnackBar(
      {required headerText,
      Duration? duration = const Duration(seconds: 2),
      EdgeInsets? margin}) {
    Get.closeAllSnackbars();

    Get.rawSnackbar(
        duration: duration,
        messageText: Text(
          headerText,
          style: TextStyle(color: Colors.white),
        ),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstant.primaryBlue,
        margin: EdgeInsets.only(
            bottom: getHeight(16), left: getWidth(16), right: getWidth(16)));
  }
}
