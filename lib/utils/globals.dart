import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../classes/controllers/blog_loader_controller.dart";
import "../classes/controllers/project_loader_controller.dart";
import "../classes/services/services.dart";
import "../classes/user/user.dart";
import "translations.dart";

/// The version of the app.
const String versionNumber = "v2.0.1";

// SERVICES ====================================================================

/// Whether the app is ready to be used.
final RxBool appIsReady = false.obs;

/// A special service which handle the local data and let the user interact with it.
final User user = User();

/// A service that manages the different elements of the app.
final RoutingService router = RoutingService();

/// A service that manages all the backend stuff.
final APIService api = APIService();

/// A service that manages the preferences of the user.
final CookieService settings = CookieService();

/// A service that handles the themes of the app.
final ThemeService themes = ThemeService();

/// A controller that handles loading projects from the API.
final ProjectLoaderController projectLoaderController =
    ProjectLoaderController();

/// A controller that handles loading blogs from the API.
final BlogLoaderController blogLoaderController = BlogLoaderController();

// CONSTANTS ===================================================================

/// The URL address of the app.
const String xeppelinURL = "https://xeppelin.org";

/// A markdown link to the xeppelin website.
const String xeppelinMD = "[https://xeppelin.org](https://xeppelin.org)";

/// The default ratio of horizontal extent over the vertical.
const double frameRatio = 4 / 3;

/// The maximum horizontal extent of snack-bars appearing on the screen.
const double maxSnackbarLength = 600;

/// The vertical extent of the [BottomNavigationBar] used on the mobile display.
double get navigationBarHeight => XLayout.paddingS * 6;

/// The size of the pages loaded on the API.
const int pageSize = 20;

// ANIMATIONS ------------------------------------------------------------------

/// The default duration of animations in the app.
const Duration animDurationShort = Duration(milliseconds: 200);

/// The default duration for long animations.
///
/// It is typically used by the sps mode switching animations.
const Duration animDurationLong = Duration(milliseconds: 750);

// UTILS -----------------------------------------------------------------------

/// The object containing all the translations used in the app.
final CustomTranslations translations = CustomTranslations();

/// The list of the different supported localizations.
List<String> supportedLocales = ["fr", "en"];

