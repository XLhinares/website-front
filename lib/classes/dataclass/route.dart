// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../pages/legal/cookie_policy.dart";
import "../../pages/legal/legal_mentions.dart";
import "../../pages/legal/privacy_policy.dart";
import "../../pages/responsive_home.dart";
import "../../pages/responsive_projects.dart";
import "../../globals.dart";

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

  /// Route to the home tab of the app.
  static final MAIN_HOME = AppRoute(
    "/$ROOT_MAIN",
    name: "home",
    icon: Icons.home,
    builder: () => ResponsiveHome(),
  );

  /// Route to the blog tab of the app.
  static final MAIN_BLOGS = AppRoute(
    "/$ROOT_MAIN/blogs",
    name: "blogs",
    icon: Icons.dashboard,
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
  static final MAIN_CONTACT = AppRoute(
    "/$ROOT_MAIN/contact",
    name: "contact",
    icon: Icons.contact_mail,
    builder: () => ResponsiveHome(),
  );

  /// Route to the settings tab of the app.
  static final MAIN_SETTINGS = AppRoute(
    "/$ROOT_MAIN/settings",
    name: "settings",
    icon: Icons.settings,
    builder: () => ResponsiveHome(),
  );

  /// Route to the projects tab of the app.
  static final PAGE_PROJECTS = AppRoute(
    "/$ROOT_PROJECTS",
    name: "projects",
    icon: Icons.gesture,
    builder: () => ResponsiveProject(),
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

  /// The root of the routes that are part of the main page.
  static const String ROOT_MAIN = "main";

  /// The root of the routes that are part of the "Projects" page.
  static const String ROOT_PROJECTS = "projects";

  /// The root of the routes that are part of the "Legal" pages.
  static const String ROOT_LEGAL = "legal";

  /// The root of the routes that not part of any page.
  static const String ROOT_OTHER = "other";

  /// All the handled [CustomRoutes].
  ///
  /// These values are used to make the [Get] package create the routes.
  static final values = [
    AppRoute.ROOT,
    AppRoute.MAIN_HOME,
    AppRoute.MAIN_BLOGS,
    AppRoute.MAIN_PROJECTS,
    AppRoute.MAIN_CONTACT,
    AppRoute.MAIN_SETTINGS,
    AppRoute.PAGE_PROJECTS,
    AppRoute.LEGAL_COOKIES,
    AppRoute.LEGAL_PRIVACY,
    AppRoute.LEGAL_MENTIONS,
    AppRoute.NOT_FOUND,
  ];

  /// The routes belonging to the main page of the website.
  static final mainRoutes = [
    MAIN_HOME,
    // MAIN_BLOGS,
    MAIN_PROJECTS,
    MAIN_CONTACT,
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
  ///
  /// !WARNING! Do not confuse with [AppRoute.hasProject]
  bool get isPartOfProjects => root == ROOT_PROJECTS;

  /// An icon matching the mode.
  IconData get icon => _icon ?? Icons.not_interested;

  /// A [GetPage] matching this route.
  ///
  /// This is used by the [Get] package during the initialization of the app.
  GetPage get page => GetPage(
        name: path,
        page: builder ?? () => const ResponsiveHome(),
      );

  /// Whether the route is used for a project.
  bool get hasProject => parts.contains("projects");

  /// Returns the ID of the project in the route.
  ///
  /// Returns [null] if there are no projects in the route.
  int? get projectID {
    final int indexBefore = parts.indexOf("projects");
    if (indexBefore == -1) return null;
    if (parts.length == indexBefore + 1) return null;
    return int.tryParse(parts[indexBefore + 1]);
  }

  /// Whether the route is used for a blog.
  bool get isBlog => parts.contains("blogs");

  /// Returns the ID of the blog in the route.
  ///
  /// Returns [null] if there are no blogs in the route.
  int? get blogID {
    final int indexBefore = parts.indexOf("blogs");
    if (indexBefore == -1) return null;
    if (parts.length == indexBefore) return null;
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

  /// Returns a [AppRoute] linking to the given blog.
  factory AppRoute.fromBlog(int? id) => id == null
      ? AppRoute.MAIN_BLOGS
      : AppRoute(
          "/blogs/$id",
          // builder: () => ResponsiveBlog(
          //   postInit: (_) {
          //     router.push(path: "/blogs/$id");
          //     router.selectMedia(id);
          //   },
          // ),
        );

  // METHODS ===================================================================

  /// Whether this route shares its root with the route given as argument.
  bool shareRootWith(AppRoute other) => root == other.root;

  @override
  String toString() => path;
}
