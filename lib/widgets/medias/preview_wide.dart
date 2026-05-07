import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../../utils/extensions.dart";
import "../images/covering_network_image.dart";
import "../text/auto_color_text.dart";
import "buttons_row.dart";

/// A preview of a project.
///
/// We need to use a stateful widget because Flutter really wants to use the image's height to render the box. And what we really want is to use the text column's height. So we have to
class MediaPreviewWide extends StatefulWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  /// Whether to show a box around the contents.
  ///
  /// Useful for [MenuMediaList] or [MobilePageProjects].
  final bool showBox;

  /// An optional margin object.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaPreviewWide] matching the given parameters.
  const MediaPreviewWide({
    super.key,
    required this.media,
    this.onTap,
    this.showBox = true,
    this.margin,
  });

  @override
  State<MediaPreviewWide> createState() => _MediaPreviewWideState();
}

class _MediaPreviewWideState extends State<MediaPreviewWide> {
  final GlobalKey _columnKey = GlobalKey();
  double _columnHeight = 0;

  @override
  void initState() {
    super.initState();
    // Schedule a post-frame callback to measure the column height after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _columnKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && mounted) {
        setState(() {
          _columnHeight = renderBox.size.height;
          if (_columnHeight < 0) _columnHeight = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => XButton(
        onTap: widget.onTap,
        color: widget.showBox ? context.colors.primary : Colors.transparent,
        enableShadow: widget.showBox,
        margin: widget.margin ?? EdgeInsets.only(bottom: XLayout.paddingM),
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            // IMAGE
            SizedBox(
              width: constraints.maxWidth * 0.3,
              height: _columnHeight,
              child: CoveringNetworkImage(
                widget.media.preview,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(XLayout.paddingXS),
                  bottomLeft: Radius.circular(XLayout.paddingXS),
                ),
              ),
            ),
            XLayout.horizontalS,

            Expanded(
              key: _columnKey,
              child: Padding(
                padding: widget.showBox
                    ? EdgeInsets.only(
                        top: XLayout.paddingS,
                        bottom: XLayout.paddingS,
                        right: XLayout.paddingS,
                      )
                    : EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE ROW
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.media.title,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(height: 1.1),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.media.hasSubtitle)
                                Text(
                                  widget.media.subtitle!,
                                  style: context.textTheme.labelSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        XLayout.horizontalXS,
                        MediaButtonRow(
                          media: widget.media,
                        ),
                      ],
                    ),
                    XLayout.verticalS,

                    // DESCRIPTION
                    AutoColorText(
                      "${widget.media.summary}\n\n",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
