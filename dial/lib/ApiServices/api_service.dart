import 'dart:developer';

import 'package:get/get.dart';

import '../core/utils/app_prefs_key.dart';
import '../core/utils/common_function.dart';
import '../core/utils/pref_utils.dart';
import '../core/utils/progress_dialog_utils.dart';
import 'network_info.dart';

RxBool isLoading = false.obs;

class ApiService extends GetConnect {
  ApiService() {
    timeout = const Duration(seconds: 120);
  }
  var headers;
  var headersWithToken;
  var headersWithBranchToken;
  var contentType;
  String authToken = '';

  Future<void> getToken() async {}

  Future<void> initApiService() async {
    await NetworkInfo.checkNetwork().whenComplete(() async {
      authToken = await PrefUtils.getString(PrefsKey.authToken);
      print("Auth Token from API service is :- $authToken");
      headers = {"content-type": "application/json"};
      headersWithBranchToken = {
        "content-type": "application/json",
        "Branch": "1641133a-1e9d-4544-2021-08dc1c05945f",
        "Authorization": "Bearer" + " " + "$authToken"
      };
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
      bool isBranch = false,
      bool headerWithToken = true}) async {
    if (isLogPrint) {
      log("API :- $url");
      log("HEADER :- ${headerWithToken ? isBranch ? headersWithBranchToken.toString() : headersWithToken.toString() : headers.toString()}");
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
      headers: headerWithToken
          ? isBranch
              ? headersWithBranchToken
              : headersWithToken
          : headers,
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
    isLoading.value = true;

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
    isLoading.value = false;

    if (isLogPrint) {
      log("RESPONSE :- ${response.body}");
    }

    if (response.status.hasError) {
      isLoading.value = false;

      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    } else {
      if (showLoader) {
        isLoading.value = false;

        ProgressDialogUtils.hideProgressDialog();
      }
      return response;
    }
  }

  Future<Response> callDeleteApi(
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

    final response = await delete(
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

  Future<Response> callPutApi(
      {required url,
      required body,
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

    final response = await put(
      url,
      body,
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
