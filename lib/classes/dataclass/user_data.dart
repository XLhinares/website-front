/// A dataclass handling the connection data of the user.
class UserData {
  // VARIABLES =================================================================

  /// The name of the user.
  final String? name;

  /// The email address used to log in.
  final String? email;

  /// The connection token.
  final String? token;

  /// Whether the user is an admin.
  final bool isAdmin;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [UserData] matching the given parameters.
  const UserData({
    this.name,
    this.email,
    this.token,
    this.isAdmin = false,
  });

  /// Factory-instantiate the [UserData] from a json-like object.
  factory UserData.fromJson(Map<String, dynamic> source) => UserData(
        name: source["name"],
        email: source["email"],
        token: source["token"],
        isAdmin: source["admin"] == 1,
      );
}
