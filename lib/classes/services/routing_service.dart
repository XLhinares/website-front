import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/exports.dart";
import "../dataclass/route.dart";

/// A service managing the state of the app.
class RoutingService extends GetxController {
  // VARIABLES =================================================================

  /// The current route of the app.
  late final Rx<AppRoute> _currentTab;

  /// The last selected main tab.
  late final Rx<AppRoute> _lastMainTab;

  /// The name of the media currently selected by the app.
  late final Rx<int?> _selectedProject;

  /// The name of the media currently selected by the app.
  late final Rx<int?> _selectedBlog;

  /// A controller handling the [PageView] of the mobile version.
  late PageController _pageController;

  /// The history of what the user did.
  late final List<AppRoute> _history;

  // GETTERS ===================================================================

  /// The current route of the app.
  AppRoute get currentRoute => _currentTab.value;

  /// The currently selected main tab.
  ///
  /// It is node necessarily the displayed route tho, because the user can go on a different page.
  AppRoute get mainTab => _lastMainTab.value;

  /// The current route of the app.
  int get routeIndex => AppRoute.mainRoutes.indexOf(_lastMainTab.value);

  /// The currently selected project if it exists.
  int? get project => _selectedProject.value;

  /// The currently selected project if it exists.
  int? get blog => _selectedBlog.value;

  /// Whether the app is at home.
  bool get atHome => currentRoute == AppRoute.MAIN_HOME;

  /// A controller handling the pages of the main page.
  PageController get pageController => _pageController;

  /// A clean pageController handling the pages of the main page.
  ///
  /// The purpose of creating a new one is to avoid the "Multiple PageViews are attached to the same PageController" error.
  PageController get newPageController {
    _pageController = PageController();
    return _pageController;
  }

  // PSEUDO-GETTERS ============================================================

  /// Whether the given route exist in our app.
  bool isRoute(String route) =>
      allRoutes.where((element) => element.path == route).isNotEmpty;

  /// A list of all the routes in the app.
  List<AppRoute> get allRoutes => AppRoute.values;

  // CONSTRUCTOR ===============================================================

  /// The private instance of [RoutingService].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final RoutingService _instance = RoutingService._internal();

  /// Re_turns the unique [RoutingService] instance.
  factory RoutingService() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  RoutingService._internal() {
    // INITIAL VALUES ----------------------------------------------------------
    _currentTab = AppRoute.MAIN_HOME.obs;
    _lastMainTab = AppRoute.MAIN_HOME.obs;
    _selectedProject = Rx<int?>(null);
    _history = [AppRoute.MAIN_HOME];

    // TAB / PAGE VIEW
    _pageController = PageController();
  }

  // METHODS ===================================================================

  // /// Jumps to the given route without reloading the controller.
  // void jumpTo({AppRoute? route, int? index}) {
  //   assert((route != null) ^ (index != null),
  //       "Either [route] or [index] should be given.");

  //   // Infer the missing value between the route and the index.
  //   final AppRoute selectedMode = route ?? AppRoute.values[index!];
  //   final int selectedIndex = index ?? AppRoute.values.indexOf(route!);

  //   _pageController.jumpToPage(selectedIndex);
  //   _currentTab.value = selectedMode;
  // }

  /// Animates to the given route.
  ///
  /// This does not select a new route nor reload!
  void animateTo({AppRoute? route, int? index}) {
    assert((route != null) ^ (index != null),
        "Either [route] or [index] should be given.");

    // Infer the missing value between the route and the index.
    final int selectedIndex = index ?? AppRoute.mainRoutes.indexOf(route!);

    if (_pageController.hasClients) {
      _pageController.animateToPage(selectedIndex,
          duration: animDurationLong, curve: Curves.easeIn);
    }
  }

  /// Select a project to be displayed by the router.
  void selectProject(int? id) {
    printInfo(info: "Selecting project: $id");
    if (id == _selectedProject.value) {
      _selectedProject.value = null;
    } else {
      _selectedProject.value = id;
      if (currentRoute.isMainRoute) {
        _history.add(AppRoute.previewFromProject(id));
      } else {
        _history.add(AppRoute.pageFromProject(id));
      }
    }
    update();
  }

