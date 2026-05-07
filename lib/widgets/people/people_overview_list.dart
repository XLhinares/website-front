import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../medias/preview_tile.dart";

///
class PersonOverviewList extends StatelessWidget {
  // VARIABLES =================================================================

  /// A controller for the listview
  ///
  /// Used to connect the left/right buttons and the listview.
  final ScrollController _scrollController = ScrollController();

  /// The title of this box.
  final String title;

  /// The list of persons displayed in this box.
  final List<Media> persons;

  // CONSTRUCTOR ===============================================================

  /// Returns a [PersonOverviewList] instance.
  PersonOverviewList({
    super.key,
    required this.title,
    required this.persons,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    // Layout builder lets us compute the width of cards so a exact number of them fit in the display.
    return LayoutBuilder(builder: (context, constraints) {
      final baseCardWidth = XLayout.paddingL * 6;
      final baseCardCount = constraints.maxWidth / baseCardWidth;
      final roundedCardCount = baseCardCount.floorToDouble();

      // If the max width lets us put less than 3 cards, then just use standard width.
      // Otherwise if

      final double cardSpacing = XLayout.paddingM;
      final double cardWidth = baseCardCount < 3
          ? baseCardWidth
          : (constraints.maxWidth - (roundedCardCount - 1) * cardSpacing) /
              roundedCardCount;
      final double cardHeight = cardWidth * 4 / 3;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE ROW --------------------------------------------------------
          XContainer(
            padding: XLayout.edgeInsetsAllS,
            height: XLayout.paddingL * 1.5,
            child: Row(
              children: [
                XLayout.horizontalS,
                Text(
                  title.tr,
                  // style: context.textTheme.bodyLarge,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                // Move left
                AspectRatio(
                  aspectRatio: 1,
                  child: XButton(
                    padding: EdgeInsets.zero,
                    onTap: () => _scrollController.animateTo(
                        _scrollController.offset - cardWidth - cardSpacing,
                        duration: animDurationShort,
                        curve: Curves.bounceIn),
                    color: context.colors.surface,
                    enableShadow: false,
                    child: Icon(
                      Icons.chevron_left,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
                XLayout.horizontalS,
                // Move right
                AspectRatio(
                  aspectRatio: 1,
                  child: XButton(
                    padding: EdgeInsets.zero,
                    onTap: () => _scrollController.animateTo(
                        _scrollController.offset + cardWidth + cardSpacing,
                        duration: animDurationShort,
                        curve: Curves.bounceIn),
                    color: context.colors.surface,
                    enableShadow: false,
                    child: Icon(
                      Icons.chevron_right,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          XLayout.verticalM,

          // LIST VIEW --------------------------------------------------------
          SizedBox(
            height: cardHeight,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: persons.length + 1,
              separatorBuilder: (_, __) => SizedBox(
                width: cardSpacing,
              ),
              itemBuilder: (context, index) {
                if (index == persons.length) {
                  return XContainer(
                    width: cardWidth,
                    height: cardHeight,
                    padding: XLayout.edgeInsetsAllM,
                    color: context.colors.primary.asHint,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "people_card_your_name_here".tr,
                          textAlign: TextAlign.center,
                        ),
                        XLayout.verticalS,
                        XButton.text(
                          "contact_me".tr,
                          color: context.colors.secondary,
                          textStyle: context.bodyMediumOnSecondary,
                          onTap: () => router.goTo(AppRoute.PAGE_CONTACT),
                        )
                      ],
                    ),
                  );
                }

                return SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: MediaPreviewTile(
                    media: persons[index],
                    onTap: (media) => router.selectPerson(media.id),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  // METHODS ===================================================================
}
