import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import '../core/utils/app_prefs_key.dart';
import '../core/utils/common_function.dart';
import '../core/utils/pref_utils.dart';
import '../core/utils/progress_dialog_utils.dart';
import '../core/utils/string_constant.dart';
import 'network_info.dart';

RxBool isLoading = false.obs;

class ApiService extends GetConnect {
  ApiService() {
    timeout = const Duration(seconds: 120);
  }
  var headers;
  var headersWithToken;
  var contentType;
  String authToken = '';

  Future<void> getToken() async {}

  Future<void> initApiService() async {
    await NetworkInfo.checkNetwork().whenComplete(() async {
      authToken = await PrefUtils.getString(PrefsKey.authToken);
      print("Auth Token from API service is :- $authToken");
      headers = {"content-type": "application/json"};
      headersWithToken = {
        "content-type": "application/json",
        "Authorization": "Bearer" + " " + "$authToken"
      };
      contentType = "multipart/form-data";
    });
  }

  Future<Response> callPostApi(
      {required body,
      required url,
      bool showLoader = true,
      bool headerWithToken = true}) async {
    if (isLogPrint) {
      log("API :- $url");
      log("PARAMS :- ${body.toString()}");
    }
    isLoading.value = true;
    if (showLoader) {
      ProgressDialogUtils.showProgressDialog(isCancellable: false);
    }
    await initApiService();

    final response = await post(
      url,
      body,
      headers: headerWithToken ? headersWithToken : headers,
      contentType: contentType,
    );
    if (isLogPrint) {
      print("STATUSCODE :- ${response.statusCode}");
      print("RESPONSE :- ${response.body}");
    }
    if (response.status.hasError) {
      isLoading.value = false;
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    } else {
      isLoading.value = false;
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    }
  }

  Future<Response> callGetApi(
      {required url,
      bool showLoader = true,
      bool headerWithToken = true}) async {
    if (isLogPrint) {
      log("API :- $url");
      log("API :- ${isLogPrint.toString()}");
    }

    if (showLoader) {
      ProgressDialogUtils.showProgressDialog(isCancellable: false);
    }
    await initApiService();

    final response = await get(
      url,
      headers: headerWithToken ? headersWithToken : headers,
      contentType: contentType,
    );
    if (isLogPrint) {
      log("RESPONSE :- ${response.body}");
    }

    if (response.status.hasError) {
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    } else {
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    }
  }

  Future<FormData> getBlankApiBody() async {
    final form = FormData({});
    return form;
  }
}
