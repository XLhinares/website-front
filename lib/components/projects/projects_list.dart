import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/project.dart";
import "../../utils/globals.dart";
import "../medias/project_wide_preview.dart";

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
    return PagewiseListView<Project>(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(XLayout.paddingM),
      pageLoadController: projectLoaderController.controller,
      itemBuilder: (context, entry, index) => MediaWidePreview(
        media: entry,
        onTap: () => router.selectProject(entry.id),
      ),
      itemExtent: XLayout.paddingM * 8,
    );
  }
}
