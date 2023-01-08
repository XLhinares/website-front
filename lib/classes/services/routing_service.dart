import "package:flutter/material.dart";
import "package:get/get.dart";

import "../dataclass/app_mode.dart";
import "../../utils/globals.dart";

/// A service managing the state of the app.
class RoutingService extends GetxController with GetTickerProviderStateMixin {
  // VARIABLES =================================================================

  /// The current mode of the app.
  late final Rx<AppMode> _selectedTab;

  /// The last selected main tab.
  late final Rx<AppMode> _lastMainTab;

  /// The name of the project currently selected by the app.
  late final Rx<int?> _selectedProject;

  /// A controller handling the [TabBarView] of the mobile version.
  late final TabController _tabController;

  /// A controller handling the [PageView] of the mobile version.
  late final PageController _pageController;

  /// The history of what the user did.
  late final List<String> _history;

  // GETTERS ===================================================================

  /// The current mode of the app.
  AppMode get mode => _selectedTab.value;

  /// The current mode of the app.
  int get modeIndex => AppMode.mainTabs.indexOf(_lastMainTab.value);

  /// The currently selected project if it exists.
  int? get project => _selectedProject.value;

  /// Whether the app is at home.
  bool get atHome => mode == AppMode.home;

  /// A controller handling the tabs of the mobile version of the app.
  TabController get tabController => _tabController;

  /// A controller handling the pages of the desktop version of the app.
  PageController get pageController => _pageController;

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
    _history = ["/"];

    // TAB / PAGE VIEW
    _tabController =
        TabController(length: AppMode.mainTabs.length, vsync: this);
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

    _tabController.animateTo(selectedIndex);
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

    _tabController.animateTo(selectedIndex, duration: animDurationLong);
    if (_pageController.hasClients) {
      _pageController.animateToPage(selectedIndex,
          duration: animDurationLong, curve: Curves.easeIn);
    }
  }

  /// Select a project to be displayed by the router.
  void selectProject(int? name) {
    if (name == _selectedProject.value) {
      _selectedProject.value = null;
    } else {
      _selectedProject.value = name;
    }

    _history.add("${_selectedTab.value}/${_selectedProject.value}");
  }

  /// Pushes the given route to navigator and add it to the history.
  void push({String? route, AppMode? mode}) {
    assert((mode != null) ^ (route != null),
        "Either [mode] or [route] should be given.");

    final newRoute = route ?? "/${mode?.name}";
    final parts = newRoute.split("/");
    final newMode = mode ?? AppMode.parse(parts.isEmpty ? "" : parts.first);

    printInfo(info: "Pushing new route: $newRoute\nParts: $parts");

    void pushHome() {
      if (_history.last == "/") return;
      Get.toNamed("/");
    }

    void pushIdentical() {
      printInfo(info: "Tapped on the current mode, applying custom behavior");
      if (newMode == AppMode.projects) {
        selectProject(null);
        _history.add("/projects");
      }
    }

    void pushNew() {
      void pushMainTab() {
        printInfo(info: "Animating to main tab.");
        // If the route is part of the main tabs, we animate the controller there.
        animateTo(mode: newMode);
        if (newMode == AppMode.projects && parts.length > 1) {
          selectProject(int.tryParse(parts[1]));
        }
        _lastMainTab.value = newMode;
      }

      if (newMode.isMainTab) {
        pushMainTab();
      } else {
        printInfo(info: "Animating to other tab.");
        Get.toNamed(newRoute);
      }
      _selectedTab.value = newMode;
      _history.add(newRoute);
    }

    if (parts.isEmpty) return pushHome();
    if (_history.isNotEmpty && newRoute == _history.last) {
      return pushIdentical();
    }
    pushNew();
  }

  /// Pops the current route
  void pop() {
    if (_history.length < 2) {
      Get.back();
      return;
    } else {
      _history.removeLast();
      final newRoute = _history.removeLast();
      push(route: newRoute);
    }
  }
}
