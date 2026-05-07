// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../pages/legal/cookie_policy.dart";
import "../../pages/legal/legal_mentions.dart";
import "../../pages/legal/privacy_policy.dart";
import "../../pages/page_contact.dart";
import "../../pages/responsive_home.dart";
import "../../pages/responsive_people.dart";
import "../../pages/responsive_projects.dart";

/// A custom route data-class.
class AppRoute {
  // VARIABLES =================================================================

  /// The name of the route, it is used for displays and does not need to be unique.
  final String name;

  /// The path of the route, it should be unique.
  final String path;

  /// An icon to matching the mode.
  final IconData? _icon;

  /// The list of elements in the path.
  late final List<String> parts;

  /// An optional builder to tell the app the building logic of the path.
  ///
  /// If null, the route will lead to the home tab.
  late final Widget Function()? builder;

  // CONSTANTS =================================================================
  // ignore_for_file: non_constant_identifier_names

  /// Route to the root tab of the app.
  static final ROOT = AppRoute("/", builder: () => const ResponsiveHome());

  /// The root of the routes that are part of the main page.
  static const String ROOT_MAIN = "main";

  /// The root of the routes that are part of the "Projects" page.
  static const String ROOT_PROJECTS = "projects";

  /// The root of the routes that are part of the "People" page.
  static const String ROOT_PEOPLE = "people";

  /// The root of the routes that are part of the "Contact" page.
  static const String ROOT_CONTACT = "contact";

  /// The root of the routes that are part of the "Legal" pages.
  static const String ROOT_LEGAL = "legal";

  /// The root of the routes that not part of any page.
  static const String ROOT_OTHER = "other";

  /// Route to the home tab of the app.
  static final MAIN_HOME = AppRoute(
    "/$ROOT_MAIN",
    name: "home",
    icon: Icons.home,
    builder: () => ResponsiveHome(),
  );

  /// Route to the projects tab of the app.
  static final MAIN_PROJECTS = AppRoute(
    "/$ROOT_MAIN/projects",
    name: "projects",
    icon: Icons.gesture,
    builder: () => ResponsiveHome(),
  );

  /// Route to the contacts tab of the app.
  static final MAIN_PEOPLE = AppRoute(
    "/$ROOT_MAIN/people",
    name: "people",
    icon: Icons.people,
    builder: () => ResponsiveHome(),
  );

  /// Route to the settings tab of the app.
  static final MAIN_SETTINGS = AppRoute(
    "/$ROOT_MAIN/settings",
    name: "settings",
    icon: Icons.settings,
    builder: () => ResponsiveHome(),
  );

  /// Route to the projects page of the app.
  static final PAGE_PROJECTS = AppRoute(
    "/$ROOT_PROJECTS",
    name: "projects",
    icon: Icons.gesture,
    builder: () => ResponsiveProject(),
  );

  /// Route to the people page of the app.
  static final PAGE_PEOPLE = AppRoute(
    "/$ROOT_PEOPLE",
    name: "people",
    icon: Icons.gesture,
    builder: () => PagePeople(),
  );

  /// Route to the contact page of the app.
  static final PAGE_CONTACT = AppRoute(
    "/$ROOT_CONTACT",
    name: "contact",
    icon: Icons.gesture,
    builder: () => PageContact(),
  );

  /// Route to the cookie legal page of the app.
  static final LEGAL_COOKIES = AppRoute(
    "/$ROOT_LEGAL/cookie_policy",
    name: "cookies",
    icon: Icons.balance,
    builder: () => const CookiePolicy(),
  );

  /// Route to the privacy legal page of the app.
  static final LEGAL_PRIVACY = AppRoute(
    "/$ROOT_LEGAL/privacy_policy",
    name: "privacy",
    icon: Icons.balance,
    builder: () => const PrivacyPolicy(),
  );

  /// Route to the legal mentions page of the app.
  static final LEGAL_MENTIONS = AppRoute(
    "/$ROOT_LEGAL/legal_mentions",
    name: "legal",
    icon: Icons.balance,
    builder: () => const LegalMentions(),
  );

  /// Route to the "not found" page of the app.
  static final NOT_FOUND = AppRoute(
    "/$ROOT_OTHER/not_found",
    name: "not_found",
    builder: () => ResponsiveHome(
      postInit: (context) => XDialog.text(
        title: "Resource not found.",
      ),
    ),
  );

