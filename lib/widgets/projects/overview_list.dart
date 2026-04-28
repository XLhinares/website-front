import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../medias/preview_wide_box.dart";

/// A list of the projects.
///
/// It is displayed in the project page on mobile.
class ProjectsListView extends StatelessWidget {
  /// A list of the projects.
  ///
  /// It is displayed in the project page on mobile.
  const ProjectsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Media>(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: XLayout.paddingL * 1.5 + XLayout.paddingM * 2,
        bottom: XLayout.paddingM,
        left: XLayout.paddingM,
        right: XLayout.paddingM,
      ),
      pageLoadController: projectLoaderController.controller,
      itemBuilder: (context, entry, index) => MediaWidePreview(
        media: entry,
        onTap: () => router.selectProject(entry.id),
      ),
      itemExtent: XLayout.paddingM * 8,
    );
  }
}
