import "package:flutter/widgets.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/media_content_type.dart";
import "../../classes/medias/media_entry.dart";
import "../../globals.dart";
import "../images/covering_network_image.dart";

/// A widget displaying a single media entry
class MediaEntryWidget extends StatelessWidget {
  // VARIABLES =================================================================

  /// The entry being displayed.
  final MediaEntry entry;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaEntryWidget] instance.
  const MediaEntryWidget(this.entry, {super.key});

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    switch (entry.type) {
      // Text entry
      case MediaContentType.text:
        return XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
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
        return Column(
          children: [
            XContainer(
              child: MarkdownBody(
                data:
                    "From the project's github [README.md](${entry.content}):",
                styleSheet: app.themes.markdownStyle,
              ),
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
        );

      // Default entry (empty)
      default:
        return const SizedBox();
    }
  }

  // METHODS ===================================================================
}
