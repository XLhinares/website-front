import "dart:math";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../medias/preview_wide.dart";

/// A list of the projects.
///
/// It is displayed in the project page on mobile.
class MediaListViewExcerpt extends StatefulWidget {
  /// The list of medias being displayed.
  final List<Media> medias;

  final void Function(Media media) onTapMedia;

  /// Optional behavior when the "see more" button is clicked.
  final void Function() onTapSeeMore;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaListViewExcerpt] instance.
  const MediaListViewExcerpt({
    super.key,
    required this.medias,
    required this.onTapMedia,
    required this.onTapSeeMore,
  });

  @override
  State<MediaListViewExcerpt> createState() => _MediaListViewExcerptState();
}

class _MediaListViewExcerptState extends State<MediaListViewExcerpt> {
  final GlobalKey _itemKey = GlobalKey();
  final GlobalKey _seeMoreKey = GlobalKey();
  late final _minItemCount = 2;
  late int _itemCount = _minItemCount;
  double maxHeight = 0;

  @override
  Widget build(BuildContext context) {
    if (_itemCount == _minItemCount && widget.medias.isNotEmpty) {
      _computeItemCountCallback();
    } else {
      dlog("Item is null or not mounted. Aborting...");
    }
    if (widget.medias.isEmpty) {
      return CircularProgressIndicator(
        color: context.colors.secondary,
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      maxHeight = constraints.maxHeight;
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _itemCount,
        itemBuilder: (context, index) {
          // Last item (see more)
          if (index == _itemCount - 1) {
            return XButton.text(
              "display_more".tr,
              key: _seeMoreKey,
              onTap: widget.onTapSeeMore,
            );
          }

          // Regular item
          return MediaPreviewWide(
            key: index == 0 ? _itemKey : null,
            media: widget.medias[index],
            onTap: () => widget.onTapMedia(widget.medias[index]),
          );
        },
      );
    });
  }

  void _computeItemCountCallback() =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dlog("Recomputing the itemCount...");
        final RenderBox? itemRenderBox =
            _itemKey.currentContext?.findRenderObject() as RenderBox?;
        final RenderBox? seeMoreRenderBox =
            _seeMoreKey.currentContext?.findRenderObject() as RenderBox?;
        if (itemRenderBox != null && seeMoreRenderBox != null && mounted) {
          final double itemHeight = itemRenderBox.size.height;
          final double seeMoreHeight = seeMoreRenderBox.size.height;

          dlog("Max height: $maxHeight");
          dlog("Item height: $itemHeight");
          dlog("See more height: $seeMoreHeight");
          dlog("Item count: $_itemCount");
          setState(() {
            _itemCount = min(
                  widget.medias.length,
                  (maxHeight - seeMoreHeight) ~/ itemHeight,
                ) +
                1;
          });
        }
      });
}
