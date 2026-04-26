import "package:flutter/material.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media_content.dart";
import "../../classes/medias/media_content_type.dart";
import "../../classes/medias/media_entry.dart";
import "../../globals.dart";
import "../images/covering_network_image.dart";

/// A widget displaying the parts of the given media on desktop.
class MediaMobileContent extends StatelessWidget {
  // VARIABLES =================================================================

  /// The parts of the media.
  final MediaContent content;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaMobileContent] matching the given parameters.
  const MediaMobileContent({
    super.key,
    required this.content,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: content.entries.length,
      padding: EdgeInsets.only(bottom: XLayout.paddingM),
      itemBuilder: (context, index) => _entryWidget(content.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalM,
    );
  }

  // WIDGETS ===================================================================

  Widget _entryWidget(MediaEntry entry) {
    switch (entry.type) {
      // Text entry
      case MediaContentType.text:
        return XContainer(
          margin: XLayout.edgeInsetsAllM,
          padding: XLayout.edgeInsetsAllM,
          child: MarkdownBody(
            data: entry.content,
            styleSheet: app.themes.markdownStyle,
          ),
        );

      // Image entry
      case MediaContentType.image:
        return CoveringNetworkImage(entry.content);

      // Github entry
      case MediaContentType.github:
        return Padding(
          padding: XLayout.edgeInsetsAllM,
          child: Column(
            children: [
              XContainer(
                child: MarkdownBody(
                    data:
                        "From the project's github [README.md](${entry.content}):"),
              ),
              XLayout.verticalM,
              XContainer(
                padding: XLayout.edgeInsetsAllM,
                child: FutureBuilder<String>(
                  future: app.network.fetchFile(
                    Uri.parse(entry.content),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("media_content_github_error".tr);
                    }
                    if (!snapshot.hasData) {
                      return Text("media_content_github_no_data".tr);
                    }
                    return MarkdownBody(
                      shrinkWrap: true,
                      data: snapshot.data!,
                      styleSheet: app.themes.markdownStyle,
                    );
                  },
                ),
              ),
            ],
          ),
        );

      // Default entry (empty)
      default:
        return const SizedBox();
    }
  }
}
