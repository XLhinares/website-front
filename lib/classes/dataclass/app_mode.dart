import "package:flutter/material.dart";
import "package:get/get.dart";
import "dataclass.dart";

import "../../utils/utils.dart";

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

  /// The unique [AppMode.blogs].
  static const AppMode blogs = AppMode._internal(
    "blogs",
    icon: Icons.dashboard,
  );

  /// The unique [AppMode.contact].
  static const AppMode contact = AppMode._internal(
    "contact",
    icon: Icons.contact_mail,
  );

  /// The unique [AppMode.settings].
  static const AppMode settings = AppMode._internal(
    "settings",
    icon: Icons.settings,
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
    blogs,
    projects,
    contact,
    legal,
    settings,
    other,
  ];

  /// The main tabs of the app.
  static const mainTabs = [
    home,
    blogs,
    projects,
    contact,
    settings,
  ];

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  /// An icon to matching the mode.
  final IconData? _icon;

  /// The permission level required to access this mode.
  final PermissionLevel permissionLevel = PermissionLevel.all;

  // GETTERS ===================================================================

  /// A short description of the mode.
  String get description => "About $name".tr;

  /// An icon matching the mode.
  IconData get icon => _icon ?? Icons.not_interested;

  /// Whether this AppMode is part of the main tabs.
  bool get isMainTab => mainTabs.contains(this);

  /// Whether the user is allowed to access this mode.
  bool get isAccessibleToUser =>
      permissionLevel == PermissionLevel.all ||
      permissionLevel == PermissionLevel.userOnly && user.isConnected ||
      permissionLevel == PermissionLevel.adminOnly && user.isAdmin;

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
