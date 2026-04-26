import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/project.dart";
import "../../utils/extensions.dart";
import "../../widgets/images/covering_network_image.dart";
import "../../widgets/images/xeppelin_logo.dart";
import "../../widgets/medias/button_visit_website.dart";
import "../../widgets/text/auto_color_text.dart";

/// A preview of a project.
class ProjectPreviewer extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Project project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectPreviewer] matching the given parameters.
  const ProjectPreviewer({
    super.key,
    required this.project,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    dlog("project ${project.name} has website: ${project.website}");

    return XButton(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: XLayout.brcXS,
        child: Stack(
          children: [
            // IMAGE ----------------------------------------------------------
            Positioned.fill(
              child: CoveringNetworkImage(
                project.preview,
                errorBuilder: (context, object, trace) => const XeppelinLogo(),
              ),
            ),

            // DESCRIPTION ----------------------------------------------------
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: context.theme.colorScheme.surface.withAlpha(150),
                padding: EdgeInsets.all(XLayout.paddingM),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // NAME
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project.name,
                          style: context.titleMediumOnSurface,
                        ),
                        MediaButtonVisitWebsite(media: project)
                      ],
                    ),

                    XLayout.verticalXS,
                    const Divider(),
                    XLayout.verticalXS,

                    // SUMMARY
                    AutoColorText(
                      project.summary,
                      style: context.bodyMediumOnSurface,
                      color: context.colors.onSurface,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // WEBSITE --------------------------------------------------------
          ],
        ),
      ),
    );
  }
}
