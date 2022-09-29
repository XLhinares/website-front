import "package:flutter/material.dart";

import "preset_styles.dart";


/// A text widget to display string with a custom preset.
class PresetText extends StatelessWidget {

  // VARIABLES =================================================================

  /// The string being displayed.
  final String value;

  /// The preset to use.
  final PresetStyle? preset;

  // CONSTRUCTOR ===============================================================

  /// Returns a text widget using the preset.
  const PresetText._internal(this.value, {
    this.preset,
  });

  /// A text widget preset to be displayed as a title.
  factory PresetText.xeppelin () => const PresetText._internal("Xeppelin",
    preset: PresetStyle.display,
  );

  /// A text widget preset to be displayed as a title.
  factory PresetText.title (String value)
  => PresetText._internal(value, preset: PresetStyle.title,);

  /// A text widget preset to be displayed as a headline.
  factory PresetText.headline (String value)
  => PresetText._internal(value, preset: PresetStyle.headline,);

  /// A text widget preset to be displayed as a body element.
  factory PresetText.body (String value)
  => PresetText._internal(value, preset: PresetStyle.body,);

  /// A text widget preset to be displayed as a label.
  factory PresetText.label (String value)
  => PresetText._internal(value, preset: PresetStyle.label,);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Text(value, style: preset?.getStyle(context),);
  }
}
