import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../utils/tools.dart";
import "../../utils/tools_api.dart";
import "../../widgets/widgets.dart";
import "../dataclass/project_preview.dart";

/// A service that handles all the API requests.
class APIService extends GetConnect {

  // VARIABLES =================================================================

  /// The URI prefix to reach the the API.
  final String api = "https://api.xeppelin.org/";

  /// The URI prefix to reach the the assets.
  final String assets = "https://assets.xeppelin.org/";

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [APIService].
  APIService () {
    printInfo(info: "API Service initialized.");
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
    TextStyle? contentStyle = context == null ? null : PresetStyle.body.getStyle(context);
    Color color = context?.theme.colorScheme.background ?? Colors.black12;

    try {

      const String uri = "https://catfact.ninja/fact";
      final Response response = await get(uri);

      XSnackbar.text(
        title: "$versionNumber - ${"Test success".tr}",
        content: "${"Test success message".tr}\n\n${response.body}",
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        color: color,
      ).show(context!);

    } catch (e) {
      printError(info: "\n$e");


      XSnackbar.text(
        title: "Test failure".tr,
        content: "Test failure message".tr,
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        color: color,
      ).show(context!);
      rethrow;
    }
  }

  /// Retrieves a list of projects from the api.
  Future<List<ProjectPreview>> getProjects ({int limit = -1}) async
  => tryWrapper<List<ProjectPreview>>(() async {

        final response = await fetchJson((CustomURL(initialText: api)
          ..addPath("projects")
          ..addFile("all")
          ..addCustomParameter(name: "limit", value: limit))
            .clean);

        printInfo(info: response[0].toString());

        return response.map((e) => ProjectPreview.fromJson(e)).toList();
      });


  /// Sends a mail to the support.
  Future<bool> sendSupportMail ({
    required String name,
    required String email,
    required String subject,
    required String details,
  }) => tryWrapper(() async {

    String body = json.encode({
      "name": name,
      "email": email,
      "subject": subject,
      "details": details,
    });

    Response response = await post("$api/mail/support",
      body,
      headers: {},
    );
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

