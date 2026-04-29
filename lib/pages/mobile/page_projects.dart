import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/mobile_header.dart";
import "../../widgets/projects/overview_list.dart";
import "../meta/if_app_is_ready.dart";
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
    return GetBuilder(
      init: router,
      builder: (controller) => ScaffoldFit(
        drawer: CustomDrawer(),
        overlay: MobileOverlay(
          showBackButton: true,
        ),
        body: IfAppIsReady(
          child: router.project == null
              ? ProjectsListView()
              : MediaFocus(
                  media: app.medias.getProject(router.project!),
                  headerBuilder: (media, scrollController) => MediaMobileHeader(
                    media: media,
                    scrollController: scrollController,
                  ),
                  partsBuilder: (content) => MediaContentWidget(
                    content: content,
                    padding: EdgeInsets.all(XLayout.paddingM),
                  ),
                ),
        ),
      ),
    );
  }
}
