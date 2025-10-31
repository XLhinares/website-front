import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../components/exports.dart";
import "../../components/projects/projects_grid.dart";
import "../../utils/exports.dart";
import "../../widgets/medias/exports.dart";

/// The content of the body in the "ProjectPreviews" mode.
class DesktopMainProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainProjects] matching the given parameters.
  const DesktopMainProjects({
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
            ? ProjectsGridView()
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
}
