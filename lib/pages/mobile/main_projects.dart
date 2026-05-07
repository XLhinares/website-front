import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/medias/overview_list.dart";

/// The "project" tab adapted for mobile.
class MobileMainProjects extends RouteTab {
  // VARIABLES =================================================================

  @override
  AppRoute get route => AppRoute.MAIN_PROJECTS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainProjects] matching the given parameters.
  const MobileMainProjects({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: GetBuilder(
          init: app.medias,
          tag: "home_project_mobile",
          builder: (_) {
            dlog("RRRRRRRRRRRRRRRRRRRRR");
            return MediaListView(
              medias: app.medias.projects,
              onTapMedia: (media) {
                router.goTo(AppRoute.PAGE_PROJECTS);
                router.selectProject(media.id);
              },
              onTapSeeMore: () => router.goTo(AppRoute.PAGE_PROJECTS),
            );
          }),
    );
  }
}
