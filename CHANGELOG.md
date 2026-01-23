## 3.1.0

- :bug: Fixed the routing issues.
- :lipstick: Removed the moving box on the desktop main page's menu.
- :lipstick: Fixed some colors following the new theme system.

- :truck: Renamed `lib/tabs` to `libs/pages`
- :recycle: Changed [RouterService] to [XRouter] since all the "service" classes were deleted.
- :heavy_plus_sign: Replaced `gpt_markdown` with `flutter_markdown_plus`.

## 3.0.0

- :sparkles: Switched to plugin based app management.
- :sparkles: Copyright date updated to 2026.

- :lipstick: The mobile overlay is not constrained by the frame fit anymore.
- :lipstick: Separate the frame ratio of desktop and mobile mode.
- :lipstick: Greatly improved the theming system and made corresponding changes.
- :lipstick: Added new themes.
- :lipstick: The Xeppelin logo can now be any color!


- :bug: Fix UI error of main page.
- :fire: Removed unused code (button overlay for settings)

## 2.4.3

- :bug: Changed website description to avoid overflow on mobile.
- :recycle: Changed [XInkContainer] to [XButton] everywhere.

- :bento: Edit favicon to use Xeppelin logo.

## 2.4.2

- :art: Created `LRSelector` widget to uniformize the different "left/right" selectors (for instance the locale selector).

- :lipstick: Changed size of logo on home page.
- :lipstick: Changed home page description of the website.

- :recycle: Moved the functions opening external websites to the `api` code.
- :recycle: Deleted the `local_selection_compact.dart` widget and moved the content to the `locale_compact.dart` component.

- :bento: Made small edits to the resume icon.
- :bento: Deleted unused font asset.

- :bug: Fixed app always starting in english.

- :globe_with_meridians: Fix minor translation error.

## 2.4.1

- :sparkles: Added social networks button icons on the home page.
- :bento: Added a custom-made icon for the resume.
- :globe_with_meridians: Fix minor translation error.

## 2.4.0

- :memo: Added `LICENSE`.
- :memo: Updated `README.md`.

## 2.3.2

- :lipstick: Labels are written using the code font family.

- :recycle: Moved `globals.dart` file to the top level of the `lib` folder to make it easier to find.
- :recycle: Removed all the `export.dart` files since usually they were only used to import a single element, and were otherwise generating clutter.

## 2.3.1

- :art: Added a [NoProjectSelected] widget to display on the desktop project page. 
- :bug: Fixed a bug where the contact form wasn't displayed on desktop.
- :globe_with_meridians: Added missing translations.

## 2.3.0

- :fire: Got rid of the [AppMode] class and did everything with the [XRoute] (previously [CustomRoute]) since both classes were redundant and adding a lot of complexity to the project.

- :sparkles: New projects tab in main page on mobile.
- :sparkles: New settings tab in main page on mobile.
- :sparkles: New projects page on mobile.
- :sparkles: New projects page on desktop.
- :sparkles: Doubling clicking on the projects tab redirects to projects page.

- :art: Made the router use a new [PageController] whenever reloading the main page to avoid errors. 

- :recycle: Renamed many files with "main" if they belong to the main page, or "page" if they have their own page.

- :bento: Added the "sono" font to the assets.

## 2.2.1

- :bug: Removed remaining `flutter_markdown` uses.
- :art: Commented `MobileTabView._backgroundScale` for being unused

## 2.2.0

- :sparkles: Removed blog support as it doesn't have enough content.
- :sparkles: Removed the test card as it was deemed confusing by users.
- :sparkles: Added [MediaContentType.github] to display content from github.
- :sparkles: Added [fetchFile] method to the [APIService].

- :art: Added an extension `XeppelinMD` on `String` to support some custom Markdown. (used in the legal tabs)
- :art: Added a [FlatButton] widget because the [TextButton] were not working properly on Firefox

- :construction_worker: New `.env` file for the SSH identifier.
- :construction_worker: New script to read the `.env` variables.
- :construction_worker: Better formatting on version numbers script.

- :heavy_plus_sign: Upgraded the dependencies.
- :heavy_plus_sign: Removed `flutter_markdown` for being deprecated.
- :heavy_plus_sign: Added `gpt_markdown`.

- :fire: Removed some unused assets

## 2.1.0

- :bento: Added the logo as a local svg asset to save resources on fetching.

- :lipstick: Added Halloween theme.

- :sparkles: Added customizable background in a similar way to the customizable theme.
- :sparkles: Renamed the global [settings] to [cookies].
- :sparkles: Renamed all export files "exports".

- :globe_with_meridians: Reworked all translations to be based on keys rather than the english text.

## 2.0.1

- :construction_worker: Modified scripts to fit the new host.
- :heavy_plus_sign: Upgraded the dependencies.
- :bug: Solved the bug where a blog could not be focused/unfocused on mobile.
- :bug: Text media content on mobile is now displayed as markdown. 

## 2.0.0

- :sparkles: Added blog support.
- :sparkles: Added permission level.

- :lipstick: Gave bouncing scroll physics to all scrollable tabs.

- :bug: Fixed issue with media dates becoming strings.

