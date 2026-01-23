import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart";

import "../../utils/tools.dart";
import "../classes/dataclass/user_data.dart";
import "../classes/medias/media.dart";
import "../classes/medias/media_content.dart";
import "../classes/medias/media_type.dart";
import "../globals.dart";
import "../utils/tools_api.dart";
import "app_manager_plugin.dart";

/// A service that handles all the API requests.
class NetworkPlugin extends AppManagerPlugin {
  // VARIABLES =================================================================

  /// The URI prefix to reach the game API.
  late final String api;

  /// The URI prefix to reach the xeppelin API.
  late final String assets;

  // CONSTRUCTOR ===============================================================

  /// The instantiation logic of [NetworkPlugin].
  NetworkPlugin._internal() {
    api = "https://api.xeppelin.org/";
    assets = "https://assets.xeppelin.org/";
  }

  /// The actual instance of [NetworkPlugin].
  static final NetworkPlugin _instance = NetworkPlugin._internal();

  /// Returns the [NetworkPlugin] singleton.
  factory NetworkPlugin() => _instance;

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

          dlog("Fetching JSON from: [$url]");
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

          dlog("Fetching file resource from: '$url'");
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

        dlog(response.body.toString());

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

        dlog(response.body.toString());

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
          headers: {"Authorization": "Bearer ${app.authentication.data.token}"},
        );

        dlog(response.body.toString());

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

        // dlog(response[0].toString());

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
        dlog("Sending mail to support at: $url");
        dlog(response.statusCode.toString());
        return response.statusCode == 200;
      });

  /// Fetches an asset from the legal folder and return the content as a string.
  Future<String> getLegal(String source) async {
    final http.Response response = await http.get(
      (CustomURL(initialText: assets)
            ..addPath("legal")
            ..addFile("${source}_${app.cookies.locale.value}.md"))
          .cleanUri,
    );

    return utf8.decode(response.bodyBytes);
  }

  // OPEN EXTERNAL SITES

  /// Launch the given URL in a new tab.
  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? "_blank" : "_self",
    );
  }

  /// Open a new tab with my linkedin account.
  Future<void> openLinkedIn() async =>
      launch("https://www.linkedin.com/in/xavier-lhinares/");

  /// Open a new tab with my github account.
  Future<void> openGitHub() async => launch("https://github.com/XLhinares/");

  /// Open a new tab with my resume.
  Future<void> openResume() async =>
      launch("https://assets.xeppelin.org/other/XAVIER-LHINARES-CV.pdf");

  // EXAMPLES ==================================================================
}
