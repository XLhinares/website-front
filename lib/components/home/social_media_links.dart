// Framework dependencies
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";

/// A widget describing what the site is about.
class SocialMediaLinks extends StatelessWidget {
  // VARIABLES =================================================================

  /// The size of the social media icons.
  final double? iconSize;
  double get _iconSize => iconSize ?? XLayout.paddingL;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SocialMediaLinks] matching the given parameters.
  const SocialMediaLinks({
    super.key,
    this.iconSize,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Github
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.github,
            size: _iconSize,
            color: context.colors.onPrimary,
          ),
          onPressed: app.network.openGitHub,
        ),
        // Linkedin
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.linkedin,
            size: _iconSize,
            color: context.colors.onPrimary,
          ),
          onPressed: app.network.openLinkedIn,
        ),
        // Resume
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/icon_cv.svg",
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              context.colors.onPrimary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: app.network.openResume,
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
