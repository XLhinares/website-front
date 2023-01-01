import "dart:async";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../dataclass/app_mode.dart";
import "../../utils/globals.dart";

/// A service managing the state of the app.
class CustomRouter extends GetxController with GetTickerProviderStateMixin {
  // VARIABLES =================================================================

  /// The current mode of the app.
  late final Rx<AppMode> _selectedMode;

  late final Rx<String?> _selectedProject;

  late final TabController _tabController;

  // ANIMATION =================================================================

  late final AnimationController _animationController;

  /// An animation controlled by [_animationController] that goes from 0 to 1.
  late final Animation<double> _animation;

  // GETTERS ===================================================================

  /// The current mode of the app.
  AppMode get mode => _selectedMode.value;

  /// The current mode of the app.
  int get modeIndex => AppMode.values.indexOf(mode);

  /// The currently selected project if it exists.
  String? get project => _selectedProject.value;

  /// Whether the app is at home.
  bool get atHome => mode == AppMode.home;

  /// An animation controlled by [_animationController] that goes from 0 to 1.
  Animation<double> get animation => _animation;

  /// A controller handling the tabs of the mobile version of the app.
  TabController get tabController => _tabController;

  // CONSTRUCTOR ===============================================================

  /// The private instance of [CustomRouter].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final CustomRouter _instance = CustomRouter._internal();

  /// Re_turns the unique [CustomRouter] instance.
  factory CustomRouter() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  CustomRouter._internal() {
    // INITIAL VALUES ----------------------------------------------------------
    _selectedMode = AppMode.home.obs;
    _selectedProject = Rx<String?>(null);

    // ANIMATION
    _animationController = AnimationController(
      duration: animDurationLong,
      reverseDuration: const Duration(seconds: 0),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    // TAB VIEW
    _tabController = TabController(length: AppMode.values.length, vsync: this);

    // WORKERS -----------------------------------------------------------------
    ever(_selectedMode, (_) => update());
    ever(_selectedProject, (_) => update());

    _tabController.addListener(() {
      _selectedMode.value = AppMode.values[_tabController.index];
    });
  }

  // METHODS ===================================================================

  /// Goes to the given mode and reloads the controller.
  void goTo({AppMode? mode, int? index}) {
    assert((mode != null) ^ (index != null),
        "Either [mode] or [index] should be given.");

    // Infer the missing value between the mode and the index.
    final AppMode selectedMode = mode ?? AppMode.values[index!];
    final int selectedIndex = index ?? AppMode.values.indexOf(mode!);

    // Custom behaviors for double tap on the same index.
    if (this.mode == selectedMode) {
      printInfo(info: "Tapped on the current mode, applying custom behavior");
      if (this.mode == AppMode.projects) {
        selectProject(null);
      }
    }

    // Play the animations and select the new mode.
    _animationController
        .forward()
        .then((value) => _animationController.reset());
    _tabController.animateTo(selectedIndex, duration: animDurationLong ~/ 2);

    Timer(Duration(milliseconds: animDurationLong.inMilliseconds ~/ 2), () {
      _selectedMode.value = selectedMode;
    });
  }

  /// Select a project to be displayed by the router.
  void selectProject(String? name) {
    if (name == _selectedProject.value) {
      _selectedProject.value = null;
    } else {
      _selectedProject.value = name;
    }
  }
}
