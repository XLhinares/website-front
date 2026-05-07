import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../widgets/medias/desktop_header.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/people/person_overview_page.dart";

/// The content of the body in the "Projects" mode.
class DesktopMainPeople extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainPeople] matching the given parameters.
  const DesktopMainPeople({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (context) => AnimatedSwitcher(
        duration: animDurationShort,
        child: router.person == null
            ? PersonOverviewPage()
            : MediaFocus(
                media: app.medias.fetchByID(router.person!),
                headerBuilder: (media, scrollController) => MediaDesktopHeader(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) => MediaContentWidget(content: content),
                listViewVerticalPadding: XLayout.paddingL,
                onBack: () => router.selectPerson(null),
              ),
      ),
    );
  }

// METHODS ===================================================================
}
