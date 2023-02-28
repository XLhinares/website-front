import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../tabs/tabs.dart";
import "../../utils/utils.dart";
import "../dataclass/app_mode.dart";

/// A custom route data-class.
class CustomRoute {
  // VARIABLES =================================================================

  /// The name of the route, it is also the path.
  final String name;

  /// The list of elements in the path.
  late final List<String> parts;

  /// The [AppMode] that matches the name.
  ///
  /// It is used to quickly work with the main modes without having to parse the
  /// path.
  late final AppMode mode;

  /// A [GetPage] matching the path.
  late final GetPage page;

  /// An optional builder to tell the app the building logic of the path.
  ///
  /// If null, the route will lead to the home tab.
  final Widget Function()? builder;

  // CONSTANTS =================================================================
  // ignore_for_file: non_constant_identifier_names

  /// Route to the root tab of the app.
  static final ROOT = CustomRoute("/", builder: () => const ResponsiveHome());

  /// Route to the home tab of the app.
  static final HOME = CustomRoute("/home",
      builder: () => ResponsiveHome(
            postInit: (_) => router.push(mode: AppMode.home),
          ));

  /// Route to the blog tab of the app.
  static final BLOGS = CustomRoute(
    "/blogs",
    builder: () => ResponsiveHome(
      postInit: (_) => router.push(mode: AppMode.blogs),
    ),
  );

  /// Route to the projects tab of the app.
  static final PROJECTS = CustomRoute(
    "/projects",
    builder: () => ResponsiveHome(
      postInit: (_) => router.push(mode: AppMode.projects),
    ),
  );

  /// Route to the contacts tab of the app.
  static final CONTACTS = CustomRoute("/contact",
      builder: () => ResponsiveHome(
            postInit: (_) => router.push(mode: AppMode.contact),
          ));

  /// Route to the settings tab of the app.
  static final SETTINGS = CustomRoute("/settings",
      builder: () => ResponsiveHome(
            postInit: (_) => router.push(mode: AppMode.settings),
          ));

  /// Route to the cookie legal page of the app.
  static final COOKIES =
      CustomRoute("/legal/cookie_policy", builder: () => const CookiePolicy());

  /// Route to the privacy legal page of the app.
  static final PRIVACY = CustomRoute("/legal/privacy_policy",
      builder: () => const PrivacyPolicy());

  /// Route to the legal mentions page of the app.
  static final LEGAL = CustomRoute("/legal/legal_mentions",
      builder: () => const LegalMentions());

  /// Route to the "not found" page of the app.
  static final NOT_FOUND = CustomRoute("/not_found",
      builder: () => ResponsiveHome(
            postInit: (context) => XDialog.text(
              title: "Resource not found.",
            ),
          ));

  /// All the handled [CustomRoutes].
  static final values = [
    CustomRoute.ROOT,
    CustomRoute.HOME,
    CustomRoute.BLOGS,
    CustomRoute.PROJECTS,
    CustomRoute.CONTACTS,
    CustomRoute.COOKIES,
    CustomRoute.PRIVACY,
    CustomRoute.LEGAL,
    CustomRoute.SETTINGS,
    CustomRoute.NOT_FOUND,
  ];

  // PSEUDO-GETTERS ============================================================

  /// Whether this route is accessible to the current user.
  bool isAccessibleToUser() => mode.isAccessibleToUser;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CustomRoute] matching the given parameters.
  CustomRoute(
    this.name, {
    this.builder,
  }) {
    parts = name.split("/");
    mode = AppMode.parse(parts.isEmpty ? "" : parts[1]);
    page = GetPage(name: name, page: builder ?? () => const ResponsiveHome());
  }

  /// Tries to match a default route to the given parameters and return it.
  ///
  /// If there are no match, creates and return a new route.
  factory CustomRoute.parse({String? path, AppMode? mode}) {
    assert((mode != null) || (path != null),
        "[mode] and [path] cannot both be null.");

    final newRoute =
        values.firstWhereOrNull((r) => r.name == path || r.mode == mode);

    if (newRoute != null) return newRoute;
    return NOT_FOUND;
  }

  /// Returns a [CustomRoute] linking to the given project.
  factory CustomRoute.fromProject(int? id) => id == null
      ? CustomRoute.PROJECTS
      : CustomRoute(
          "/projects/$id",
          builder: () => ResponsiveHome(
            postInit: (_) {
              router.push(mode: AppMode.projects);
              router.selectProject(id);
            },
          ),
        );

  /// Returns a [CustomRoute] linking to the given blog.
  factory CustomRoute.fromBlog(int? id) => id == null
      ? CustomRoute.BLOGS
      : CustomRoute(
          "/blogs/$id",
          builder: () => ResponsiveHome(
            postInit: (_) {
              router.push(mode: AppMode.blogs);
              router.selectBlog(id);
            },
          ),
        );
}
