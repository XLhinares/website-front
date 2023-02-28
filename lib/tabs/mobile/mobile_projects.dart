import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";
import "../../widgets/medias/medias.dart";

/// The "project" tab adapted for mobile.
class MobileProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileProjects] matching the given parameters.
  const MobileProjects({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (context) {
        return router.project == null
            ? PagewiseListView<Project>(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(XLayout.paddingM),
                pageLoadController: projectLoaderController.controller,
                itemBuilder: (context, entry, index) =>
                    _projectBuilder(context, entry),
                itemExtent: XLayout.paddingM * 8,
              )
            : MediaFocus<Project>(
                media: user.getProject(router.project!),
                headerBuilder: (media, scrollController) => MediaMobileHeader(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) => MediaMobileContent(content: content),
              );
      },
    );
  }

  // METHODS ===================================================================

  Widget _projectBuilder(BuildContext context, Media project) =>
      MediaWidePreview(
        media: project,
        onTap: () => router.selectProject(project.id),
      );
}
