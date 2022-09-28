// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "../../text/preset_text.dart";
import "contact_field.dart";

/// The content of the body in the "Projects" mode.
class BodyContentsContact extends StatelessWidget {

  // VARIABLES =================================================================

  /// The controller managing the "name" field.
  final TextEditingController controllerName = TextEditingController();

  /// The controller managing the "email" field.
  final TextEditingController controllerEmail = TextEditingController();

  /// The controller managing the "subject" field.
  final TextEditingController controllerSubject = TextEditingController();

  /// The controller managing the "contents" field.
  final TextEditingController controllerContents = TextEditingController();

  // CONSTRUCTOR ===============================================================

  /// Returns a [BodyContentsContact] matching the given parameters.
  BodyContentsContact({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(XLayout.paddingM),
        shrinkWrap: true,
        children: [

          // PRESENTATION --------------------------------------------------------
          XCard(
            padding: EdgeInsets.all(XLayout.paddingM),
            title: PresetText.headline("Contact form.".tr,),
            subtitle: PresetText.body("Contact form explanation".tr,),
          ),

          XLayout.verticalM,

          // FORM ----------------------------------------------------------------
          XContainer(
            padding: EdgeInsets.all(XLayout.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                ContactField(
                  title: "Name",
                  controller: controllerName,
                ),

                XLayout.verticalM,

                ContactField(
                  title: "E-Mail address",
                  controller: controllerEmail,
                  validator: (value) => GetUtils.isEmail(value ?? "")
                      ? null
                      : "Please enter a valid e-mail.",
                ),

                XLayout.verticalM,

                ContactField(
                  title: "Subject",
                  controller: controllerSubject,
                ),

                XLayout.verticalM,

                ContactField(
                  title: "Details",
                  maxLines: 10,
                  controller: controllerContents,
                ),

                XLayout.verticalM,

                XInkContainer(
                  onTap: () {},
                  color: context.theme.colorScheme.secondary,
                  child: const Text("Send"),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================

}
