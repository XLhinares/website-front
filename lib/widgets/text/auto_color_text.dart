import "dart:ui";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";

import "../../utils/exports.dart";

/// A custom String class carrying style codes that can be used for display.
class CodeText {
  // VARIABLES =================================================================

  /// The raw text.
  final String text;

  /// An extra line of arguments.
  final String extra;

  // GETTERS ===================================================================

  /// Whether the text should be written in a (b)old font.
  final bool isBold;

  /// Whether the text should be written in a (c)olored font.
  final bool isColored;

  /// Whether the text should be written in an (i)talics font.
  final bool isItalics;

  /// Whether the text should be written in a (s)mall caps font.
  final bool isSmallCaps;

  /// Whether the text should send to a named route.
  final bool isRoute;

  /// Whether the text should send to a given link.
  final bool isLink;

  // CONSTRUCTOR ===============================================================

  /// Returns a [CodeText] matching the given parameters.
  CodeText(
    this.text, {
    this.isBold = false,
    this.isColored = false,
    this.isItalics = false,
    this.isSmallCaps = false,
    this.isRoute = false,
    this.isLink = false,
    this.extra = "",
  });

  ///
  factory CodeText.parse(String text, {String code = "", String extra = ""}) {
    if (code.isEmpty) return CodeText(text);

    return CodeText(
      text,
      extra: extra,
      isBold: code.contains(RegExp(r"bold|title")),
      isColored: code.contains(RegExp(r"color|title|route|link")),
      isItalics: code.contains("italics"),
      isSmallCaps: code.contains("smcp"),
      isRoute: code.contains("route"),
      isLink: code.contains("link"),
    );
  }
}

/// A widget that parses tags in a string and displays it customized.
class AutoColorText extends StatelessWidget {
  // VARIABLES =================================================================

  /// The text that needs auto-coloring.
  final String text;

  /// The default style of the auto-colored text.
  final TextStyle? style;

  /// The color of colored text.
  ///
  /// By default it takes the theme's secondary color.
  final Color? highlightColor;

  /// The maximum number of lines allowed to be displayed in the text.
  final int? maxLines;

  /// The behavior when the full text cannot be displayed.
  final TextOverflow? overflow;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AutoColorText] matching the given parameters.
  const AutoColorText(
    this.text, {
    Key? key,
    this.style,
    this.highlightColor,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: _coloredText(context)),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }

  // METHODS ===================================================================

  /// Returns a list of the different text elements split by style.
  ///
  /// The different style codes are:
  /// - n: normal
  /// - b: bold
  /// - c: colored
  /// - i: italics
  /// - r: route
  /// - l: link
  ///
  /// The returned value looks like:
  /// [["bc", "lorem ipsum"],
  ///  ["n", "sit amet"]]
  List<CodeText> _parseText() {
    // A regex which matches the pattern "\_{__}{___}"
    final RegExp specialExp = RegExp(r"\\([^{}])+({[^{}]*})+", dotAll: true);

    // A split of the normal text.
    final Iterable<CodeText> splitText =
        text.split(specialExp).map((text) => CodeText(text));

    // A split of the special text.
    // First, it is matched by the regex.
    // Then, the matches are split to obtain the fragments between brackets.
    // Finally, the fragments are passed to the [CodeText].
    final Iterable<CodeText> specialText = (specialExp
        .allMatches(text)
        .map((match) => match[0] ?? "}{")).map((match) {
      final split = match.split("{");
      final List<String> res = [];
      for (final value in split) {
        res.add(value.replaceAll(RegExp("\\|{|}"), ""));
      }
      return CodeText.parse(res.last, code: res[0], extra: res[1]);
    });

    Iterable<T> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
      final itA = a.iterator;
      final itB = b.iterator;
      bool hasA, hasB;
      while ((hasA = itA.moveNext()) | (hasB = itB.moveNext())) {
        if (hasA) yield itA.current;
        if (hasB) yield itB.current;
      }
    }

    final List<CodeText> result =
        zip<CodeText>(splitText, specialText).toList();
    return result;
  }

  List<TextSpan> _coloredText(BuildContext context) {
    final List<TextSpan> tmp = [];
    final parsedText = _parseText();
    for (int i = 0; i < parsedText.length; i++) {
      final part = parsedText[i];

      // print("part: ${part.text}; code: ${part.code}");

      Color color = context.textTheme.titleMedium!.color!;
      FontWeight fWeight = FontWeight.normal;
      FontStyle fStyle = FontStyle.normal;
      List<FontFeature> fFeatures = [];

      // Check for special attributes.
      if (part.isColored) color = context.theme.colorScheme.secondary;
      if (part.isBold) fWeight = FontWeight.w800;
      if (part.isItalics) fStyle = FontStyle.italic;
      if (part.isSmallCaps) fFeatures.add(const FontFeature.enable("smcp"));

      final GestureRecognizer? gestureRecognizer = part.isRoute || part.isLink
          ? (TapGestureRecognizer()
            ..onTap = () async {
              if (part.isRoute) router.push(path: part.extra);
              if (part.isLink) {
                final uri = Uri.parse(part.extra);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw "Could not launch ${part.extra}";
                }
              }
            })
          : null;

      tmp.add(
        TextSpan(
          text: part.text,
          style: DefaultTextStyle.of(context).style.merge(style).copyWith(
                color: color,
                fontWeight: fWeight,
                fontStyle: fStyle,
                fontFeatures: fFeatures,
              ),
          recognizer: gestureRecognizer,
        ),
      );
    }

    return tmp;
  }
}
