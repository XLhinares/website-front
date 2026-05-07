import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/desktop_header.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/menu.dart";
import "../../widgets/people/no_person_selected.dart";
import "../meta/if_app_is_ready.dart";

/// The
class DesktopPagePeople extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopPagePeople] matching the given parameters.
  const DesktopPagePeople({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    dlog("ON PAGE PERSON!");
    return ScaffoldFit(
      padding: EdgeInsets.symmetric(horizontal: XLayout.paddingL),
      // overlay: ButtonsOverlay(),
      body: IfAppIsReady(
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              // TITLE -----------------------------------------------------
              MediaSideMenu(
                medias: app.medias.persons,
                onTapMedia: (media) => router.selectPerson(media.id),
                width: (constraints.maxWidth - 4 * XLayout.paddingL) / 3,
              ),

              XLayout.horizontalL,

              // CONTENTS --------------------------------------------------
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
                  child: GetBuilder(
                    init: router,
                    builder: (context) => AnimatedSwitcher(
                      duration: animDurationShort,
                      child: router.person == null
                          ? NoPersonSelected()
                          : MediaFocus(
                              media: app.medias.fetchByID(router.person!),
                              headerBuilder: (media, scrollController) =>
                                  MediaDesktopHeader(
                                media: media,
                                scrollController: scrollController,
                              ),
                              partsBuilder: (content) =>
                                  MediaContentWidget(content: content),
                              listViewVerticalPadding: XLayout.paddingL,
                              onBack: () => router.selectPerson(null),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
