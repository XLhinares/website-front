import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/route.dart";
import "../../classes/medias/medias.dart";
import "../../components/exports.dart";
import "../../components/projects/projects_list.dart";
import "../../utils/exports.dart";
import "../../widgets/background/animated_background_wave.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/exports.dart";
import "drawer.dart";
import "overlay.dart";

/// The full "project" tab adapted for mobile.
class MobilePageProjects extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.PAGE_PROJECTS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobilePageProjects] matching the given parameters.
  MobilePageProjects({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      background: _responsiveBackground(context),
      drawer: CustomDrawer(),
      body: IfAppIsReady(
        child: GetBuilder(
          init: router,
          builder: (context) {
            return router.project == null
                ? MobileOverlay(
                    showBackButton: true,
                    child: ProjectsListView(),
                  )
                : MediaFocus<Project>(
                    media: user.getProject(router.project!),
                    headerBuilder: (media, scrollController) =>
                        MediaMobileHeader(
                      media: media,
                      scrollController: scrollController,
                    ),
                    partsBuilder: (content) =>
                        MediaMobileContent(content: content),
                  );
          },
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
}
