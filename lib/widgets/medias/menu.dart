import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../menu/desktop_title.dart";
import "preview_wide.dart";

/// The half of the body containing the title and the menu.
class MediaSideMenu extends StatelessWidget {
  // VARIABLES =================================================================

  /// The list of medias displayed in the menu.
  final List<Media> medias;

  /// Optional horizontal extent of the menu.
  final double? width;

  /// Behavior when a media is tapped.
  final void Function(Media media) onTapMedia;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaSideMenu] matching the given parameters.
  const MediaSideMenu({
    super.key,
    required this.medias,
    required this.onTapMedia,
    this.width,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      width: width,
      child: Column(
        children: [
          const BodyTitle(),

          // SEPARATOR
          XLayout.verticalM,

          Expanded(
            child: XContainer(
              padding: EdgeInsets.zero,
              child: medias.isEmpty
                  ? LinearProgressIndicator(
                      color: context.colors.secondary,
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(XLayout.paddingM),
                      itemCount: medias.length,
                      itemBuilder: (context, index) => MediaPreviewWide(
                        showBox: false,
                        media: medias[index],
                        onTap: () => onTapMedia(medias[index]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
