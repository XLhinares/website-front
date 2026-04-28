import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";

/// A button that shows a media's ownership status.
///
/// It is useless if the media doesn't have a website.
class MediaStatusWidget extends StatelessWidget {
  // VARIABLES =================================================================

  /// The matching media.
  final Media media;

  /// Whether the button should be replaced by an empty `SizedBox` when the website is null.
  final bool hideIfOwner;

  /// Whether to show only the button icon (and NOT the button box)
  final bool iconOnly;

  /// An optional margin to put around the button.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaStatusWidget] instance.
  const MediaStatusWidget({
    super.key,
    required this.media,
    this.margin,
    this.hideIfOwner = true,
    this.iconOnly = false,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    if (hideIfOwner && !media.isOwner) return SizedBox();

    return Tooltip(
      message: "project_status_${media.status}_tooltip".tr,
      child: iconOnly
          ? Icon(
              Icons.group,
              color: context.colors.secondary,
            )
          : XButton(
              margin: margin ?? EdgeInsets.only(left: XLayout.paddingS),
              padding: XLayout.edgeInsetsAllXS,
              width: XLayout.paddingL,
              height: XLayout.paddingL,
              color: context.colors.secondary,
              child: Icon(
                Icons.group,
                color: context.colors.onSecondary,
              ),
            ),
    );
  }

  // METHODS ===================================================================
}
