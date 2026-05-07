import "package:flutter/material.dart";
import "package:scroll_to_index/scroll_to_index.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/interactables/button_menu.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../meta/if_app_is_ready.dart";
import "drawer.dart";
import "main_people.dart";
import "main_home.dart";
import "main_projects.dart";
import "main_settings.dart";

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
      drawer: CustomDrawer(),
      overlay: Positioned(
        right: XLayout.paddingM,
        top: XLayout.paddingM,
        height: XLayout.paddingL * 1.5,
        width: XLayout.paddingL * 1.5,
        child: ButtonMenu(),
      ),
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

  List<RouteTab> get _tabs => [
        MobileMainHome(),
        // MobileBlogs(),
        MobileMainProjects(),
        MobileMainPeople(),
        MobileMainSettings(),
      ];
}
