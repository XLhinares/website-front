// ignore_for_file: lines_longer_than_80_chars

// Flutter dependencies
import "package:get/get.dart";

/// An extension of the [Translations] class, for our custom needs.
class CustomTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    // ENGLISH =================================================================
    "en": {
      // HOME ------------------------------------------------------------------
      "Home description 1": "%bc [Xequiche]% is a company dedicated to making websites and apps mixing unique %bc aesthetics% and high %bc productivity%.",
      // PROJECTS --------------------------------------------------------------

      // CONTACT ---------------------------------------------------------------
      "Contact form explanation": "If you have a project or an idea, you can contact me via the form below and we can plan",

      // OTHER -----------------------------------------------------------------
      "Cookies title": "This site uses functional cookies.",
      "Cookies description": "They are used to display this site in your preferred language and theme.",
      "lorem ipsum": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",

    },
    // FRENCH ==================================================================
    "fr": {
      // HOME ------------------------------------------------------------------
      "Home description 1": "%bc [Xequiche]% est une entreprise consacrée à la création de site et d'application liant des %bc esthétique% unique et une %bc efficacité% maximale.",
      // PROJECTS --------------------------------------------------------------

      // CONTACT ---------------------------------------------------------------
      "Contact form explanation": "If you have a project or an idea, you can contact me via the form below and we can plan",

      // OTHER -----------------------------------------------------------------
      "Cookies title": "Ce site utilise des cookies fonctionels.",
      "Cookies description": "Ils sont utilisés pour afficher ce site dans vos langages et thèmes préférés.",
      "lorem ipsum": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    }
  };
}