/// Runs some extra commands asynchronously.
void postInit() async {
  // Add some extra themes
  themes.addTheme(
    name: "pastel",
    data: xTheme.getTheme(
      mode: ThemeMode.light,
      primary: const Color(0xFFE0AA3A),
      secondary: const Color(0xFFEF596C),
      background: const Color(0xFF689BA6),
      // backgroundAlt: Color(0xFF282627),
      cardColor: const Color(0xFFE0AA3A),
      containerColor: Colors.white.withOpacity(0.7),
      textTheme: ThemeService.defaultTextTheme,
    ),
  );

  // Add translations
  translations.keys["en"]!["Cookie policy"] = "Cookie policy";
  translations.keys["en"]!["cookie_policy.md"] =
      """## Content of the Cookie Policy

This cookie policy explains what cookies are and how we use them, the types of cookies we use, i.e., 
the information we collect with cookies and how that information is used, and how to control cookie preferences. 
For more information on how we use, store and secure your personal data, see our privacy policy.

You can change or withdraw your consent to the cookie statement on our website at any time.

To learn more about who we are, how you can contact us and how we process personal data, see our [Privacy Policy](https://xeppelin.org/legal/privacy_policy).  
Your consent applies to the following areas: xeppelinMD.

---
## What are cookies?

Cookies are small text files that are used to store small pieces of information. 
They are stored on your device when the website is loaded on your browser. 
These cookies help us to make the website work properly, to make it more secure, 
to provide a better user experience and to understand how the website works and to analyze what works and what needs to be improved.

---

## How do we use cookies?

Like most online services, our website uses first-party and third-party cookies for several purposes. 
First-party cookies are primarily necessary for the website to function properly 
and do not collect any of your personally identifiable information.

Third party cookies used on our website are primarily used to understand how the website works,
how you interact with our website, to ensure the security of our services,
to provide advertisements that are relevant to you, and in the aggregate to provide you
with a better and improved user experience and to expedite your future interactions with our website.""";

  // LEGAL MENTIONS
  translations.keys["en"]!["Legal mentions"] = "Legal mentions";
  translations.keys["en"]!["legal_mentions.md"] = """## Site edition

In accordance with the [article 6 of the law n° 2004-575 of June 21, 2004](https://www.legifrance.gouv.fr/affichTexte.do?cidTexte=JORFTEXT000000801164#LEGIARTI000042038977) 
for the confidence in the digital economy, it is specified to the users of the 
website $xeppelinMD the identity of the various speakers within the framework of 
its realization and its follow-up:

Owner of the site : *XEPPELIN* 
- `Contact`: contact@xeppelin.org 
- `Phone`: + 33 6 51 02 79 71 
- `Address`: 139 rue Jean Gutenberg.

Company identification: AUTOENTREPRISE *XEPPELIN* 
- `SIREN`: -------
- `Address`: 139 rue Jean Gutenberg.

Director of the publication : Xavier Lhinares / Xeppelin

Host: O2Switch 
- `Address`: 222 Boulevard Gustave Flaubert, 63000 Clermont-Ferrand 
- `Phone`: +33 4 44 44 60 40

Data Protection Officer: Xavier Lhinares

Other contributors: Xeppelin

---

## Intellectual property and counterfeiting

*XEPPELIN* is the owner of the intellectual property rights and holds the rights 
of use on all the elements accessible on the website, in particular the texts, 
images, graphics, logos, videos, architecture, icons and sounds.

Any reproduction, representation, modification, publication, adaptation of all 
or part of the elements of the site, whatever the means or the process used, is 
prohibited, except with the prior written authorization of *XEPPELIN*.

Any unauthorized exploitation of the site or of any of the elements it contains 
will be considered as constituting an infringement and will be prosecuted in 
accordance with the provisions of articles 
[L.335-2 et seq. of the Intellectual Property Code](https://www.legifrance.gouv.fr/affichCodeArticle.do?idArticle=LEGIARTI000032655082&cidTexte=LEGITEXT000006069414&dateTexte=20160605).

---

## Limitations of liability.

*XEPPELIN* cannot be held responsible for any direct or indirect damage caused 
to the user's equipment when accessing the $xeppelinMD site.

*XEPPELIN* declines all responsibility for the use that may be made of the 
information and content present on $xeppelinMD.

*XEPPELIN* is committed to ensuring the security of the site site as securely as 
possible, however, its responsibility cannot be be held responsible if 
undesirable data is imported and installed on its site installed on its site 
without its knowledge.

Interactive spaces (contact or comments) are available to users. *XEPPELIN* 
reserves the right to delete, without prior notice, any content posted in this 
area that contravenes the legislation applicable in France, in particular the 
provisions relating to data protection.

Where applicable, *XEPPELIN* also reserves the right to hold the user civilly 
and/or criminally liable, particularly in the event of messages of a racist, 
insulting, defamatory or pornographic nature, whatever the medium used (text, 
images, photos, videos, etc.). whatever the medium used (text, photographs, 
etc.).

---

## CNIL and personal data management.

In accordance with the provisions of the 
[modified law 78-17 of January 6, 1978](https://www.legifrance.gouv.fr/affichTexte.do?cidTexte=JORFTEXT000000886460),
 the user of the site $xeppelinMD has a right of access, modification and 
 suppression of the collected information. To exercise this right, send a 
 message to our Data Protection Officer: Xavier Lhinares.

For more information on how we process your data (type of data, purpose, 
recipient...), read our [Privacy Policy]($xeppelinURL/legal/privacy_policy).

It is also possible to file a complaint with the 
[CNIL](https://www.cnil.fr/fr/plaintes).

---

## Hyperlinks and cookies

The $xeppelinMD website contains hyperlinks to other websites and does not 
accept any any responsibility for these external links or links created by other 
sites to other sites to $xeppelinMD.

Browsing the $xeppelinMD site may result in the installation of cookie(s) on the 
user's computer.

A "cookie" is a small file that records information about a user's information 
about a user's navigation on a site. The data thus The data thus obtained makes 
it possible to obtain measurements of frequentation, for example.

You can accept or refuse cookies by modifying the settings of your browser. No 
cookies will be deposited without your consent.

Cookies are stored for a maximum of 12 months.

For more information on how we use cookies, read our 
[Cookie Policy]($xeppelinURL/legal/cookie_policy).

---

## Governing Law and Jurisdiction.

Any dispute relating to the use of the $xeppelinMD website is subject to French 
law. Except in cases where the law does not allow it, the competent courts of 
Nantes have exclusive jurisdiction.""";

  // DATA POLICY
  translations.keys["en"]!["Privacy policy"] = "Privacy policy";
  translations.keys["en"]!["privacy_policy.md"] = """## Who are we?

Our website address is: $xeppelinMD.

---

## Embedded content from other sites

Articles on this site may include embedded content (e.g. videos, images, 
articles, etc.). Embedded content from other sites behaves in the same way as if 
the visitor were on that other site.

These websites may collect data about you, use cookies, embed third-party 
tracking tools, and track your interactions with such embedded content if you 
have an account with their website.
""";

  translations.keys["fr"]!["Cookie policy"] = "Politique en matière de cookies";
  translations.keys["fr"]!["cookie_policy.md"] =
      """## Contenu de la politique en matière de cookies

La présente politique en matière de cookies explique ce que sont les cookies et 
comment nous les utilisons, les types de cookies que nous utilisons, 
c’est-à-dire les informations que nous recueillons à l’aide des cookies et 
comment ces informations sont utilisées, et comment contrôler les préférences en 
matière de cookies. Pour plus d’informations sur la manière dont nous utilisons, 
stockons et sécurisons vos données personnelles, consultez notre politique de 
confidentialité.

Vous pouvez à tout moment modifier ou retirer votre consentement à la 
déclaration sur les cookies sur notre site web.

Pour en savoir plus sur qui nous sommes, comment vous pouvez nous contacter et 
comment nous traitons les données personnelles, consultez notre [Politique de 
confidentialité](https://xeppelin.org/legal/privacy_policy).

Votre consentement s’applique aux domaines suivants: xeppelinMD.

---

## Qu’est-ce que sont les cookies?
     
Les cookies sont de petits fichiers texte qui sont utilisés pour stocker de 
petits éléments d’information. Ils sont stockés sur votre appareil lorsque le 
site web est chargé sur votre navigateur. Ces cookies nous aident à faire 
fonctionner le site web correctement, à le rendre plus sûr, à fournir une 
meilleure expérience utilisateur et à comprendre comment le site web fonctionne 
et à analyser ce qui fonctionne et ce qui doit être amélioré.

---

## Comment utilisons-nous les cookies ?

Comme la plupart des services en ligne, notre site web utilise des cookies de 
première partie et de tierce partie à plusieurs fins. Les cookies de première 
partie sont principalement nécessaires au bon fonctionnement du site web et ne 
collectent aucune de vos données personnelles identifiables.

Les cookies tiers utilisés sur notre site Web servent principalement à 
comprendre comment le site Web fonctionne, comment vous interagissez avec notre 
site Web, à assurer la sécurité de nos services, à fournir des publicités qui 
vous sont pertinentes et, dans l’ensemble, à vous offrir une expérience 
utilisateur meilleure et améliorée et à accélérer vos interactions futures avec 
notre site Web.""";

  // LEGAL MENTIONS
  translations.keys["fr"]!["Legal mentions"] = "Mentions légales";
  translations.keys["fr"]!["legal_mentions.md"] = """## Édition du site

En vertu de l’[article 6 de la loi n° 2004-575 du 21 juin 2004](https://www.legifrance.gouv.fr/affichTexte.do?cidTexte=JORFTEXT000000801164#LEGIARTI000042038977) 
pour la confiance dans l’économie numérique, il est précisé aux utilisateurs du 
site internet https://xeppelin.org l’identité des différents intervenants dans 
le cadre de sa réalisation et de son suivi:

Propriétaire du site : *XEPPELIN* 
- `Contact` : contact@xeppelin.org 
- `Téléphone` : + 33 6 51 02 79 71 
- `Adresse` : 139 rue Jean Gutenberg.

Identification de l’entreprise : AUTOENTREPRISE *XEPPELIN* 
- `SIREN` : -------
– `Adresse` : 139 rue Jean Gutenberg.

Directeur de la publication : Xavier Lhinares / Xeppelin

Hébergeur : O2Switch 
- `Adresse` : 222 Boulevard Gustave Flaubert, 63000 Clermont-Ferrand 
- `Téléphone` : +33 4 44 44 60 40

Délégué à la protection des données : Xavier Lhinares

Autres contributeurs : Xeppelin

---

## Propriété intellectuelle et contrefaçons

*XEPPELIN* est propriétaire des droits de propriété intellectuelle et détient 
les droits d’usage sur tous les éléments accessibles sur le site internet, 
notamment les textes, images, graphismes, logos, vidéos, architecture, icônes et 
sons.

Toute reproduction, représentation, modification, publication, adaptation de 
tout ou partie des éléments du site, quel que soit le moyen ou le procédé utilisé, 
est interdite, sauf autorisation écrite préalable de *XEPPELIN*.

Toute exploitation non autorisée du site ou de l’un quelconque des éléments 
qu’il contient sera considérée comme constitutive d’une contrefaçon et 
poursuivie conformément aux dispositions des articles 
[L.335-2 et suivants du Code de Propriété Intellectuelle](https://www.legifrance.gouv.fr/affichCodeArticle.do?idArticle=LEGIARTI000032655082&cidTexte=LEGITEXT000006069414&dateTexte=20160605).

---

## Limitations de responsabilité.

*XEPPELIN* ne pourra être tenu pour responsable des dommages directs et 
indirects causés au matériel de l’utilisateur, lors de l’accès au site 
xeppelinMD.

*XEPPELIN* décline toute responsabilité quant à l’utilisation qui pourrait être 
faite des informations et contenus présents sur 
xeppelinMD.

*XEPPELIN* s’engage à sécuriser au mieux le site 
$xeppelinMD, cependant sa responsabilité ne 
pourra être mise en cause si des données indésirables sont importées et 
installées sur son site à son insu.

Des espaces interactifs (espace contact ou commentaires) sont à la disposition 
des utilisateurs. *XEPPELIN* se réserve le droit de supprimer, sans mise en 
demeure préalable, tout contenu déposé dans cet espace qui contreviendrait à la 
législation applicable en France, en particulier aux dispositions relatives à 
la protection des données.

Le cas échéant, *XEPPELIN* se réserve également la possibilité de mettre en 
cause la responsabilité civile et/ou pénale de l’utilisateur, notamment en cas 
de message à caractère raciste, injurieux, diffamant, ou pornographique, quel 
que soit le support utilisé (texte, photographie, etc.).

---

## CNIL et gestion des données personnelles.

Conformément aux dispositions de la 
[loi 78-17 du 6 janvier 1978 modifiée](https://www.legifrance.gouv.fr/affichTexte.do?cidTexte=JORFTEXT000000886460), 
l’utilisateur du site $xeppelinMD dispose d’un droit d’accès, de modification et 
de suppression des informations collectées. Pour exercer ce droit, envoyez un 
message à notre Délégué à la Protection des Données : Xavier Lhinares.

Pour plus d’informations sur la façon dont nous traitons vos données (type de 
données, finalité, destinataire…), lisez notre [Politique de Confidentialité]($xeppelinURL/legal/privacy_policy).

Il est également possible de déposer une réclamation auprès de la 
[CNIL](https://www.cnil.fr/fr/plaintes).

---

## Liens hypertextes et cookies

Le site $xeppelinMD contient des liens hypertextes vers d’autres sites et dégage 
toute responsabilité à propos de ces liens externes ou des liens créés par 
d’autres sites vers $xeppelinMD.

La navigation sur le site $xeppelinMD est susceptible de provoquer 
l’installation de cookie(s) sur l’ordinateur de l’utilisateur.

Un « cookie » est un fichier de petite taille qui enregistre des 
informations relatives à la navigation d’un utilisateur sur un site. Les données 
ainsi obtenues permettent d’obtenir des mesures de fréquentation, par exemple.

Vous avez la possibilité d’accepter ou de refuser les cookies en modifiant les 
paramètres de votre navigateur. Aucun cookie ne sera déposé sans votre 
consentement.

Les cookies sont enregistrés pour une durée maximale de 12 mois.

Pour plus d’informations sur la façon dont nous faisons usage des cookies, lisez 
notre [Politique en matière de cookies]($xeppelinURL/legal/cookie_policy).

---

## Droit applicable et attribution de juridiction.

Tout litige en relation avec l’utilisation du site $xeppelinMD est soumis au 
droit français. En dehors des cas où la loi ne le permet pas, il est fait 
attribution exclusive de juridiction aux tribunaux compétents de Nantes.
""";
  // DATA POLICY
  translations.keys["fr"]!["Privacy policy"] = "Politique de confidentialité";
  translations.keys["fr"]!["privacy_policy.md"] = """## Qui sommes-nous?

L’adresse de notre site est: $xeppelinMD.

---

## Contenu embarqué depuis d’autres sites

Les articles de ce site peuvent inclure des contenus intégrés (par exemple des 
vidéos, images, articles, etc.). Le contenu intégré depuis d’autres sites se comporte 
de la même manière que si le visiteur se rendait sur cet autre site.

Ces sites web pourraient collecter des données sur vous, utiliser des cookies, 
embarquer des outils de suivis tiers, suivre vos interactions avec ces contenus 
embarqués si vous disposez d’un compte connecté sur leur site web.
""";
}
