import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";

/// A service that handles all the API requests.
class APIService extends GetConnect {

  // CONSTRUCTOR ===============================================================

  // @override
  // void onInit() {
  //   // httpClient.defaultDecoder = Item.itemsFromJson;
  //   // httpClient.baseUrl = Config.apiEndpoint;
  //   // httpClient.timeout = const Duration(seconds: 5);
  // }

  // METHODS ===================================================================

  /// A request to test the connection to the API.
  Future<void> test (BuildContext? context) async {

    TextStyle? titleStyle = context == null ? null : PresetStyle.headline.getStyle(context);
    TextStyle? messageStyle = context == null ? null : PresetStyle.body.getStyle(context);
    Color color = context?.theme.colorScheme.background ?? Colors.black12;

    try {

      String uri = "https://catfact.ninja/fact";

      Response r = await get(uri);
      printInfo(info: r.body);

      XSnackbar.text(
        title: "Test success".tr,
        message: "${"Test success message".tr}\n\n${r.body}",
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        color: color,
      ).show();

    } catch (e) {
      printError(info: e.toString());


      XSnackbar.text(
        title: "Test failure".tr,
        message: "Test failure message".tr,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        color: color,
      ).show();
      rethrow;
    }
  }

// EXAMPLES ==================================================================

// // Post request with File
// Future<Response<CasesModel>> postCases(List<int> image) {
//   final form = FormData({
//     "file": MultipartFile(image, filename: "avatar.png"),
//     "otherFile": MultipartFile(image, filename: "cover.png"),
//   });
//   return post("http://youapi/users/upload", form);
// }

// GetSocket userMessages() {
//   return socket('https://yourapi/users/socket');
// }

}

