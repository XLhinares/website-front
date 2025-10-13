// ignore_for_file: use_build_context_synchronously

import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../utils/tools.dart";
import "../../utils/tools_api.dart";
import "../dataclass/dataclass.dart";
import "../medias/medias.dart";

/// A service that handles all the API requests.
class APIService {
  // VARIABLES =================================================================

  /// The URI prefix to reach the the API.
  late final String api;

  /// The URI prefix to reach the the assets.
  late final String assets;

  // CONSTRUCTOR ===============================================================

  /// The instantiation logic of [APIService].
  APIService._internal() {
    api = "https://api.xeppelin.org/";
    assets = "https://assets.xeppelin.org/";

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

  /// Fetches a text file object from the given URL.
  ///
  /// Parameters:
  /// * url: The path to the resource; cannot be null.
  Future<String> fetchFile(Uri? url) async => tryWrapper<String>(
        () async {
          assert(url != null, "URL cannot be [null].");

          printInfo(info: "Fetching file resource from: '$url'");
          final http.Response response = await http.get(url!);

          if (response.statusCode < 200 || response.statusCode >= 400) {
            throw HttpException(
                "Response status code is ${response.statusCode}");
          }

          final data = response.body;

          return data;
        },
        errorMessage: "Fetching the file object from [$url] failed.",
      );

  /// A request to test the connection to the API.
  Future<void> test(BuildContext? context) async {
    TextStyle? titleStyle = context?.textTheme.titleMedium;
    TextStyle? contentStyle = context?.textTheme.bodyMedium;
    Color color = context?.theme.colorScheme.surface ?? Colors.black12;

    try {
      final uri = Uri.parse("https://catfact.ninja/fact");
      final response = await fetchJson(uri, subsetPicker: (e) => [e]);

      XSnackbar.text(
        title: "$versionNumber - ${"test_card_snackbar_success_title".tr}",
        content: "test_card_snackbar_success_content"
            .trParams({"fact": response[0]["fact"]}),
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        color: color,
        duration: const Duration(seconds: 10),
      ).show(context!);
    } catch (e) {
      printError(info: "\n$e");

      XSnackbar.text(
        title: "test_card_snackbar_failure_title".tr,
        content: "test_card_snackbar_failure_content".tr,
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        color: color,
      ).show(context!);
      rethrow;
    }
  }

  /// Attempts to log the user in on the API.
  Future<UserData> logIn({
    required String email,
    required String password,
  }) async =>
      tryWrapper(() async {
        final response = await http.post(
            (CustomURL(initialText: api)
                  ..addPath("account")
                  ..addFile("login"))
                .cleanUri,
            body: {
              "email": email,
              "password": password,
            });

        printInfo(info: response.body.toString());

        return UserData.fromJson(jsonDecode(response.body));
      });

  /// Attempts to sign the user up on the API.
  ///
  /// If the request is successful, we return [null];
  /// otherwise, the error message is returned.
  Future<String?> signUp({
    required String username,
    required String email,
    required String password,
  }) async =>
      tryWrapper(() async {
        final response = await http.post(
            (CustomURL(initialText: api)
                  ..addPath("account")
                  ..addFile("signUp"))
                .cleanUri,
            body: {
              "username": username,
              "email": email,
              "password": password,
            });

        printInfo(info: response.body.toString());

        if (response.statusCode == 200) return null;
        if (response.statusCode == 401) return "The user already exists.";
        return "There was an error, please try again later.";
      });

  /// Attempts to refresh the token from the API.
  Future<UserData> refreshToken({
    required String email,
    required String token,
  }) async =>
      tryWrapper(() async {
        final response = await http.post(
          (CustomURL(initialText: api)
                ..addPath("account")
                ..addFile("refresh"))
              .cleanUri,
          body: {
            "email": email,
            "token": token,
          },
          headers: {"Authorization": "Bearer ${user.data.token}"},
        );

        printInfo(info: response.body.toString());

        return UserData.fromJson(jsonDecode(response.body));
      });

  /// Retrieves a list of medias from the api.
  Future<List<T>> getMedias<T extends Media>({
    int page = 0,
    APISorter sorter = APISorter.relevance,
  }) async =>
      tryWrapper<List<T>>(() async {
        final response = await fetchJson((CustomURL(initialText: api)
              ..addPath("media")
              ..addFile("all")
              ..addCustomParameter("type", MediaType.fromType(T).name)
              ..addCustomParameter("page", page)
              ..addCustomParameter("sorter", sorter.name))
            .cleanUri);

        printInfo(info: response[0].toString());

        return response.map((e) => Media.fromJson(e) as T).toList();
      });

  /// Retrieves the full information on the project matching the given name.
  Future<MediaContent?> getMediaContent(int id) async => tryWrapper(
        () async {
          final response = await fetchJson((CustomURL(initialText: api)
                ..addPath("media")
                ..addFile(id))
              .cleanUri);

          return MediaContent.fromJson(response);
        },
        errorMessage: "The media $id could not be loaded.",
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

  /// Fetches an asset from the legal folder and return the content as a string.
  Future<String> getLegal(String source) async {
    final http.Response response = await http.get(
      (CustomURL(initialText: assets)
            ..addPath("legal")
            ..addFile("${source}_${cookies.locale.value}.md"))
          .cleanUri,
    );

    return utf8.decode(response.bodyBytes);
  }

// EXAMPLES ==================================================================
}
