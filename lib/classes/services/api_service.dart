// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";

// Package dependencies
import "package:x_containers/x_containers.dart";

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
    try {

      String uri = "https://catfact.ninja/fact";

      Response r = await get(uri);
      printInfo(info: r.body);

      XSnackbar.text(
        title: "It worked!",
        message: "Have a cat fact:\n\n${r.body}",
        color: context?.theme.colorScheme.background ?? Colors.black12,
      ).show();

    } catch (e) {
      printError(info: e.toString());


      XSnackbar.text(
        title: "It failed :/",
        message: "Mucho triste...",
        color: context?.theme.colorScheme.background ?? Colors.black12,
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