  /// All the handled [CustomRoutes].
  ///
  /// These values are used to make the [Get] package create the routes.
  static final values = [
    AppRoute.ROOT,
    AppRoute.MAIN_HOME,
    AppRoute.MAIN_PROJECTS,
    AppRoute.MAIN_PEOPLE,
    AppRoute.MAIN_SETTINGS,
    AppRoute.PAGE_PROJECTS,
    AppRoute.PAGE_PEOPLE,
    AppRoute.PAGE_CONTACT,
    AppRoute.LEGAL_COOKIES,
    AppRoute.LEGAL_PRIVACY,
    AppRoute.LEGAL_MENTIONS,
    AppRoute.NOT_FOUND,
  ];

  /// The routes belonging to the main page of the website.
  static final mainRoutes = [
    MAIN_HOME,
    MAIN_PROJECTS,
    MAIN_PEOPLE,
    MAIN_SETTINGS,
  ];

  // GETTERS ===================================================================

  /// Whether this route is accessible to the current user.
  bool get isAccessibleToUser => true;

  /// The root of the route.
  ///
  /// Possible values include:
  /// - "main",
  /// - "projects",
  /// - "legal"
  /// - "not_found".
  String get root => parts[1];

  /// Whether this route is part of the main page.
  bool get isPartOfMain => root == ROOT_MAIN;

  /// Whether this route is part of the projects page.
  bool get isPartOfProjects => root == ROOT_PROJECTS;

  /// Whether this route is part of the people page.
  bool get isPartOfPeople => root == ROOT_PEOPLE;

  /// An icon matching the mode.
  IconData get icon => _icon ?? Icons.not_interested;

  /// A [GetPage] matching this route.
  ///
  /// This is used by the [Get] package during the initialization of the app.
  GetPage get page => GetPage(
        name: path,
        page: builder ?? () => const ResponsiveHome(),
      );

  /// Returns the ID of the project in the route.
  ///
  /// Returns [null] if there are no projects in the route.
  int? get projectID {
    final int indexBefore = parts.indexOf("projects");
    if (indexBefore == -1) return null;
    if (parts.length == indexBefore + 1) return null;
    return int.tryParse(parts[indexBefore + 1]);
  }

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AppRoute] matching the given parameters.
  AppRoute(
    this.path, {
    Widget Function()? builder,
    String? name,
    IconData? icon,
  })  : name = name ?? path,
        _icon = icon {
    parts = path.split("/");
    this.builder = builder ??
        () => ResponsiveHome(
              postInit: (context) => router.goTo(AppRoute.parse(path)),
            );
    // mode = AppMode.parse(parts.isEmpty ? "" : parts[1]);
  }

  /// Tries to match a default route to the given parameters and return it.
  ///
  /// If there are no match, creates and return a new route.
  factory AppRoute.parse(String? path) {
    assert(path != null, "[path] cannot both be null.");

    final newRoute = values.firstWhereOrNull((r) => r.path == path);

    if (newRoute != null) return newRoute;
    return NOT_FOUND;
  }

  /// Returns a [AppRoute] linking to the given project.
  factory AppRoute.parseMainProject(int? id) => id == null
      ? AppRoute.MAIN_PROJECTS
      : AppRoute(
          "/$ROOT_MAIN/projects/$id",
          builder: () => ResponsiveHome(
            postInit: (_) {
              router.goTo(AppRoute.parse("/$ROOT_MAIN/projects/$id"));
              // router.selectProject(id);
            },
          ),
        );

  /// Returns a [AppRoute] linking to the given project.
  factory AppRoute.parsePageProject(int? id) => id == null
      ? AppRoute.PAGE_PROJECTS
      : AppRoute(
          "/$ROOT_PROJECTS/$id",
          builder: () => ResponsiveProject(
            postInit: (_) {
              router.goTo(AppRoute.parse("/$ROOT_PROJECTS/$id"));
              // router.selectProject(id);
            },
          ),
        );

  // METHODS ===================================================================

  /// Whether this route shares its root with the route given as argument.
  bool sharesRootWith(AppRoute other) => root == other.root;

  @override
  String toString() => path;
}
