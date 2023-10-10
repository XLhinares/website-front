import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/exports.dart";
import "../dataclass/dataclass.dart";
import "../routes/custom_route.dart";

/// A service managing the state of the app.
class RoutingService extends GetxController {
  // VARIABLES =================================================================

  /// The current mode of the app.
  late final Rx<AppMode> _selectedTab;

  /// The last selected main tab.
  late final Rx<AppMode> _lastMainTab;

  /// The name of the project currently selected by the app.
  late final Rx<int?> _selectedProject;

  /// The name of the blog currently selected by the app.
  late final Rx<int?> _selectedBlog;

  /// A controller handling the [PageView] of the mobile version.
  late final PageController _pageController;

  /// The history of what the user did.
  late final List<CustomRoute> _history;

  /// The list of named routes used in the app.
  late final List<CustomRoute> routes;

  // GETTERS ===================================================================

  /// The current mode of the app.
  AppMode get mode => _selectedTab.value;

  /// The current mode of the app.
  int get modeIndex => AppMode.mainTabs.indexOf(_lastMainTab.value);

  /// The currently selected project if it exists.
  int? get project => _selectedProject.value;

  /// The currently selected blog if it exists.
  int? get blog => _selectedBlog.value;

  /// Whether the app is at home.
  bool get atHome => mode == AppMode.home;

  /// A controller handling the pages of the desktop version of the app.
  PageController get pageController => _pageController;

  // PSEUDO-GETTERS ============================================================

  /// Whether the given route exist in our app.
  bool isRoute(String route) =>
      routes.where((element) => element.name == route).isNotEmpty;

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
    _selectedTab = AppMode.home.obs;
    _lastMainTab = AppMode.home.obs;
    _selectedProject = Rx<int?>(null);
    _selectedBlog = Rx<int?>(null);
    _history = [CustomRoute.HOME];

    routes = CustomRoute.values;

    // TAB / PAGE VIEW
    _pageController = PageController();
  }

  // METHODS ===================================================================

  /// Jumps to the given mode without reloading the controller.
  void jumpTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final AppMode selectedMode = mode ?? AppMode.values[index!];
    final int selectedIndex = index ?? AppMode.values.indexOf(mode!);

    _pageController.jumpToPage(selectedIndex);
    _selectedTab.value = selectedMode;
  }

  /// Animates to the given mode.
  ///
  /// This does not select a new mode nor reload!
  void animateTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final int selectedIndex = index ?? AppMode.mainTabs.indexOf(mode!);

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
    }

    _history.add(CustomRoute.fromProject(id));
    update();
  }

  /// Select a blog to be displayed by the router.
  void selectBlog(int? id) {
    printInfo(info: "Selecting blog: $id");
    if (id == _selectedBlog.value) {
      _selectedBlog.value = null;
    } else {
      _selectedBlog.value = id;
    }

    _history.add(CustomRoute.fromBlog(id));
    update();
  }

  void _pushRoot() {
    if (_history.last == CustomRoute.HOME) return;
    Get.toNamed("/home");
  }

  void _pushIdentical(CustomRoute route) {
    printInfo(info: "Tapped on the current mode, applying custom behavior");
    if (route.mode == AppMode.projects) {
      selectProject(null);
    }
  }

  // If the route is part of the main tabs, we animate the controller there.
  void _pushMainTab(CustomRoute route) {
    printInfo(info: "Animating to main tab.");
    animateTo(mode: route.mode);
    if (route.mode == AppMode.projects && route.parts.length > 1) {
      selectProject(int.tryParse(route.parts[1]));
    }
    _lastMainTab.value = route.mode;
  }

  void _pushNew(CustomRoute route) {
    if (route.mode.isMainTab) {
      _pushMainTab(route);
    } else {
      if (!isRoute(route.name)) return;
      printInfo(info: "Animating to other tab.");
      Get.toNamed(route.name);
    }
    _selectedTab.value = route.mode;
    _history.add(route);
  }

  /// Pushes the given route to navigator and add it to the history.
  void push({CustomRoute? route, String? path, AppMode? mode}) {
    assert((mode != null) ^ (route != null) ^ (path != null),
        "Either [mode] or [route] or [path] should be given.");

    final newRoute = route ?? CustomRoute.parse(path: path, mode: mode);
    if (!newRoute.isAccessibleToUser()) return;

    printInfo(info: "ROUTER > Pushing new route: ${newRoute.name}.");

    if (newRoute == CustomRoute.ROOT) {
      _pushRoot();
    } else if (_history.isNotEmpty && newRoute == _history.last) {
      _pushIdentical(newRoute);
    } else {
      _pushNew(newRoute);
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
      if (!lastTab.mode.isMainTab) Get.back();
      push(route: newRoute);
    }
  }
}
