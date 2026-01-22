import "dart:async";

import "package:get/get.dart";

import "../classes/dataclass/user_data.dart";
import "../globals.dart";
import "app_manager_plugin.dart";

import "../../utils/tools.dart";

/// A class handling the authentication of the user.
class AuthenticationPlugin extends AppManagerPlugin {
  // CONSTANTS =================================================================

  @override
  Future<void> load({SuccessCallback? then}) async {
    data = const UserData();
    communicatingWithServer = false.obs;
    tokenRefreshTimer = null;

    ever(communicatingWithServer, (callback) => update());

    if (app.cookies.email.value.isNotEmpty &&
        app.cookies.token.value.isNotEmpty) {
      data = UserData(
          email: app.cookies.email.value, token: app.cookies.token.value);
      _refreshToken();
    }
    return await super.load(then: then);
  }
// VARIABLES =================================================================

  /// The connection data of the user.
  late UserData data;

  /// Whether the app is currently communicating with the server.
  late RxBool communicatingWithServer;

  /// A timer that can periodically refresh the token if the user stays connected for too long.
  late Timer? tokenRefreshTimer;

  // GETTERS ===================================================================

  /// Whether a user is currently connected.
  bool get isConnected => data.token != null;

  /// Whether a user is currently connected.
  bool get isAdmin => data.isAdmin;

  // CONSTRUCTOR ===============================================================

  /// Instantiates the late fields of the trackable mixin.
  void instantiateConnection() {}

  /// Initializes the people mixin.
  Future<bool> initializeConnection() => tryWrapper(
        () async {
          // The initialization logic goes here.
          return true;
        },
        errorMessage: "Could not initialize the connection mixin.",
      );

  /// All the tasks that should be run after the app was loaded.
  Future<void> postInitConnection() async {}

  // METHODS ===================================================================

  /// Attempts to sign the user up through the API.
  Future<String?> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    communicatingWithServer.value = true;

    final errorMessage = await app.network.signUp(
      username: username,
      email: email,
      password: password,
    );

    communicatingWithServer.value = false;

    return errorMessage;
  }

  /// Attempts to log the user in through the API.
  Future<void> logIn({
    required String email,
    required String password,
  }) async =>
      tryWrapper(
        () async {
          communicatingWithServer.value = true;

          data = await app.network.logIn(email: email, password: password);
          app.cookies.email.value = data.email ?? "";
          app.cookies.token.value = data.token ?? "";

          communicatingWithServer.value = false;
        },
        then: (success) {
          if (success) _setTokenRefreshTimer();
        },
      );

  /// Disconnects the user from the API.
  ///
  /// Only the email address is kept to make logging in again easier.
  Future<void> disconnect() async {
    app.cookies.email.value = data.email ?? "";
    app.cookies.token.value = "";
    data = UserData(email: data.email);
    update();
  }

  /// Attempts to refresh the token.
  Future<void> _refreshToken() async {
    communicatingWithServer.value = true;

    data = await app.network.refreshToken(
      email: data.email ?? "",
      token: data.token ?? "",
    );
    app.cookies.email.value = data.email ?? "";
    app.cookies.token.value = data.token ?? "";

    communicatingWithServer.value = false;
  }

  void _unsetTokenRefreshTimer() {
    if (tokenRefreshTimer == null) return;

    tokenRefreshTimer!.cancel();
    tokenRefreshTimer = null;
  }

  void _setTokenRefreshTimer() {
    _unsetTokenRefreshTimer();
    // The token expires after 30 minutes so we try to refresh it after 28.
    tokenRefreshTimer = Timer(const Duration(minutes: 28), _refreshToken);
  }
}
