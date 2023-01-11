import "package:flutter/material.dart";
import "package:flutter_typeahead/flutter_typeahead.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/utils.dart";

/// The settings allowing the user to set the locale of the app.
class SettingsLocale extends StatelessWidget {
  // VARIABLES =================================================================

  final TextEditingController _controller = TextEditingController(
    text: settings.locale.value,
  );

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SettingsLocale] matching the given parameters.
  SettingsLocale({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.only(
        top: XLayout.paddingS,
        bottom: XLayout.paddingS,
        right: XLayout.paddingS,
        left: XLayout.paddingM,
      ),
      // We add "locale" in english so that it is always easy to find for a user
      // who might not be familiar with the currently selected language.
      title: Text("${"Locale".tr} (Locale)"),
      trailing: SizedBox(
        width: Get.width * 0.2,
        child: XContainer(
          enableShadow: false,
          color: context.theme.backgroundColor,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: XLayout.paddingS),
          child: TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              style: context.textTheme.bodyMedium,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            suggestionsCallback: (pattern) {
              List<String> res = List.from(
                supportedLocales.where(
                  (element) => element.contains(pattern),
                ),
              );

              if (res.isEmpty) return supportedLocales;

              // If there's only one known locale matching,
              // the whole list is returned.
              if (res.length == 1 && res[0] == pattern) return supportedLocales;

              return res;
            },
            itemBuilder: (context, itemData) => ListTile(
              title: Text(
                itemData,
                style: context.textTheme.bodyMedium,
              ),
            ),
            onSuggestionSelected: (suggestion) {
              _controller.text = suggestion;
              settings.locale.value = suggestion;
            },
          ),
        ),
      ),
    );
  }
}
