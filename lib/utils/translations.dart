// ignore_for_file: lines_longer_than_80_chars

import "package:get/get.dart";

/// An extension of the [Translations] class, for our custom needs.
class CustomTranslations extends Translations {
  @override
  final Map<String, Map<String, String>> keys = {
    // ENGLISH =================================================================
    "en": {
      // HOME ------------------------------------------------------------------
      "home_description_title": "\\title{[Xeppelin]} lifts your projects ;)",
      "home_description_content":
          "Our goal is to create unique and interesting projects with you. Contact us so we may work together to bring your website or mobile app ideas to fruition.",

      // MENU ------------------------------------------------------------------
      "tab_home": "Home",
      "tab_projects": "Projects",
      "tab_blogs": "Blogs",
      "tab_contact": "Contact",
      "tab_settings": "Settings",
      "tab_splash": "Loading the site...",
      "tab_home_description": "What this is about.",
      "tab_blogs_description": "My coding stories.",
      "tab_projects_description": "My coding projects.",
      "tab_contact_description": "How to contact me.",
      "tab_settings_description": "Customize the site.",

      // PROJECTS --------------------------------------------------------------
      "projects_title": "Projects",
      "projects_description":
          "A list of projects demonstrating various skills.",
      "display_more": "Display more...",
      "no_project_selected_title": "No project is currently selected.",
      "no_project_selected_content":
          "You can find out about a project by clicking on it in the left menu or go back to the main page by clicking on the Xeppelin logo.",
      "media_no_summary": "No summary given.",
      "media_website_button_visit": "website",
      "project_website_button_tooltip": "Go to the project's website.",
      "project_github_button_tooltip": "Go to the project's code repository.",
      "project_status_contributor_tooltip": "Contributor",
      "project_no_selected_default":
          "Kinda empty here...\nClick on a project to start :)",
      "project_no_selected_count_low":
          "Thank you for checking out my projects! Feel free to have a look at the others :)",
      "project_no_selected_count_medium":
          "Have you checked the projects with a website icon?",
      "project_no_selected_count_high": "Do I even have that many projects?",
      "project_no_selected_count_extreme":
          "Just how many times did you check my projects??\n\nFeel free to use the contact form if you wanna reach out ;)",

      // CONTACT ---------------------------------------------------------------
      "contact_title": "Contact form",
      "contact_description":
          "If you have a project or an idea, an inquiry, or just want my resume, feel free to contact me via the form below!",
      "contact_name": "Name",
      "contact_email": "E-mail address",
      "contact_email_invalid": "Please enter a valid e-mail.",
      "contact_subject": "Subject",
      "contact_details": "Details",
      "contact_send": "Send",
      "contact_mail_sent_success_title": "Email sent.",
      "contact_mail_sent_success_content":
          "I'll get back to you as soon as possible :)",
      "contact_mail_sent_failure_title": "An error occurred.",
      "contact_mail_sent_failure_content":
          "Please try again later.\nIf the issue persist, please send me a mail at: support@xeppelin.org",

      // SETTINGS --------------------------------------------------------------

      "settings_title": "Settings",
      "settings_description":
          "Here you can configure the website to match your preferences.",
      "settings_locale": "Locale",
      "settings_locale_description":
          "The language used on this site (this setting has no impact on projects and blogs).",
      "settings_theme_selection": "Theme selection",
      "settings_background_selection": "Background selection",
      "settings_theme_light": "Light",
      "settings_theme_dark": "Dark",
      "settings_theme_pastel": "Pastel",
      "settings_theme_halloween": "Halloween",
      "settings_theme_crimson": "Crimson",
      "settings_theme_cottage": "Cottage",
      "settings_theme_rust": "Rust",
      "settings_theme_terminal": "Terminal",
      "settings_theme_oled": "OLED",
      "settings_background_none": "None",
      "settings_background_wave": "Wave",
      "settings_legal":
          "Please check our \\route{/legal/legal_mentions}{Legal mentions}, "
              "\\route{/legal/privacy_policy}{Data policy} and "
              "\\route{/legal/cookie_policy}{Cookie policy}.",
      "settings_disable_cookies": "Disable cookies",
      "settings_disable_cookie_snackbar_title": "Done.",
      "settings_disable_cookie_snackbar_content":
          "Your cookies were deleted and disabled.",

      "language_en": "English",
      "language_fr": "Français",

      // LEGAL -----------------------------------------------------------------

      "cookie_policy_title": "Cookie policy",
      "privacy_policy_title": "Data policy",
      "legal_mentions_title": "Legal mentions",
      "legal_content_error": "The content you asked for couldn't be reached."
          "Sorry for the inconvenience and please try again later.",

      // BUTTONS ---------------------------------------------------------------

      "button_back": "Go back",
      "button_scroll_to_see_more": "Scroll to see more...",

      // OTHER -----------------------------------------------------------------
      "cookies_title": "About cookies",
      "cookies_description":
          "This site only uses functional cookies. They are used to remember your preferred language and theme.",
      "cookies_decline": "No, thanks",
      "cookies_accept": "Okay",
      "test_card_title": "Click to run the test.",
      "test_card_snackbar_success_title": "It worked!",
      "test_card_snackbar_success_content": "Have a cat fact:\n\n@fact",
      "test_card_snackbar_failure_title": "It failed :/",
      "test_card_snackbar_failure_content":
          "Don't worry, it won't affect your experience on here.",
      "misc_content_not_found": "Content not found.",

      "month_1": "January",
      "month_2": "February",
      "month_3": "March",
      "month_4": "April",
      "month_5": "May",
      "month_6": "June",
      "month_7": "July",
      "month_8": "August",
      "month_9": "September",
      "month_10": "October",
      "month_11": "November",
      "month_12": "December",
      "lorem_ipsum":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },

    //
    // FRENCH ==================================================================
    //

    "fr": {
      // HOME ------------------------------------------------------------------
      "home_description_title":
          "\\title{Xeppelin} fait décoller vos projets ;)",
      "home_description_content":
          "Nous créons des projets uniques et intéressants avec vous. Prenez contact pour qu'ensemble, nous puissions faire de vos idées de site ou d'application une réalité.",
      // MENU ------------------------------------------------------------------
      "tab_home": "Accueil",
      "tab_projects": "Projets",
      "tab_blogs": "Blogs",
      "tab_contact": "Contact",
      "tab_settings": "Paramètres",
      "tab_splash": "Site en cours de chargement...",
      "tab_home_description": "Qui je suis.",
      "tab_blogs_description": "Mes histoires de code.",
      "tab_projects_description": "Mes projets.",
      "tab_contact_description": "Comment me contacter.",
      "tab_settings_description": "Configurer le site.",

      // PROJECTS --------------------------------------------------------------
      "projects_title": "Projets",
      "projects_description":
          "Une liste de projets illustrant différentes compétences.",
      "display_more": "Afficher plus...",
      "no_project_selected_title":
          "Aucun projet n'est sélectionné pour le moment.",
      "no_project_selected_content":
          "Vous pouvez découvrir les détails d'un projet en cliquant dessus dans le menu de gauche ou revenir au menu principal en cliquant sur le logo \"Xeppelin\".",
      "media_no_summary": "Pas de description.",
      "media_website_button_visit": "site web",
      "project_website_button_tooltip": "Aller sur le site du projet.",
      "project_status_contributor_tooltip": "Contributeur",
      "project_github_button_tooltip": "Aller sur le github du projet.",
      "project_no_selected_default":
          "C'est bien vide ici...\nClique sur un projet pour commencer :)",
      "project_no_selected_count_low":
          "Merci de regarder mes projets! Prends ton temps :)",
      "project_no_selected__count_medium":
          "Certains projets sont disponibles sur leurs propres sites, n'hésite pas à aller les voir!",
      "project_no_selected_count_high": "J'ai tant de projets que ca?",
      "project_no_selected_count_extreme":
          "Merci infinement pour le temps que tu consacres à mes projets!!\n\nSi tu le souhaites, il est possible de prendre contact via le formulaire sur la page principale ;)",

      // CONTACT ---------------------------------------------------------------
      "contact_title": "Formulaire de contact",
      "contact_description":
          "Si vous avez un projet ou une idée, une question, ou que vous voulez simplement voir mon CV, n'hésitez pas à prendre contact avec moi via le formulaire ci-dessous.",
      "contact_name": "Nom",
      "contact_email": "Adresse mail",
      "contact_email_invalid": "Veuillez entrer une adresse mail valide.",
      "contact_subject": "Objet",
      "contact_details": "Détails",
      "contact_send": "Envoyer",
      "contact_mail_sent_success_title": "Mail envoyé.",
      "contact_mail_sent_success_content":
          "Je vous recontacterai au plus vite :)",
      "contact_mail_sent_failure_title": "Une erreur est survenue.",
      "contact_mail_sent_failure_content":
          "Veuillez ré-essayer plus tard.\nSi l'issue persiste, je vous prie de m'envoyer un mail à l'adresse: support@xeppelin.org",

      // SETTINGS --------------------------------------------------------------

      "settings_title": "Paramètres",
      "settings_description":
          "Dans cet onglet, vous pouvez configuer le site pour correspondre plus précisément à vos préférences.",
      "settings_locale": "Langage",
      "settings_locale_description":
          "La langue utilisée sur ce site (cela n'affecte pas les projets).",
      "settings_theme_selection": "Choix du thème",
      "settings_background_selection": "Choix du fond",
      "settings_theme_light": "Clair",
      "settings_theme_dark": "Sombre",
      "settings_theme_pastel": "Pastel",
      "settings_theme_halloween": "Halloween",
      "settings_theme_crimson": "Écarlate",
      "settings_theme_cottage": "Prairie",
      "settings_theme_rust": "Rouille",
      "settings_theme_terminal": "Terminal",
      "settings_theme_oled": "OLED",
      "settings_background_none": "Aucun",
      "settings_background_wave": "Vague",
      "settings_legal":
          "Vous pouvez consulter nos \\route{/legal/legal_mentions}{Mentions légales}, "
              "\\route{/legal/privacy_policy}{Politique de confidentialité} et "
              "\\route{/legal/cookie_policy}{Politique en matière de cookies}.",
      "settings_disable_cookies": "Désactiver les cookies",
      "settings_disable_cookie_snackbar_title": "C'est fait.",
      "settings_disable_cookie_snackbar_content":
          "Vos cookies ont été supprimés et désactivés.",

      // LEGAL -----------------------------------------------------------------

      "cookie_policy_title": "Politique en matière de cookies",
      "privacy_policy_title": "Politique de confidentialité",
      "legal_mentions_title": "Mentions légales",
      "legal_content_error":
          "Le contenu que vous cherchez est momentanemment indisponible."
              "Désolé du desagrement causé et veuillez reessayer plus tard.",

      // BUTTONS ---------------------------------------------------------------

      "button_back": "Retour",
      "button_scroll_to_see_more": "Faites défiler pour afficher le reste...",

      // OTHER -----------------------------------------------------------------

      "cookies_title": "À propos des cookies.",
      "cookies_description":
          "Ce site utilise uniquement des cookies fonctionnels. Ils sont utilisés pour retenir vos langages et thèmes préférés.",
      "cookies_decline": "Non merci",
      "cookies_accept": "Okay",
      "test_card_title": "Cliquez pour lancer le test.",
      "test_card_snackbar_success_title": "Ça marche!",
      "test_card_snackbar_success_content":
          "Vous gagnez une fact sur les chats (en anglais):\n\n@fact",
      "test_card_snackbar_failure_title": "Le test a échoué :/",
      "test_card_snackbar_failure_content":
          "Ne vous inquiétez pas, cela ne devrait pas affecter votre expérience sur ce site.",
      "misc_content_not_found": "Contenu introuvable.",

      "month_1": "Janvier",
      "month_2": "Février",
      "month_3": "Mars",
      "month_4": "Avril",
      "month_5": "Mai",
      "month_6": "Juin",
      "month_7": "Juillet",
      "month_8": "Août",
      "month_9": "Septembre",
      "month_10": "Octobre",
      "month_11": "Novembre",
      "month_12": "Décembre",
      "lorem_ipsum":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    }
  };
}