## 1.10.1

- :sparkles: Give the "Go back" and "See more" buttons a box target.
- :sparkles: Give the menu tiles a box target.

- :globe_with_meridians: Added missing localizations.

## 1.10.0

- :sparkles: Disabled the whitespace below a project focus when the project has no parts.
- :sparkles: Improved `MediaMobileHeader`.
- :sparkles: Added basic `MediaMobileParts`. 
- :sparkles: Added a settings tab.

- :recycle: Moved the theme settings to the settings tab.
- :recycle: Moved the locale settings to the settings tab.
- :recycle: Moved the legal stuff to the settings tab.

- :arrow_up: Updated `x_containers` dependency.

## 1.9.1

- :sparkles: Better cookie consent card.
- :sparkles: Option to disable cookies in the cookie policy tab.
- :sparkles: Added a `PresetStyles` class to save non-default styles that I still often use.

## 1.9.0

- :bento: Deleted unused assets.
- :recycle: The splash screen has been removed and checking the the app is ready to run is now done on every route.
- :sparkles: The app now has explicit routes to navigate.
- :sparkles: Both mobile and desktop app are controlled by a `PageView`.
- :sparkles: MobileFocus on desktop now feature a "back" button.
- :sparkles: The theme saved by the cookies is now saved to be loaded later if it is not available from the start.

## 1.8.0

- :lipstick: Changed the `frameRatio` from `1.5` to `4/3` because bigger margins look nicer.
- :sparkles: Major update to the routing service, it should be used instead of the navigator from now on.
- :sparkles: Upgraded the parsing of `AutoColorText` to allow adding links and routes.
- :sparkles: Added legal mentions, cookie policy and data policy to the app.
- :globe_with_meridians: Added all the translations for the legal stuff.
- :heavy_plus_sign: Added `flutter_markdown` to handle massive styled blocks of text.

## 1.7.0

- :sparkles: Created the `Media` class to handle both `Project` and `Blog`
- :sparkles: Major overhaul of the desktop project UI.
- :sparkles: Added an option to make a `DateTime` legible with translations.
- :lipstick: Edited some padding values to make the whole interface more coherent.

## 1.6.1

- :sparkles: Desktop tab changes are now handled by a `PageView`.

## 1.6.0

- :speech_balloon: Updated the home screen text.
- :sparkles: Major overhaul of the mobile UI.
- :sparkles: Mobile version now uses a `TabBarView`.
- :sparkles: All mobile tabs are now wrapped in a `ListView` to prevent overflows.
- :lipstick: Changed the color of the `AnimatedCover` in desktop mode.
- :truck: Added a pseudo-router to coordinate the navigation through the single-page.
- :alien: The API now provides more info on projects, the `ProjectFocus` pages have been updated accordingly.

## 1.5.3-pre2

- :construction_worker: Implemented a script to check that the version numbers match.
- :heavy_plus_sign: Migrated from `get` to `http` for api queries.

## 1.5.3-pre1

- :bug: Changed by type to `FormData` in `api.sendSupportMail`.
- :bug: Specified content-type in `api.sendSupportMail`.

## 1.5.3

- :bug: Removed the set headers from the POST request in `api.sendSupportMail`.
- :construction_worker: Changed `make build` to clean the build folder beforehand.

## 1.5.2

- :bug: Fixed the URL to send mail through API.

## 1.5.1

- :construction_worker: Build is published without going through Github.

## 1.5.0

- :sparkles: Created an `user` object to store local data.
- :sparkles: Reworked `ProjectPreview` to change UI and the way it communicates with the API.
- :lipstick: Created a `ThemeService` to handle theme-related stuff.
- :lipstick: Changed the default family font to `JosefinSans`.
- :dizzy: Added rotating icons
- :construction_worker: Modified publishing scripts.

## 1.4.0

- :alien: Switched to subdomain API.
- :construction_worker: Added pre-commit scripts.

## 1.3.1

- :sparkles: Website name and description.
- :sparkles: Hardcoded version number for debugging.
- :sparkles: favicon.png

## 1.3.0

- :art: Link to API.
- :iphone: Better handling of mobile resolutions.
- :construction_worker: Publishing scripts.

## 1.2.2 

- :truck: Split widgets and components folders.
- :globe_with_meridians: the mobile handling of the contact section.

## 1.2.1 

- :art: the contact form behaves better on user input.
- :art: the localisation to cover the existing content.
- :truck: the linting used for imports.

## 1.2.0 

- :art: The way text styles were handled.
- :iphone: The responsivity of the app.
- :sparkles: A display strategy for mobile devices.

## 1.1.2 

- :sparkles: The base structure for API requests.

## 1.1.1 

- :heavy_plus_sign: Migrated from `SharedPreferences` to `GetStorage`.

## 1.1.0 

- :sparkles: A menu tile animation.
- :sparkles: A content cover animation.
- :heavy_plus_sign: The dependencies.

## 1.0.0

- Created: The website structure
- :sparkles: Navigation menu
- :sparkles: Home page
- :sparkles: Project page
- :sparkles: Contact form
- :sparkles: Theme support
- :sparkles: Locale support