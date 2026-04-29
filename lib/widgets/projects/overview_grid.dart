import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../medias/preview_tile.dart";

/// A [PagewiseGridView] loading and displaying the list of projects.
class ProjectsGridView extends StatelessWidget {
  /// A [PagewiseGridView] loading and displaying the list of projects.
  const ProjectsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return PagewiseGridView<Media>.count(
      crossAxisCount: 3,
      mainAxisSpacing: XLayout.paddingM,
      crossAxisSpacing: XLayout.paddingM,
      childAspectRatio: 3 / 4,
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      physics: const BouncingScrollPhysics(),
      pageLoadController: projectLoaderController.controller,
      itemBuilder: (context, entry, index) => MediaPreviewTile(
        media: entry,
        onTap: () => router.selectProject(entry.id),
      ),
    );
  }
}
