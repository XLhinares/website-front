import "package:flutter/material.dart";
import "package:get/get.dart";
// import "package:glass/glass.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../utils/tools.dart";
import "../../widgets/images/covering_network_image.dart";
import "../../widgets/images/xeppelin_logo.dart";
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
    return XButton(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: XLayout.brcXS,
        child: Stack(
          children: [
            // IMAGE -------------------------------------------------------------
            Positioned.fill(
              child: CoveringNetworkImage(
                project.preview,
                errorBuilder: (context, object, trace) => const XeppelinLogo(),
              ),
            ),

            Positioned.fill(
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    color: context.theme.colorScheme.surface
                        .withValues(alpha: 0.5),
                    padding: EdgeInsets.all(XLayout.paddingM),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // NAME ------------------------------------------------------
                        Text(
                          project.name,
                          style: context.titleMediumOnSurface,
                        ),

                        XLayout.verticalXS,
                        const Divider(),
                        XLayout.verticalXS,

                        // SUMMARY ---------------------------------------------------
                        AutoColorText(
                          project.summary,
                          style: context.bodyMediumOnSurface,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                  // .asGlass(tintColor: context.theme.colorScheme.background,)
                  ,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
