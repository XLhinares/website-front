import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../medias/preview_wide.dart";

/// A list of the projects.
///
/// It is displayed in the project page on mobile.
/// It can have unlimited height (project page) or bound height ()
class MediaListView extends StatelessWidget {
  /// The list of medias being displayed.
  final List<Media> medias;

  /// Behavior when a media is tapped.
  final void Function(Media media) onTapMedia;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaListView] instance.
  const MediaListView({
    super.key,
    required this.medias,
    required this.onTapMedia,
  });

  @override
  Widget build(BuildContext context) {
    if (medias.isEmpty) {
      return CircularProgressIndicator(
        color: context.colors.secondary,
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: XLayout.paddingL * 1.5 + XLayout.paddingM * 2,
        bottom: XLayout.paddingM,
        left: XLayout.paddingM,
        right: XLayout.paddingM,
      ),
      itemCount: medias.length,
      itemBuilder: (context, index) => MediaPreviewWide(
        media: medias[index],
        onTap: () => onTapMedia(medias[index]),
      ),
    );
  }
}
