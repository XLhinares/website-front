import "dart:ui";
import "package:flutter/material.dart";
import "package:get/get.dart";

/// A custom String class carrying style codes that can be used for display.
class CodeText {

  // VARIABLES =================================================================

  /// A chain of identifiers for the special fonts.
  final String code;

  /// The raw text.
  final String text;

  // GETTERS ===================================================================

  /// Whether the text should be written in a (n)ormal font.
  bool get isNormal => code.contains("n");

  /// Whether the text should be written in a (b)old font.
  bool get isBold => code.contains("b");

  /// Whether the text should be written in a (c)olored font.
  bool get isColored => code.contains("c");

  /// Whether the text should be written in an (i)talics font.
  bool get isItalics => code.contains("i");

  /// Whether the text should be written in a (s)mall caps font.
  bool get isSmallCaps => code.contains("s");

  // CONSTRUCTOR ===============================================================

  /// Returns a [CodeText] matching the given parameters.
  CodeText(this.text, {
    this.code = "n",
  });
}

/// A widget that parses tags in a string and displays it customized.
class AutoColorText extends StatelessWidget {

  // VARIABLES =================================================================

  /// The text that needs auto-coloring.
  final String text;

  /// The default style of the auto-colored text.
  final TextStyle? defaultStyle;

  /// The color of colored text.
  ///
  /// By default it takes the theme's secondary color.
  final Color? highlightColor;

  // GETTERS ===================================================================

  /// Returns a list of the different text elements split by style.
  ///
  /// The different style codes are:
  /// - n: normal
  /// - b: bold
  /// - c: colored
  /// - i: italics
  ///
  /// The returned value looks like:
  /// [["bc", "lorem ipsum"],
  ///  ["n", "sit amet"]]
  List<CodeText> get _parsedText {
    List<CodeText> result = [];

    List<String> splitText = text.split("%");

    for (int i = 0 ; i < splitText.length ; i++) {
      late String part;
      late String code;
      if (i.isEven) {
        // Normal text
        part = splitText[i];
        code = "n";
      } else {
        // Special text
        int codeSize = splitText[i].indexOf(" ");
        code = splitText[i].substring(0, codeSize);
        part = splitText[i].substring(codeSize + 1);
      }

      result.add(CodeText(part, code: code));
    }

    return result;
  }

  List<TextSpan> get _coloredText {
    final List<TextSpan> tmp = [];

    for (int i = 0 ; i < _parsedText.length ; i++) {

      final part = _parsedText[i];

      // print("part: ${part.text}; code: ${part.code}");

      Color color = Get.textTheme.titleMedium!.color!;
      FontWeight fWeight = FontWeight.normal;
      FontStyle fStyle = FontStyle.normal;
      List<FontFeature> fFeatures = [];

      // Check for special attributes.
      if (part.isColored) color = Get.theme.colorScheme.secondary;
      if (part.isBold) fWeight = FontWeight.w800;
      if (part.isItalics) fStyle = FontStyle.italic;
      if (part.isSmallCaps) fFeatures.add(const FontFeature.enable("smcp"));

      tmp.add(TextSpan(
        text: part.text,
        style: (defaultStyle ?? Get.textTheme.bodyMedium ?? const TextStyle())
            .copyWith(
          color: color,
          fontWeight: fWeight,
          fontStyle: fStyle,
          fontFeatures: fFeatures,
        ),
      ),);
    }

    return tmp;
  }

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AutoColorText] matching the given parameters.
  const AutoColorText(this.text, {
    Key? key,
    this.defaultStyle,
    this.highlightColor,
  }) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: _coloredText
      ),
    );
  }

// METHODS ===================================================================

}
