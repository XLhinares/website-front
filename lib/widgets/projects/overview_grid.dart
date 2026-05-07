import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../medias/preview_tile.dart";

/// A [PagewiseGridView] loading and displaying the list of projects.
class ProjectsGridView extends StatelessWidget {
  /// A [PagewiseGridView] loading and displaying the list of projects.
  const ProjectsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: app.medias,
      builder: (_) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: XLayout.paddingM,
            crossAxisSpacing: XLayout.paddingM,
            childAspectRatio: 3 / 4,
            mainAxisExtent: context.height * .25),
        padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
        physics: const BouncingScrollPhysics(),
        itemCount: app.medias.projects.length,
        itemBuilder: (context, index) => MediaPreviewTile(
          media: app.medias.projects[index],
          onTap: (media) => router.selectProject(media.id),
        ),
      ),
    );
  }
}
