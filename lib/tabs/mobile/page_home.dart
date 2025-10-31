import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/route.dart";
import "../../components/exports.dart";
import "../../utils/exports.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/exports.dart";
import "../exports.dart";
import "drawer.dart";
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
      // appBar: AppBar(
      //   title: const Text("Xeppelin"),
      // ),
      background: _responsiveBackground(context),
      // appBar: AppBar(
      //   title: Text("Xeppelin"),
      //   actions: [
      //     IconButton(
      //         onPressed: () => Scaffold.of(context).openDrawer(),
      //         icon: Icon(Icons.menu))
      //   ],
      // ),
      drawer: CustomDrawer(),
      body: IfAppIsReady(
        child: MobileOverlay(
          child: PageView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: router.newPageController,
            pageSnapping: false,
            onPageChanged: (index) => router.set(route: _tabs[index].route),
            children: _tabs,
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
