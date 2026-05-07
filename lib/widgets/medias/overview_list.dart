import "dart:math";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../medias/preview_wide.dart";

/// A list of the projects.
///
/// It is displayed in the project page on mobile.
class MediaListView extends StatefulWidget {
  /// The list of medias being displayed.
  final List<Media> medias;

  /// Behavior when a media tile is tapped.
  final void Function(Media media) onTapMedia;

  /// Optional behavior when the "see more" button is clicked.
  final void Function()? onTapSeeMore;

  /// Optional padding around the listview.
  final EdgeInsets? padding;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaListView] instance.
  const MediaListView({
    super.key,
    required this.medias,
    required this.onTapMedia,
    this.onTapSeeMore,
    this.padding,
  });

  @override
  State<MediaListView> createState() => _MediaListViewState();
}

class _MediaListViewState extends State<MediaListView> {
  final GlobalKey _itemKey = GlobalKey();
  final GlobalKey _seeMoreKey = GlobalKey();

  late final bool hasSeeMore = widget.onTapSeeMore != null;
  late final _minItemCount = hasSeeMore ? 2 : 1;
  late int _itemCount = _minItemCount;
  double maxHeight = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: app.medias,
        tag: "overview_list",
        builder: (_) {
          _computeItemCountCallback();
          return widget.medias.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: context.colors.secondary,
                  ),
                )
              : LayoutBuilder(builder: (context, constraints) {
                  maxHeight = constraints.maxHeight;
                  final bool boundedHeight = maxHeight != double.infinity;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: widget.padding,
                    shrinkWrap: true,
                    itemCount: boundedHeight && hasSeeMore
                        ? _itemCount
                        : widget.medias.length,
                    itemBuilder: (context, index) {
                      // Last item (see more)
                      if (hasSeeMore && index == _itemCount - 1) {
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
        });
  }

  void _computeItemCountCallback() {
    if (_itemCount > _minItemCount) return;
    if (maxHeight == double.infinity) {
      dlog("Infinite vertical space provided, "
          "no need to compute item count.");
      return;
    }

    if (!hasSeeMore) {
      dlog("No [seeMore] provided, "
          "all the media will be displayed.");
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dlog("Recomputing the itemCount...");
      final RenderBox? itemRenderBox =
          _itemKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? seeMoreRenderBox =
          _seeMoreKey.currentContext?.findRenderObject() as RenderBox?;
      if (itemRenderBox != null && mounted) {
        final double itemHeight = itemRenderBox.size.height;
        final double seeMoreHeight = seeMoreRenderBox?.size.height ?? 0;

        dlog("Max height: $maxHeight");
        dlog("Item height: $itemHeight");
        dlog("See more height: $seeMoreHeight");
        dlog("Item count: $_itemCount");
        dlog("Max item count: ${widget.medias.length}");
        setState(() {
          _itemCount = min(
                widget.medias.length,
                (maxHeight -
                        seeMoreHeight -
                        (widget.padding?.top ?? 0) -
                        (widget.padding?.bottom ?? 0)) ~/
                    itemHeight,
              ) +
              1;
        });
      }
    });
  }
}
