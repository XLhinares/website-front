// ignore_for_file: lines_longer_than_80_chars

import "package:get/get.dart";

/// An extension of the [Translations] class, for our custom needs.
class CustomTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // ENGLISH =================================================================
        "en": {
          // HOME ------------------------------------------------------------------
          "Home description 1":
              "%bc [Xeppelin]% lifts your projects ;) \nThe website is under construction but don't hesitate to check the projects I have worked on, or reach out to me via the contact form.",
          // "Home description 1": "%bc [Xeppelin]% is a company dedicated to making websites and apps mixing unique %bc aesthetics% and high %bc productivity%.",

          // MENU ------------------------------------------------------------------
          "Home": "Home",
          "About home": "What I am about.",
          "Projects": "Projects",
          "About projects": "What I have done.",
          "Contact": "Contact",
          "About contact": "How to contact me.",

          // PROJECTS --------------------------------------------------------------

          // CONTACT ---------------------------------------------------------------
          "Contact form": "Contact form",
          "Contact form explanation":
              "If you have a project or an idea, an inquiry, or just want my resume, feel free to contact me via the form below!",
          "Name": "Name",
          "Email": "E-mail address",
          "Email validation": "Please enter a valid e-mail.",
          "Subject": "Subject",
          "Details": "Details",

          // OTHER -----------------------------------------------------------------
          "Cookies title": "About cookies",
          "Cookies description":
              "This site only uses functional cookies. They are used to remember your preferred language and theme.",
          "Test success": "It worked!",
          "Test success message": "Have a cat fact:",
          "Test failure": "It failed :/",
          "Test failure message": "Mucho triste...",

          "lorem ipsum":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        },
        // FRENCH ==================================================================
        "fr": {
          // HOME ------------------------------------------------------------------
          "Home description 1":
              "%bc [Xeppelin]% fait décoler vos projets ;) \n\nLe site est en construction mais n'hésitez pas à aller regarder les projets sur lesquels j'ai travaillé, ou à prendre contact via le formulaire de contact.",

          // MENU ------------------------------------------------------------------
          "Home": "Accueil",
          "About home": "Qui je suis.",
          "Projects": "Projets",
          "About projects": "Ce que j'ai fait.",
          "Contact": "Contact",
          "About contact": "Comment me contacter.",

          // PROJECTS --------------------------------------------------------------

          // CONTACT ---------------------------------------------------------------
          "Contact form": "Formulaire de contact",
          "Contact form explanation":
              "Si vous avez un projet ou une idée, une question, ou que vous voulez simplement voir mon CV, n'hésitez pas à prendre contact avec moi via le formulaire ci-dessous.",
          "Name": "Nom",
          "Email": "Adresse mail",
          "Email validation": "Veuillez entrer une adresse mail valide.",
          "Subject": "Objet",
          "Details": "Détails",

          // OTHER -----------------------------------------------------------------
          "Cookies title": "À propos des cookies.",
          "Cookies description":
              "Ce site utilise uniquement des cookies fonctionnels. Ils sont utilisés pour retenir vos langages et thèmes préférés.",
          "Test success": "Ça marche!",
          "Test success message":
              "Vous gagnez une fact sur les chats (en anglais):",
          "Test failure": "Le test a échoué :/",
          "Test failure message": "Mucho triste...",
          "lorem ipsum":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        }
      };
}
