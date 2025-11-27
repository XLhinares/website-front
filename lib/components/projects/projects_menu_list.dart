import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/project.dart";
import "../../globals.dart";
import "../medias/project_tile_preview.dart";

/// A [ListView] of the projects to be used in menus.
class ProjectsMenuListView extends StatelessWidget {
  /// A [ListView] of the projects to be used in menus.
  const ProjectsMenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Project>(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(XLayout.paddingM),
      pageLoadController: projectLoaderController.controller,
      itemBuilder: (context, entry, index) => MediaTilePreview(
        media: entry,
        onTap: () => router.selectProject(entry.id),
      ),
      itemExtent: XLayout.paddingM * 8,
    );
  }
}