  /// Select a blog to be displayed by the router.
  void selectBlog(int? id) {
    printInfo(info: "Selecting blog: $id");
    // if (id == _selectedBlog.value) {
    //   _selectedBlog.value = null;
    // } else {
    //   _selectedBlog.value = id;
    //   if (currentRoute.isMainRoute) {
    //     _history.add(AppRoute.previewFromBlog(id));
    //   } else {
    //     _history.add(AppRoute.pageFromBlog(id));
    //   }
    // }
    update();
  }

  /// Goes back to the root of the website.
  // void _pushRoot() {
  //   if (_history.last == AppRoute.MAIN_HOME) return;
  //   Get.toNamed("/home");
  // }

  /// Handles special behaviors when trying to open current route.
  void _pushIdentical(AppRoute route) {
    printInfo(info: "Tapped on the current route, applying custom behavior");

    // When trying to navigate [AppRoute.MAIN_PROJECTS].
    //
    // - If no project is selected, it's a shortcut to open the full project page
    // - If a project was currently selected, it is unselected.
    if (route == AppRoute.MAIN_PROJECTS) {
      if (_selectedProject.value == null) {
        pushRoute(AppRoute.PAGE_PROJECTS);
      } else {
        _selectedProject.value = null;
      }
    }
  }

  /// Pushes the given route to navigator and add it to the history.
  void _pushNew(AppRoute route) {
    printInfo(info: "Applying new route behavior:");

    if (route.isMainRoute && currentRoute.isMainRoute) {
      printInfo(info: "--- within ${AppRoute.ROOT_MAIN}");
      animateTo(route: route);
    } else if (route.isProjectsRoute && currentRoute.isProjectsRoute) {
      printInfo(info: "--- within ${AppRoute.ROOT_PROJECTS}");
      // No need for specific animation.
    } else {
      printInfo(info: "--- outside old route's root");
      Get.toNamed(route.path);
    }

    if (route.hasProject) selectProject(route.projectID);
    if (route.isBlog) selectBlog(route.blogID);
    _currentTab.value = route;
    _history.add(route);
  }

  /// Pushes the given route to navigator and add it to the history.
  void push({AppRoute? route, String? path}) {
    assert((route != null) ^ (path != null),
        "Either [route] or [path] should be given.");

    final newRoute = route ?? AppRoute.parse(path: path);
    if (!newRoute.isAccessibleToUser) return;

    printInfo(info: "");
    printInfo(
        info: "Pushing route: [${currentRoute.path}] >>> [${newRoute.path}]");
    printInfo(info: "--- old route: root (${currentRoute.root})");
    printInfo(info: "--- new route: root (${newRoute.root})");

    printInfo(info: "ROUTER > Pushing new route: ${newRoute.path}.");

    // Behavior when starting the app.
    // if (newRoute == AppRoute.ROOT) {
    //   _pushRoot();
    // } else
    if (_history.isNotEmpty && newRoute == _history.last) {
      _pushIdentical(newRoute);
    } else {
      _pushNew(newRoute);
    }

    update();
  }

  /// Pushes the given route to navigator and add it to the history.
  void pushRoute(AppRoute route) => push(route: route);

  /// Tells the navigator that a given route was accessed.
  /// Adds the route to the history if needed
  void set({AppRoute? route, String? path}) {
    assert((route != null) ^ (path != null),
        "Either [route] or [path] should be given.");

    final newRoute = route ?? AppRoute.parse(path: path);
    if (!newRoute.isAccessibleToUser) return;

    printInfo(info: "ROUTER > Setting new route: ${newRoute.path}.");

    // if (newRoute == XRoute.ROOT) {
    //   _pushRoot();
    // } else
    if (_history.isNotEmpty && newRoute == _history.last) {
      // Don't do anything
    } else {
      _currentTab.value = newRoute;
      _history.add(newRoute);
    }

    update();
  }

  /// Pops the current route
  void pop() {
    if (_history.length < 2) {
      Get.back();
      return;
    } else {
      final lastTab = _history.removeLast();
      final newRoute = _history.removeLast();

      // If the last tab is not one of the main tabs, it need to be popped from
      // the navigator.
      if (!lastTab.isMainRoute) {
        Get.back();
      } else {
        pushRoute(newRoute);
      }
    }
  }
}
