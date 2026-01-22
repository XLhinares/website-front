import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/background_data.dart";
import "../../globals.dart";
import "../../utils/tools.dart";

/// A widget allowing the user to preview a theme.
class BackgroundPreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The contents of the theme being previewed.
  final BackgroundData data;

  // CONSTRUCTOR ===============================================================

  /// Returns a [BackgroundPreview] matching the given parameters.
  const BackgroundPreview(
    this.data, {
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: XLayout.brcXS,
      child: Obx(() => XButton(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            borderDecoration: app.cookies.background.value == data.name
                ? Border.all(width: 2, color: Colors.black45)
                : null,
            onTap: () => app.cookies.background.value = data.name,
            child: Stack(
              children: [
                Positioned.fill(
                    child: data.preview(context) ?? const SizedBox()),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: context.theme.colorScheme.surface.withAlpha(150),
                    padding: EdgeInsets.all(XLayout.paddingXS),
                    child: Center(
                        child: AutoSizeText(
                      data.name.capitalizeFirst!.tr,
                      style: context.bodyMediumOnSurface,
                      maxLines: 1,
                    )),
                  ),
                )
              ],
            ),
          )),
    );
  }

// WIDGETS ===================================================================
}
