*Xeppelin lifts your projects.*

This repository contains the code for the front side of the [Xeppelin](www.xeppelin.org) website.

## About the site

Ultimately, the goal of this website is to express myself.

It is a project in itself, and a window for my other projects, which all have their unique characteristics. Of course, I hope that others may enjoy browsing it too, and if a person wishes to work together, they will be able to do so through the contact form.

I wanted to create a strong visual identity that even someone who has no care for coding things can enjoy, while also making the information on the site available in a clear and organized way.

The name `Xeppelin` was found by mixing my name and the word "zeppelin" which I chose because it combines the feeling of lightness and might. These values, I hope I can make appear in my work through rock-solid-yet-epurated interface and features.

## Code

This project is coded in Dart/Flutter.
The code is organized in the following way:

```md
- `assets/`:        The static fonts and images used.
- `lib/`:           The source code
    - `app`:        The services containing the core logic of the code.
    - `classes/`:   The data structures and controllers.
    - `pages/`:     The different pages (and pseudo-pages) of the website.
    - `widgets/`:   All the widgets that are part of the pages.
    - `utils/`:     The translations and utility functions.
- `scripts/`:       The various automation scripts making development easier.
```

## Building

Thanks to Flutter, building the project for various platform is very simple with `flutter build <platform>`.
In particular, since it is meant to be a website, it can be compiled for the web with:
```bash
flutter build web --release --wasm
```

## Hosting

The website is hosted via an O2Switch server.
I set up a remote git repository there to simplify pushing production code.
The server also contains the remote assets and the API.

## Contact Me

You can contact me through the contact form on [xeppelin.org](www.xeppelin.org) or via my [LinkedIn](https://www.linkedin.com/in/xavier-lhinares).