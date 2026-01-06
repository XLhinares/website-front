import "package:flutter/material.dart";
import "package:get/get_utils/get_utils.dart";
import "package:x_containers/x_containers.dart";

/// A custom [Button] widget based on [XButton].
class XFlatButton extends StatelessWidget {
  // VARIABLES =================================================================

  /// {@macro x_containers.docs.alignment}
  final AlignmentGeometry? alignment;

  /// {@macro x_containers.docs.borderDecoration}
  final BoxBorder? borderDecoration;

  /// {@macro x_containers.docs.borderRadius}
  final BorderRadius? borderRadius;

  /// {@macro x_containers.docs.color}
  final Color? color;

  /// {@macro x_containers.docs.constraints}
  final BoxConstraints? constraints;

  /// {@macro x_containers.docs.enableShadow}
  final bool? enableShadow;

  /// {@macro x_containers.docs.enableSplash}
  final bool? enableSplash;

  /// {@macro x_containers.docs.gradient}
  final Gradient? gradient;

  /// {@macro x_containers.docs.height}
  final double? height;

  /// {@macro x_containers.docs.margin}
  final EdgeInsetsGeometry? margin;

  /// {@macro x_containers.docs.onLongPress}
  final void Function()? onLongPress;

  /// {@macro x_containers.docs.onTap}
  final void Function()? onTap;

  /// {@macro x_containers.docs.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro x_containers.docs.shadowColor}
  final Color? shadowColor;

  /// {@macro x_containers.docs.splashColor}
  final Color? splashColor;

  /// {@macro x_containers.docs.width}
  final double? width;

  /// {@macro x_containers.docs.child}
  final Widget child;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [XFlatButton] matching the given parameters.
  const XFlatButton({
    super.key,
    this.alignment,
    this.borderDecoration,
    this.borderRadius,
    this.color,
    this.constraints,
    this.enableShadow = false,
    this.enableSplash,
    this.gradient,
    this.height,
    this.margin,
    this.onLongPress,
    this.onTap,
    this.padding,
    this.shadowColor,
    this.splashColor,
    this.width,
    required this.child,
  });

  /// A constructor for XButtons only containing text
  factory XFlatButton.text({
    Key? key,
    AlignmentGeometry? alignment,
    BoxBorder? borderDecoration,
    BorderRadius? borderRadius,
    Color? color,
    BoxConstraints? constraints,
    bool? enableShadow = false,
    bool? enableSplash,
    Gradient? gradient,
    double? height,
    EdgeInsetsGeometry? margin,
    void Function()? onLongPress,
    void Function()? onTap,
    EdgeInsetsGeometry? padding,
    Color? shadowColor,
    Color? splashColor,
    double? width,
    required String text,
    TextStyle? textStyle,
  }) =>
      XFlatButton(
        key: key,
        alignment: alignment,
        borderDecoration: borderDecoration,
        borderRadius: borderRadius,
        color: color,
        constraints: constraints,
        enableShadow: enableShadow,
        enableSplash: enableSplash,
        gradient: gradient,
        height: height,
        margin: margin,
        onLongPress: onLongPress,
        onTap: onTap,
        padding: padding,
        shadowColor: shadowColor,
        splashColor: splashColor,
        width: width,
        child: Text(text, style: textStyle),
      );

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XButton(
      alignment: alignment,
      borderDecoration: borderDecoration,
      borderRadius: borderRadius,
      color: color ?? context.theme.colorScheme.secondary,
      constraints: constraints,
      enableShadow: enableShadow,
      enableSplash: enableSplash,
      gradient: gradient,
      height: height,
      key: key,
      margin: margin,
      onLongPress: onLongPress,
      onTap: onTap,
      padding: padding,
      shadowColor: shadowColor,
      splashColor: splashColor,
      width: width,
      child: child,
    );
  }
}
