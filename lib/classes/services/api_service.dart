import "dart:collection";
import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../utils/tools.dart";
import "../../utils/tools_api.dart";
import "../dataclass/project_metadata.dart";

/// A service that handles all the API requests.
class APIService {
  // VARIABLES =================================================================

  /// The URI prefix to reach the the API.
  late final String api;

  /// The URI prefix to reach the the assets.
  late final String assets;

  late final List<ProjectMetadata> _projects;

  // GETTERS ===================================================================

  /// A list of the registered trackable metadata.
  UnmodifiableListView<ProjectMetadata> get lastTracked =>
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
  /// Fetches a JSON object from the given URL.
  ///
  /// Parameters:
  /// * url: The path to the resource; cannot be null.
  /// * dataSubset: a function taking the raw data and returning a subset known
  /// to match the [List<Map<String, dynamic>>] type.
  Future<List<Map<String, dynamic>>> fetchJson(
    Uri? url, {
    dynamic Function(dynamic)? subsetPicker,
  }) async =>
      tryWrapper<List<Map<String, dynamic>>>(
        () async {
          assert(url != null, "URL cannot be [null].");

          printInfo(info: "Fetching JSON resource from: '$url'");
          final http.Response response = await http.get(url!);

          if (response.statusCode < 200 || response.statusCode >= 400) {
            throw HttpException(
                "Response status code is ${response.statusCode}");
          }

          final data = await json.decode(response.body);
          final List<Map<String, dynamic>> parsedResponse =
              List<Map<String, dynamic>>.from(subsetPicker?.call(data) ?? data);

          return parsedResponse;
        },
        errorMessage: "Fetching the JSON object from [$url] failed.",
      );

  /// A request to test the connection to the API.
  Future<void> test(BuildContext? context) async {
    TextStyle? titleStyle = context?.textTheme.titleMedium;
    TextStyle? contentStyle = context?.textTheme.bodyMedium;
    Color color = context?.theme.colorScheme.background ?? Colors.black12;

    try {
      final uri = Uri.parse("https://catfact.ninja/fact");
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
  Future<List<ProjectMetadata>> getProjects(
          {int page = 0, APISorter sorter = APISorter.relevance}) async =>
      tryWrapper<List<ProjectMetadata>>(() async {
        final response = await fetchJson((CustomURL(initialText: api)
              ..addPath("projects")
              ..addFile("all")
              ..addCustomParameter(name: "page", value: page)
              ..addCustomParameter(name: "sorter", value: sorter.name))
            .cleanUri);

        printInfo(info: response[0].toString());

        return response.map((e) => ProjectMetadata.fromJson(e)).toList();
      });

  /// Retrieves the full information on the project matching the given name.
  Future<ProjectMetadata?> getProject(String name) async => tryWrapper(
        () async {
          final response = await fetchJson((CustomURL(initialText: api)
                ..addPath("projects")
                ..addFile(name))
              .cleanUri);

          return ProjectMetadata.fromJson(response.first);
        },
        errorMessage: "The project $name could not be loaded.",
      );

  /// Sends a mail to the support.
  Future<bool> sendSupportMail({
    required String name,
    required String email,
    required String subject,
    required String details,
  }) =>
      tryWrapper(() async {
        final body = {
          "name": name,
          "email": email,
          "subject": subject,
          "details": details,
        };

        final url = (CustomURL(initialText: api)
              ..addPath("mail")
              ..addFile("support"))
            .cleanUri;

        http.Response response = await http.post(
          url,
          body: body,
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
