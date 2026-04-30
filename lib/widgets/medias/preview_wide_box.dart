import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media.dart";
import "../images/covering_network_image.dart";
import "../text/auto_color_text.dart";
import "buttons_row.dart";

/// A preview of a project.
///
/// We need to use a stateful widget because Flutter really wants to use the image's height to render the box. And what we really want is to use the text column's height. So we have to
class MediaWidePreview extends StatefulWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final Media media;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  /// An optional margin object.
  final EdgeInsets? margin;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaWidePreview] matching the given parameters.
  const MediaWidePreview({
    super.key,
    required this.media,
    this.onTap,
    this.margin,
  });

  @override
  State<MediaWidePreview> createState() => _MediaWidePreviewState();
}

class _MediaWidePreviewState extends State<MediaWidePreview> {
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
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => XButton(
        onTap: widget.onTap,
        margin: widget.margin ?? EdgeInsets.only(bottom: XLayout.paddingM),
        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // IMAGE
              SizedBox(
                width: constraints.maxWidth * 0.3,
                height: _columnHeight,
                child: CoveringNetworkImage(
                  widget.media.preview,
                  fit: BoxFit.fitWidth,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(XLayout.paddingXS),
                    bottomLeft: Radius.circular(XLayout.paddingXS),
                  ),
                ),
              ),
              XLayout.horizontalS,
              Expanded(
                child: Column(
                  key: _columnKey,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XLayout.verticalXS,
                    // TITLE ROW
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            XLayout.verticalXS,
                            Text(
                              widget.media.title,
                              style: context.textTheme.titleMedium
                                  ?.copyWith(height: 1.1),
                            ),
                            if (widget.media.hasSubtitle)
                              Text(
                                widget.media.subtitle!,
                                style: context.textTheme.labelSmall,
                              ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
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
                    XLayout.verticalXS,
                  ],
                ),
              ),
              XLayout.horizontalS,
            ],
          ),
        ),
      ),
    );
  }
}
