import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/extensions.dart";

/// An enumeration of different types of settings tile.
enum SettingsTileType {
  /// A [SettingsTile] with a trailing button.
  button,

  /// A [SettingsTile] with a pair of left / right trailing buttons.
  rotator,

  /// A [SettingsTile] with a trailing toggle button.
  ///
  /// Used for boolean settings.
  toggle,

  /// A [SettingsTile] with a trailing list of actions.
  ///
  /// Used for settings with several buttons.
  actions,

  /// A [SettingsTile] with no trailing elements.
  none,
}

/// The standardized tile for settings
class SettingsTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the tile.
  final String title;

  /// The current value of the tile.
  final String description;

  /// An optional padding value to surround the contents of the tile.
  final EdgeInsets? padding;

  /// The type of tile used.
  ///
  /// It determines the type of trailing widget.
  final SettingsTileType type;

  /// Whether there should be an icon on the left of the tile to show it can be expanded.
  final bool hasExpandableIcon;

  /// An optional observed boolean variable.
  ///
  /// It is currently only used for toggle-type tile.
  final bool? observed;

  /// The behavior when the user selects a setting.
  final List<void Function()> onTap;

  final ExpandableController _controller = ExpandableController();

  /// An optional list of actions widget that appear at the end of the tile.
  final List<Widget>? actions;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsTile] matching the given parameters.
  SettingsTile._internal({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    this.type = SettingsTileType.none,
    this.hasExpandableIcon = true,
    this.actions,
    this.observed,
    this.padding,
  });

  /// A [SettingsTile] with a trailing button.
  factory SettingsTile.button({
    Key? key,
    required String title,
    required String description,
    required void Function() onTap,
    bool hasExpandableIcon = true,
    EdgeInsets? padding,
  }) =>
      SettingsTile._internal(
        key: key,
        onTap: [onTap],
        title: title,
        description: description,
        type: SettingsTileType.button,
        hasExpandableIcon: hasExpandableIcon,
        padding: padding,
      );

  /// A [SettingsTile] with a pair of left / right trailing buttons.
  factory SettingsTile.rotator({
    Key? key,
    required String title,
    required String description,
    required void Function() onTapLeft,
    required void Function() onTapRight,
    bool hasExpandableIcon = true,
    EdgeInsets? padding,
  }) =>
      SettingsTile._internal(
        key: key,
        onTap: [onTapLeft, onTapRight],
        title: title,
        description: description,
        type: SettingsTileType.rotator,
        hasExpandableIcon: hasExpandableIcon,
        padding: padding,
      );

  /// A [SettingsTile] with a trailing toggle buttons.
  factory SettingsTile.toggle({
    Key? key,
    required String title,
    required String description,
    required bool observed,
    required void Function(bool enabled) onTap,
    bool hasExpandableIcon = true,
    EdgeInsets? padding,
  }) =>
      SettingsTile._internal(
        key: key,
        onTap: [() => onTap(true), () => onTap(false)],
        title: title,
        description: description,
        type: SettingsTileType.toggle,
        hasExpandableIcon: hasExpandableIcon,
        observed: observed,
        padding: padding,
      );

  /// A [SettingsTile] with a trailing toggle buttons.
  factory SettingsTile.actions({
    Key? key,
    required String title,
    required String description,
    required List<Widget> actions,
    bool hasExpandableIcon = true,
    EdgeInsets? padding,
  }) =>
      SettingsTile._internal(
        key: key,
        title: title,
        description: description,
        type: SettingsTileType.actions,
        actions: actions,
        hasExpandableIcon: hasExpandableIcon,
        onTap: [],
        padding: padding,
      );

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XButton(
      onTap: () => _controller.toggle(),
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: XLayout.paddingS,
            horizontal: XLayout.paddingS,
          ),
      child: ExpandableTheme(
        data: ExpandableThemeData(
          hasIcon: hasExpandableIcon,
          iconPlacement: ExpandablePanelIconPlacement.left,
          iconColor: context.textTheme.bodyMedium?.color ?? Colors.white,
          // expandIcon: Icons.help,
          // iconPadding: EdgeInsets.zero,
          useInkWell: false,
        ),
        child: ExpandablePanel(
          controller: _controller,
          header: Row(
            children: [
              XLayout.horizontalS,
              Flexible(
                fit: FlexFit.loose,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: Get.width * .7),
                  child: Text(
                    title.tr,
                    style: context.textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                ),
              ),
              XLayout.horizontalS,
              _trailing(context),
            ],
          ),
          collapsed: const SizedBox(),
          expanded: Padding(
            padding: EdgeInsets.only(top: XLayout.paddingXS),
            child: Text(description.tr),
          ),
        ),
      ),
    );
  }

  // WIDGETS ===================================================================

  Widget _trailing(BuildContext context) {
    switch (type) {
      case SettingsTileType.button:
        assert(onTap.length == 1);
        return XButton(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.all(XLayout.paddingS),
          enableShadow: false,
          color: context.colors.secondary,
          onTap: onTap[0],
          child: Icon(Icons.chevron_right, color: context.colors.onSecondary),
        );
      case SettingsTileType.rotator:
        assert(onTap.length == 2);
        return Row(
          children: [
            XButton(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(XLayout.paddingS),
              enableShadow: false,
              color: context.colors.secondary,
              onTap: onTap[0],
              child: Icon(Icons.arrow_left, color: context.colors.onSecondary),
            ),
            XLayout.horizontalS,
            XButton(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(XLayout.paddingS),
              enableShadow: false,
              color: context.colors.secondary,
              onTap: onTap[1],
              child: Icon(Icons.arrow_right, color: context.colors.onSecondary),
            ),
          ],
        );
      case SettingsTileType.toggle:
        assert(observed != null);
        return Switch(
          value: observed!,
          activeThumbColor: context.colors.secondary,
          activeTrackColor: context.colors.surface,
          onChanged: (value) => value ? onTap[0].call() : onTap[1].call(),
        );
      case SettingsTileType.actions:
        assert(actions != null);
        return Wrap(
          spacing: XLayout.paddingXS,
          children: actions!,
        );
      default:
        return const SizedBox();
    }
  }
}
