import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../classes/medias/medias.dart";
import "../../components/exports.dart";
import "../../utils/exports.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/exports.dart";

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
            children: [
              _projectBuilder(context, snapshot![0]),
              _projectBuilder(context, snapshot[1]),
              _projectBuilder(context, snapshot[2]),
              XInkContainer(
                onTap: () => router.push(route: AppRoute.PAGE_PROJECTS),
                child: Text("display_more".tr),
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
          onTap: () => router.push(route: AppRoute.pageFromProject(project.id)),
        ),
      );

  Widget get _loadingWidget => ListView(
        physics: const BouncingScrollPhysics(),
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
          XInkContainer(
            onTap: () => router.push(route: AppRoute.PAGE_PROJECTS),
            child: Text("display_more".tr),
          )
        ],
      );
}
