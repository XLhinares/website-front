import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/tools.dart";
import "../../widgets/widgets.dart";
import "../dataclass/project_preview.dart";

/// A service that handles all the API requests.
class APIService extends GetConnect {

  // VARIABLES =================================================================

  /// The URI prefix to reach the the host.
  late final String _baseUrl;

  // GETTERS ===================================================================


  /// The URI prefix to reach the the API.
  String get api => "$_baseUrl/api";

  /// The URI prefix to reach the the assets.
  String get assets => "https://www.xeppelin.org/assets";

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [APIService].
  APIService () {
    if (kDebugMode) {
      _baseUrl = "http://localhost:3000";
    } else {
      _baseUrl = "https://www.xeppelin.org";
    }
  }

  // @override
  // void onInit() {
  //   // httpClient.defaultDecoder = Item.itemsFromJson;
  //   // httpClient.baseUrl = "https://www.xeppelin.org/api/";
  //   // httpClient.timeout = const Duration(seconds: 5);
  // }

  // METHODS ===================================================================

  /// A request to test the connection to the API.
  Future<void> test (BuildContext? context) async {

    TextStyle? titleStyle = context == null ? null : PresetStyle.headline.getStyle(context);
    TextStyle? messageStyle = context == null ? null : PresetStyle.body.getStyle(context);
    Color color = context?.theme.colorScheme.background ?? Colors.black12;


    try {

      const String uri = "https://catfact.ninja/fact";
      final Response response = await get(uri);

      XSnackbar.text(
        title: "Test success".tr,
        message: "${"Test success message".tr}\n\n${response.body}",
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        color: color,
      ).show();

    } catch (e) {
      printError(info: "\n$e");


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

  /// Retrieves a list of projects from the api.
  Future<List<ProjectPreview>> getProjects ({int limit = -1}) async
  => tryWrapper<List<ProjectPreview>>(() async {

    final response = await get("http://localhost:3000/api/projects/all?limit=$limit");
    printInfo(info: "CODE: ${response.statusCode}");
    printInfo(info: "BODY: ${response.body as List}");

    List<Map<String, dynamic>> parsedResponse = List<Map<String, dynamic>>.from(response.body);

    printInfo(info: parsedResponse[0].toString());

    return parsedResponse.map((e) => ProjectPreview.fromJson(e)).toList();
  });


  /// Sends a mail to the support.
  Future<bool> sendSupportMail ({
    required String name,
    required String email,
    required String subject,
    required String details,
  }) => tryWrapper(() async {

    Map<String, String> body = {
      "name": name,
      "email": email,
      "subject": subject,
      "details": details,
    };

    Response response = await post("$api/mail/support", body);
    printInfo(info: "$api/mail/support");
    printInfo(info: response.statusCode.toString());
    return response.statusCode == 200;
  });

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

