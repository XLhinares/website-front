import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:scroll_to_index/scroll_to_index.dart";

import "../globals.dart";
import "../classes/dataclass/route.dart";
import "../utils/tools.dart";

/// A service managing the state of the app.
///
/// Routes
///
/// - /main
/// - /main/home
/// - /main/project
/// - /main/contact
/// - /main/settings
///
/// - /projects
///
/// - /legal/cookie_policy
/// - /legal/privacy_policy
/// - /legal/legal_mentions
class XRouter extends GetxController {
  // VARIABLES =================================================================

  /// The current route of the app.
  late final Rx<AppRoute> _currentRoute;

  /// The last selected main tab.
  late final Rx<AppRoute> _currentMainTab;

  /// The name of the media currently selected by the app.
  late final Rx<int?> _selectedProject;

  /// The name of the media currently selected by the app.
  late final Rx<int?> _selectedBlog;

  /// A controller handling the main [ListView] on the main mobile and desktop pages.
  final AutoScrollController autoScrollController = AutoScrollController();

  /// A controller handling the [PageView] of the mobile version.
  late PageController _pageController;

  /// The history of what the user did.
  late final List<AppRoute> _history;

  // GETTERS ===================================================================

  /// The current route of the app.
  AppRoute get currentRoute => _currentRoute.value;

  /// The currently selected main tab.
  ///
  /// It is node necessarily the displayed route tho, because the user can go on a different page.
  AppRoute get mainTab => _currentMainTab.value;

  /// The current route of the app.
  int get routeIndex => AppRoute.mainRoutes.indexOf(_currentMainTab.value);

  /// The currently selected project if it exists.
  int? get project => _selectedProject.value;

  /// The currently selected project if it exists.
  int? get blog => _selectedBlog.value;

  /// Whether the app is at home.
  bool get atHome => mainTab == AppRoute.MAIN_HOME;

  /// A controller handling the pages of the main page.
  PageController get pageController => _pageController;

  /// A clean pageController handling the pages of the main page.
  ///
  /// The purpose of creating a new one is to avoid the "Multiple PageViews are attached to the same PageController" error.
  PageController get newPageController {
    _pageController = PageController(initialPage: getIndexOfMainTab(mainTab));
    return _pageController;
  }

  // PSEUDO-GETTERS ============================================================

  /// Whether the given route exist in our app.
  bool isRoute(String route) =>
      routes.where((element) => element.path == route).isNotEmpty;

  /// A list of all the routes in the app.
  List<AppRoute> get routes => AppRoute.values;

  /// Returns the index of the given tab within the list of the main page tab.
  ///
  /// If the given route doesn't match a main page tab, returns -1.
  int getIndexOfMainTab(AppRoute route) {
    if (!route.isPartOfMain) return -1;
    return AppRoute.mainRoutes.indexOf(route);
  }

  // CONSTRUCTOR ===============================================================

  /// The private instance of [XRouter].
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final XRouter _instance = XRouter._internal();

  /// Re_turns the unique [XRouter] instance.
  factory XRouter() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  XRouter._internal() {
    // INITIAL VALUES ----------------------------------------------------------
    _currentRoute = AppRoute.MAIN_HOME.obs;
    _currentMainTab = AppRoute.MAIN_HOME.obs;
    _selectedProject = Rx<int?>(null);
    _selectedBlog = Rx<int?>(null);
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

  /// Select a project to be displayed by the router.
  void selectProject(int? id) {
    dlog("Selecting project: $id");

    if (id == _selectedProject.value) {
      _selectedProject.value = null;
    } else {
      _selectedProject.value = id;
    }
    update();
  }

  /// Select a blog to be displayed by the router.
  void selectBlog(int? id) {
    dlog("Selecting blog: $id");
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

  /// Pushes the given route to navigator and add it to the history.
  void goTo(AppRoute newRoute, {bool force = false}) {
    if (!newRoute.isAccessibleToUser) return;

    dlog("");
    dlog("FROM [${currentRoute.path}] (${currentRoute.root}) TO "
        "[${newRoute.path}] (${newRoute.root})");

    // FORCE -------------------------------------------------------------------
    if (force || _history.isEmpty) {
      // If [force] is true, or if there is no known route in history,
      // forces going to [newRoute].
      _history.add(newRoute);
      _forceGoTo(newRoute);

      // SHARED ROOT -------------------------------------------------------------
    } else if (newRoute.root == _history.last.root) {
      // If going to a route on the same root, applies special behavior.
      // No history is recorded.
      _goWithinRoute(newRoute);

      // OTHER -------------------------------------------------------------------
    } else {
      _history.add(newRoute);
      _forceGoTo(newRoute);
    }

    dlog("History: $_history");
    update();
  }

  /// Moves within a same page.
  ///
  /// This change the last element of the [_history] to reflect the route.
  void _goWithinRoute(AppRoute newRoute) {
    // WITHIN MAIN PAGE --------------------------------------------------------
    if (newRoute.isPartOfMain) {
      dlog("Moving within ${newRoute.root}");
      if (newRoute == _currentMainTab.value) {
        _moveOnPlace(newRoute);
        // Return to avoid changing rewriting history.
        return;
      } else {
        // Infer the missing value between the route and the index.
        final int selectedIndex = getIndexOfMainTab(newRoute);

        autoScrollController.scrollToIndex(selectedIndex);

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            selectedIndex,
            duration: animDurationLong,
            curve: Curves.easeIn,
          );
        }

        _currentMainTab.value = newRoute;
      }

      // WITHIN PROJECTS PAGE --------------------------------------------------
    } else if (newRoute.isPartOfProjects) {
      // No need for specific animation.
    }

    // Rewrite the history.
    // This allows going back to the last tab of the current page when using [goBack].
    _history.removeLast();
    _history.add(newRoute);
  }

  /// Applies special behaviors when trying the access the already current route.
  void _moveOnPlace(AppRoute newRoute) {
    // MAIN PROJECT PAGE -------------------------------------------------------
    if (newRoute == AppRoute.MAIN_PROJECTS) {
      if (project == null) {
        goTo(AppRoute.PAGE_PROJECTS);
      } else {
        _selectedProject.value = null;
      }
      return;
    }
  }

  void _forceGoTo(AppRoute newRoute) {
    dlog("[IMPORTANT] Applying route move to $newRoute");
    Get.offNamed(newRoute.path);
  }

  /// Pops the current route.
  ///
  /// If [soft] is true, the router will first try to set the current project to null.
  void goBack({bool soft = false}) {
    dlog("[IMPORTANT] GOING BACK !!!");

    if (soft && project != null) {
      selectProject(null);
      return;
    }

    // if (blog != null) {
    //   return selectProject(null);
    // }

    if (_history.length < 2) {
      dlog("No history to go back to.");
      dlog("Applying default [back] behavior.");
      Get.back();
      return;
    }

    // Remove the current route and the last route.
    // Then re-push the last route.
    // This way we can have animations if needed.
    _history.removeLast();
    final newRoute = _history.removeLast();
    goTo(newRoute);
  }

  /// Tells the navigator that a given route was accessed.
  /// Adds the route to the history if needed
  void setRoute(AppRoute newRoute) {
    if (!newRoute.isAccessibleToUser) return;

    dlog("ROUTER > Setting new route: ${newRoute.path}.");

    if (_history.isNotEmpty && newRoute == _history.last) {
      // Don't do anything
    } else {
      _currentRoute.value = newRoute;
      _history.add(newRoute);
    }

    update();
  }
}
