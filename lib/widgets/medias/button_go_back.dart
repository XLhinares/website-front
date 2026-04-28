import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media_type.dart";
import "../../globals.dart";

/// A button to go back to use in media display.
class MediaButtonGoBack extends StatelessWidget {
  // VARIABLES =================================================================

  /// The type ofmedia being displayed.
  ///
  /// It lets the router cancel a focused media if needed.
  final MediaType type;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButtonGoBack] instance.
  const MediaButtonGoBack({super.key, required this.type});

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: XButton(
        enableShadow: false,
        onTap: () {
          final type = this.type;
          if (type == MediaType.project) return router.selectProject(null);
          if (type == MediaType.blog) return router.selectBlog(null);
          return router.goBack(soft: true);
        },
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_left,
              size: XLayout.paddingM,
            ),
            Text(
              "button_back".tr,
              style: context.textTheme.labelSmall,
            ),
            XLayout.horizontalXS,
          ],
        ),
      ),
    );
  }
}
