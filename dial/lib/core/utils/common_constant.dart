import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_export.dart';
import 'package:permission_handler/permission_handler.dart';

class CommonConstant {
  CommonConstant._();

  static final instance = CommonConstant._();

  String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  Pattern phonePattern = r'(^[0-9 ]*$)';

  bool validateEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  String checkDeviceType() {
    if (kIsWeb) {
      return "Web";
    } else if (Platform.isIOS) {
      return "Ios";
    } else {
      return "Android";
    }
  }

  static String convertToSha265Key(String key) {
    var bytes = utf8.encode(key);
    var generatedSignature = sha256.convert(bytes);
    return generatedSignature.toString();
  }

  Future<bool> requestFilePermission() async {
    late AndroidDeviceInfo androidInfo;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      try {
        androidInfo = await deviceInfo.androidInfo;
        print(androidInfo.version.sdkInt);
      } catch (e) {
        print('Failed to get Android device info: $e');
      }
    }
    PermissionStatus result;
    PermissionStatus resultAudio;
    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt >= 33) {
        result = await Permission.photos.request();
        resultAudio = await Permission.audio.request();
      } else {
        result = await Permission.storage.request();
        resultAudio = await Permission.audio.request();
      }
      if (androidInfo.version.sdkInt >= 33) {
        if (result.isGranted && resultAudio.isGranted) {
          return true;
        }
      } else {
        if (result.isGranted) {
          return true;
        }
      }
    } else {
      result = await Permission.photos.request();
      if (result.isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> requestLocationPermission() async {
    final permission = Permission.location;

    if (await permission.isDenied) {
      await permission.request();
    }
    if (await permission.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  CustomCupertinoBottomDilouge({
    String? headText,
    required String firstText,
    Color secondTextColor = ColorConstant.primaryBlue,
    required Function firstTextOnTap,
    String? secondText,
    Function? secondTextOnTap,
    Function? cancelButtonTap,
    required BuildContext context,
  }) {
    final action = CupertinoActionSheet(
      actions: [
        if (headText != null)
          CupertinoActionSheetAction(onPressed: () {}, child: Text(headText)),
        CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              firstTextOnTap.call();
            },
            child: Text(
              firstText,
              style: DL.style(20,
                  fontColor: ColorConstant.primaryBlack,
                  fontWeight: FontWeight.bold),
            )),
        if (secondText != null || secondTextOnTap != null)
          CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                secondTextOnTap!.call();
              },
              child: Text(secondText ?? '',
                  style: DL.style(20,
                      fontColor: ColorConstant.primaryBlack,
                      fontWeight: FontWeight.bold))),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel',
            style: DL.style(20,
                fontColor: ColorConstant.primaryBlack,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          Get.back();
        },
      ),
    );
    showCupertinoModalPopup(
        context: context,
        builder: (context) => action,
        barrierColor: ColorConstant.primaryBlack.withOpacity(0.5));
  }

  CustomCupertinoAlertDilouge(
      {required BuildContext context,
      required String Header,
      required String subTitle,
      required String yesButtonText,
      Color? yesButtonColor,
      required String noButtonText,
      required Function yesButtonTap,
      String? title}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Text(Header),
                if (title != null) Text(title),
              ],
            ),
            content: Column(
              children: [
                SizedBox(
                  height: getHeight(10),
                ),
                Text(subTitle)
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: Text(AppString.cancel)),
              TextButton(
                  onPressed: () {
                    yesButtonTap.call();
                  },
                  child: Text(AppString.yes)),
            ],
          );
        });
  }

  void showDialogs({required Widget child, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.all(getWidth(100)),
        contentPadding: EdgeInsets.zero,
        backgroundColor: ColorConstant.primaryWhite,
        content: child,
      ),
    );
  }

  void showDialogDate(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
