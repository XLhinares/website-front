import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get_utils/src/extensions/internacionalization.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../classes/medias/media.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../medias/preview_wide_box.dart";
import "../utils/preset_future_builder.dart";

/// A list of the projects.
///
/// It is displayed in the project page on mobile.
class ProjectsListView extends StatefulWidget {
  /// An optional maximum height
  final double? maxHeight;

  /// A list of the projects.
  ///
  /// It is displayed in the project page on mobile.
  const ProjectsListView({super.key, this.maxHeight});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  final GlobalKey _itemKey = GlobalKey();
  final GlobalKey _seeMoreKey = GlobalKey();
  int _itemCount = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.maxHeight == null
        ? PagewiseListView<Media>(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: XLayout.paddingL * 1.5 + XLayout.paddingM * 2,
              bottom: XLayout.paddingM,
              left: XLayout.paddingM,
              right: XLayout.paddingM,
            ),
            pageLoadController: projectLoaderController.controller,
            itemBuilder: (context, entry, index) => MediaWidePreview(
              media: entry,
              onTap: () => router.selectProject(entry.id),
            ),
          )
        : PresetFutureBuilder(
            future: projectLoaderController.controller.pageFuture?.call(0),
            loadingWidget: _loadingWidget,
            builder: (context, snapshot) {
              // Calculate max items based on available height
              if (_itemCount == 2 && (snapshot?.isNotEmpty ?? false)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  dlog("Recomputing the itemCount...");
                  final RenderBox? itemRenderBox =
                      _itemKey.currentContext?.findRenderObject() as RenderBox?;
                  final RenderBox? seeMoreRenderBox = _seeMoreKey.currentContext
                      ?.findRenderObject() as RenderBox?;
                  if (itemRenderBox != null &&
                      seeMoreRenderBox != null &&
                      mounted) {
                    final double itemHeight = itemRenderBox.size.height;
                    final double seeMoreHeight = seeMoreRenderBox.size.height;

                    dlog("Max height: ${widget.maxHeight}");
                    dlog("Item height: $itemHeight");
                    dlog("See more height: $seeMoreHeight");
                    dlog("Item count: $_itemCount");
                    setState(() {
                      _itemCount =
                          (widget.maxHeight! - seeMoreHeight) ~/ itemHeight + 1;
                    });
                  } else {
                    dlog("Item is null or not mounted. Aborting...");
                  }
                });
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  // First item
                  if (index == 0) {
                    return MediaWidePreview(
                      key: _itemKey,
                      media: snapshot![index],
                      onTap: () => router
                          .goTo(AppRoute.parsePageProject(snapshot[index].id)),
                    );
                  }

                  // Last item (see more)
                  if (index == _itemCount - 1) {
                    return XButton.text(
                      "display_more".tr,
                      key: _seeMoreKey,
                      onTap: () => router.goTo(AppRoute.PAGE_PROJECTS),
                    );
                  }

                  // Regular item
                  return MediaWidePreview(
                    media: snapshot![index],
                    onTap: () => router
                        .goTo(AppRoute.parsePageProject(snapshot[index].id)),
                  );
                },
              );
            },
          );
  }

  Widget get _loadingWidget => ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XContainer(
            height: XLayout.paddingM * 7,
          ),
          XLayout.verticalM,
          XButton.text(
            "display_more".tr,
            onTap: () => router.goTo(AppRoute.PAGE_PROJECTS),
          )
        ],
      );
}
