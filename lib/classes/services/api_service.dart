import "dart:collection";
import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../utils/tools.dart";
import "../../utils/tools_api.dart";
import "../dataclass/project_preview.dart";

/// A service that handles all the API requests.
class APIService extends GetConnect {
  // VARIABLES =================================================================

  /// The URI prefix to reach the the API.
  late final String api;

  /// The URI prefix to reach the the assets.
  late final String assets;

  late final List<ProjectPreview> _projects;

  // GETTERS ===================================================================

  /// A list of the registered trackable metadata.
  UnmodifiableListView<ProjectPreview> get lastTracked =>
      UnmodifiableListView(_projects);

  // CONSTRUCTOR ===============================================================

  /// The instantiation logic of [APIService].
  APIService._internal() {
    api = "https://api.xeppelin.org/";
    assets = "https://assets.xeppelin.org/";
    _projects = [];

    printInfo(info: "API Service initialized.");
  }

  /// The actual instance of [APIService].
  static final APIService _instance = APIService._internal();

  /// Returns the [APIService] singleton.
  factory APIService() => _instance;

  // METHODS ===================================================================

  /// A request to test the connection to the API.
  Future<void> test(BuildContext? context) async {
    TextStyle? titleStyle = context?.textTheme.titleMedium;
    TextStyle? contentStyle = context?.textTheme.bodyMedium;
    Color color = context?.theme.colorScheme.background ?? Colors.black12;

    try {
      const String uri = "https://catfact.ninja/fact";
      final response = await fetchJson(uri, subsetPicker: (e) => [e]);

      XSnackbar.text(
        title: "$versionNumber - ${"Test success".tr}",
        content: "${"Test success message".tr}\n\n${response[0]["fact"]}",
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        color: color,
        duration: const Duration(seconds: 7),
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
  Future<List<ProjectPreview>> getProjects({int page = 0}) async =>
      tryWrapper<List<ProjectPreview>>(() async {
        final response = await fetchJson((CustomURL(initialText: api)
              ..addPath("projects")
              ..addFile("all")
              ..addCustomParameter(name: "page", value: page)
              ..addCustomParameter(name: "sorter", value: page))
            .clean);

        printInfo(info: response[0].toString());

        return response.map((e) => ProjectPreview.fromJson(e)).toList();
      });

  /// Sends a mail to the support.
  Future<bool> sendSupportMail({
    required String name,
    required String email,
    required String subject,
    required String details,
  }) =>
      tryWrapper(() async {
        String body = json.encode({
          "name": name,
          "email": email,
          "subject": subject,
          "details": details,
        });

        final url = (CustomURL(initialText: api)
        ..addPath("mail")
        ..addFile("support"))
        .clean;

        Response response = await post(
          url,
          body,
        );
        printInfo(info: "Sending mail to support at: $url");
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
