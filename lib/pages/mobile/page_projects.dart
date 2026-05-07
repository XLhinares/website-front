import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/mobile_appbar.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/mobile_header.dart";

import "../../widgets/medias/overview_list.dart";
import "../meta/if_app_is_ready.dart";
import "drawer.dart";

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
      overlay: MobileAppbar(title: "tab_projects".tr),
      drawer: CustomDrawer(),
      body: IfAppIsReady(
        child: GetBuilder(
            init: router,
            builder: (_) => router.project == null
                ? MediaListView(
                    padding: EdgeInsets.only(
                      top: XLayout.paddingL * 2.5, // Account for appbar
                      left: XLayout.paddingM,
                      right: XLayout.paddingM,
                    ),
                    medias: app.medias.projects,
                    onTapMedia: (media) => router.selectProject(media.id),
                  )
                : MediaFocus(
                    media: app.medias.fetchByID(router.project!),
                    headerBuilder: (media, scrollController) =>
                        MediaMobileHeader(
                      media: media,
                      scrollController: scrollController,
                    ),
                    partsBuilder: (content) => MediaContentWidget(
                      content: content,
                      padding: EdgeInsets.all(XLayout.paddingM),
                    ),
                  )),
      ),
    );
  }
}
