import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

/// Representation of a "mode" (pretty much the top-level state of the app).
class AppMode {

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  // GETTERS ===================================================================

  /// A short description of the mode.
  String get description => "About $name";

  /// An icon matching the mode.
  Widget get icon {

    late final IconData icon;

    if (this == AppMode.home) icon = Icons.home;
    if (this == AppMode.projects) icon = Icons.gesture;
    if (this == AppMode.contact) icon = Icons.contact_mail;

    return Icon(icon,
      size: XLayout.paddingL,
    );
  }

  // CONSTRUCTOR ===============================================================

  /// The unique [AppMode.home].
  static const AppMode home = AppMode._internal("home");

  /// The unique [AppMode.projects].
  static const AppMode projects = AppMode._internal("projects");

  /// The unique [AppMode.contact].
  static const AppMode contact = AppMode._internal("contact");

  const AppMode._internal(this.name);

  /// Returns an AppMode instance according to the mode's name.
  factory AppMode.fromName(String name) {
    switch (name) {
      case "home":
        return AppMode.home;
      case "projects":
        return AppMode.projects;
      case "contact":
        return AppMode.contact;
      default:
        throw Exception("App mode '$name' doesn't exist.");
    }
  }

}
