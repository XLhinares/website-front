import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../components/exports.dart";
import "../../utils/exports.dart";
import "../../widgets/medias/exports.dart";

/// The content of the body in the "ProjectPreviews" mode.
class DesktopProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopProjects] matching the given parameters.
  const DesktopProjects({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (context) => AnimatedSwitcher(
        duration: animDurationShort,
        child: router.project == null
            ? PagewiseGridView<Project>.count(
                crossAxisCount: 3,
                mainAxisSpacing: XLayout.paddingM,
                crossAxisSpacing: XLayout.paddingM,
                childAspectRatio: 3 / 4,
                padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
                physics: const BouncingScrollPhysics(),
                pageLoadController: projectLoaderController.controller,
                itemBuilder: (context, entry, index) =>
                    _projectBuilder(context, entry),
              )
            : MediaFocus<Project>(
                media: user.getProject(router.project!),
                headerBuilder: (media, scrollController) =>
                    MediaDesktopHeader<Project>(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) =>
                    MediaDesktopContent(content: content),
                listViewVerticalPadding: XLayout.paddingL,
                onBack: () => router.selectProject(null),
              ),
      ),
    );
  }

  // METHODS ===================================================================

  Widget _projectBuilder(BuildContext context, Project project) =>
      ProjectPreviewer(
        project: project,
        onTap: () => router.selectProject(project.id),
      );
}
