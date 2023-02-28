import "dart:async";

import "package:get/get.dart";

import "../../utils/utils.dart";
import "../dataclass/dataclass.dart";
import "user_core.dart";

/// A mixin that implements the connection methods in the user class.
mixin UserConnection on UserCore {
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
  void instantiateConnection() {
    data = const UserData();
    communicatingWithServer = false.obs;
    tokenRefreshTimer = null;

    ever(communicatingWithServer, (callback) => update());
  }

  /// Initializes the people mixin.
  Future<bool> initializeConnection() => tryWrapper(
        () async {
          // The initialization logic goes here.
          return true;
        },
        errorMessage: "Could not initialize the connection mixin.",
      );

  /// All the tasks that should be run after the app was loaded.
  Future<void> postInitConnection() async {
    if (settings.email.isNotEmpty && settings.token.isNotEmpty) {
      data = UserData(email: settings.email.value, token: settings.token.value);
      _refreshToken();
    }
  }

  // METHODS ===================================================================

  /// Attempts to sign the user up through the API.
  Future<String?> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    communicatingWithServer.value = true;

    final errorMessage = await api.signUp(
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

          data = await api.logIn(email: email, password: password);
          settings.email.value = data.email ?? "";
          settings.token.value = data.token ?? "";

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
    settings.email.value = data.email ?? "";
    settings.token.value = "";
    data = UserData(email: data.email);
    update();
  }

  /// Attempts to refresh the token.
  Future<void> _refreshToken() async {
    communicatingWithServer.value = true;

    data = await api.refreshToken(
      email: data.email ?? "",
      token: data.token ?? "",
    );
    settings.email.value = data.email ?? "";
    settings.token.value = data.token ?? "";

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
