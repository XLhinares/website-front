import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:glass/glass.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/media.dart";
import "../../widgets/widgets.dart";

/// A preview of a project.
class ProjectWidePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Media project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectWidePreview] matching the given parameters.
  const ProjectWidePreview({super.key, required this.project, this.onTap});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: context.theme.shadowColor,
        child: SizedBox(
          width: Get.width,
          height: XLayout.paddingS * 20,
          child: Stack(
            children: [
              // IMAGE -------------------------------------------------------------
              Positioned.fill(
                child: CoveringNetworkImage(
                  project.preview,
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(XLayout.paddingM),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(XLayout.paddingM),
                      color: context.theme.colorScheme.primary.withOpacity(0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // NAME ------------------------------------------------------
                          Text(
                            project.name,
                            style: context.textTheme.titleMedium,
                          ),

                          XLayout.verticalS,
                          const Divider(),
                          XLayout.verticalS,

                          // SUMMARY ---------------------------------------------------
                          AutoColorText(
                            project.summary,
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ).asGlass(clipBorderRadius: XLayout.brcXS),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// METHODS ===================================================================

}
