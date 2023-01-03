import "package:flutter/material.dart";
import "package:get/get.dart";

import "../dataclass/app_mode.dart";
import "../../utils/globals.dart";

/// A service managing the state of the app.
class RoutingService extends GetxController with GetTickerProviderStateMixin {
  // VARIABLES =================================================================

  /// The current mode of the app.
  late final Rx<AppMode> _selectedMode;

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
  AppMode get mode => _selectedMode.value;

  /// The current mode of the app.
  int get modeIndex => AppMode.values.indexOf(mode);

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
    _selectedMode = AppMode.home.obs;
    _selectedProject = Rx<int?>(null);
    _history = [];

    // TAB / PAGE VIEW
    _tabController = TabController(length: AppMode.values.length, vsync: this);
    _pageController = PageController();

    // WORKERS -----------------------------------------------------------------
    ever<AppMode>(_selectedMode, (value) => _pushHistory(value.name));
    ever<int?>(_selectedProject,
        (value) => _pushHistory("${_selectedMode.value.name}/$value"));
  }

  // METHODS ===================================================================

  void _pushHistory(String route) {
    _history.add(route);
    update();
  }

  /// Jumps to the given mode without reloading the controller.
  void jumpTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final AppMode selectedMode = mode ?? AppMode.values[index!];
    final int selectedIndex = index ?? AppMode.values.indexOf(mode!);

    _tabController.animateTo(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
    _selectedMode.value = selectedMode;
  }

  /// Goes to the given mode and reloads the controller.
  void goTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final AppMode selectedMode = mode ?? AppMode.values[index!];

    // Custom behaviors for double tap on the same index.
    if (this.mode == selectedMode) {
      printInfo(info: "Tapped on the current mode, applying custom behavior");
      if (this.mode == AppMode.projects) {
        selectProject(null);
      }
      return;
    }

    animateTo(mode: selectedMode);
    _selectedMode.value = selectedMode;
  }

  /// Animates to the given mode.
  ///
  /// This does not select a new mode nor reload!
  void animateTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final int selectedIndex = index ?? AppMode.values.indexOf(mode!);

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
  }
}
