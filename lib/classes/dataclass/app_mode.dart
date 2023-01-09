import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// Representation of a "mode" (pretty much the top-level state of the app).
class AppMode {
  // CONSTANTS =================================================================

  /// The unique [AppMode.home].
  static const AppMode home = AppMode._internal(
    "home",
    icon: Icons.home,
  );

  /// The unique [AppMode.projects].
  static const AppMode projects = AppMode._internal(
    "projects",
    icon: Icons.gesture,
  );

  /// The unique [AppMode.blog].
  static const AppMode blog = AppMode._internal(
    "blog",
    icon: Icons.dashboard,
  );

  /// The unique [AppMode.contact].
  static const AppMode contact = AppMode._internal(
    "contact",
    icon: Icons.contact_mail,
  );

  /// The unique [AppMode.legal].
  static const AppMode legal = AppMode._internal(
    "legal",
    icon: Icons.balance,
  );

  /// The unique [AppMode.other].
  static const AppMode other = AppMode._internal(
    "other",
  );

  /// The different possible values of [AppMode].
  static const values = [
    home,
    blog,
    projects,
    contact,
    legal,
    other,
  ];

  /// The main tabs of the app.
  static const mainTabs = [
    home,
    // blog,
    projects,
    contact,
  ];

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  /// An icon to matching the mode.
  final IconData? _icon;

  // GETTERS ===================================================================

  /// A short description of the mode.
  String get description => "About $name".tr;

  /// An icon matching the mode.
  Widget get icon {
    return Icon(
      _icon ?? Icons.not_interested,
      size: XLayout.paddingL,
    );
  }

  /// Whether this AppMode is part of the main tabs.
  bool get isMainTab => mainTabs.contains(this);

  // CONSTRUCTOR ===============================================================

  const AppMode._internal(
    this.name, {
    IconData? icon,
  }) : _icon = icon;

  /// Returns an AppMode instance according to the mode's name.
  factory AppMode.parse(String name) {
    for (final mode in values) {
      if (mode.name == name.toLowerCase()) return mode;
    }
    return other;
  }
}
