import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/project.dart";
import "../../components/medias/media_focus.dart";
import "../../components/medias/no_project_selected.dart";
import "../../utils/globals.dart";
import "../../widgets/medias/exports.dart";

/// The content of the project page or desktop.
class DesktopProjectsContent extends StatelessWidget {
  /// The content of the project page or desktop.
  const DesktopProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      child: GetBuilder(
        init: router,
        builder: (context) => AnimatedSwitcher(
          duration: animDurationShort,
          child: router.project == null
              ? NoProjectSelected()
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
      ),
    );
  }
}
