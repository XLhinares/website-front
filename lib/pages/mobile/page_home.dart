import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:scroll_to_index/scroll_to_index.dart";

import "../../classes/dataclass/route.dart";
import "../../components/misc/if_app_is_ready.dart";
import "../../globals.dart";
import "../../widgets/background/animated_background_wave.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "drawer.dart";
import "main_contact.dart";
import "main_home.dart";
import "main_projects.dart";
import "main_settings.dart";
import "overlay.dart";

/// The app body as it should
class MobilePageHome extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [MobilePageHome] matching the given parameters.
  const MobilePageHome({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    // Timer.run(() => router.animateTo(index: router.routeIndex));

    return ScaffoldFit(
      background: _responsiveBackground(context),
      drawer: CustomDrawer(),
      overlay: MobileOverlay(),
      frameRatio: frameRatioMobile,
      body: IfAppIsReady(
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: router.newPageController,
          itemCount: _tabs.length,
          itemBuilder: (context, index) => AutoScrollTag(
            key: ValueKey(index),
            controller: router.autoScrollController,
            index: index,
            child: _tabs[index],
          ),
        ),
      ),
    );
  }

  // WIDGETS ===================================================================

  // /// The list of navigation items used by the [BottomNavigationBar].
  // List<BottomNavigationBarItem> get _navigationItems => CustomRoute.mainTabs
  //     .map((tab) => BottomNavigationBarItem(
  //           icon: Icon(
  //             tab.icon,
  //           ),
  //           label: tab.name.tr.capitalizeFirst,
  //         ))
  //     .toList();

  /// Returns the usual [AnimatedBackgroundWave] wrapped in a [GetBuilder] in order to
  /// make the background disappear in specific situations.
  Widget _responsiveBackground(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (_) => AnimatedBackgroundWave(
        scale: router.currentRoute == AppRoute.MAIN_PROJECTS &&
                router.project != null
            ? 0
            : 0.3,
      ),
    );
  }

  List<RouteTab> get _tabs => [
        MobileMainHome(),
        // MobileBlogs(),
        MobileMainProjects(),
        MobileMainContact(),
        MobileMainSettings(),
      ];

  // METHODS ===================================================================

  // double _backgroundScale() {
  //   if (router.mode == CustomRoute.projects && router.project != null) return 0;
  //   if (router.mode == CustomRoute.blogs && router.blog != null) return 0;
  //   return 0.3;
  // }
}
