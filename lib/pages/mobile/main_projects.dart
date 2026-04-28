import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/medias/preview_wide_box.dart";
import "../../widgets/utils/preset_future_builder.dart";

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
      child: PresetFutureBuilder(
        future: projectLoaderController.controller.pageFuture?.call(0),
        loadingWidget: _loadingWidget,
        builder: (context, snapshot) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              _projectBuilder(context, snapshot![0]),
              _projectBuilder(context, snapshot[1]),
              _projectBuilder(context, snapshot[2]),
              XButton.text(
                "display_more".tr,
                onTap: () => router.goTo(AppRoute.PAGE_PROJECTS),
              ),
            ],
          );
        },
      ),
    );
  }

  // METHODS ===================================================================

  Widget _projectBuilder(BuildContext context, Media project) => SizedBox(
        height: XLayout.paddingM * 8,
        child: MediaWidePreview(
          media: project,
          onTap: () => router.goTo(AppRoute.parsePageProject(project.id)),
        ),
      );

  Widget get _loadingWidget => ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XButton.text(
            "display_more".tr,
            onTap: () => router.goTo(AppRoute.PAGE_PROJECTS),
          )
        ],
      );
}
