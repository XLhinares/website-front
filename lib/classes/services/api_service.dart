// Package dependencies
import "package:get/get.dart";

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
  Future<void> test () async {
    try {

      // String uri = "https://catfact.ninja/fact";
      String uri = "http://localhost:8080/home";

      Response r = await get(uri);
      printInfo(info: r.body);
    } catch (e) {
      printError(info: e.toString());
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

