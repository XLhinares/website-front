import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/medias/desktop_header.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/projects/overview_grid.dart";

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
            : MediaFocus(
                media: app.medias.getProject(router.project!),
                headerBuilder: (media, scrollController) => MediaDesktopHeader(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) => MediaContentWidget(content: content),
                listViewVerticalPadding: XLayout.paddingL,
                onBack: () => router.selectProject(null),
              ),
      ),
    );
  }

  // METHODS ===================================================================
}
