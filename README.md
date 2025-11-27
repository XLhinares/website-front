# Xeppelin

*Xeppelin lifts your projects.*

This repository contains the code for the front side of the [Xeppelin](www.xeppelin.org) website.

## About the site

This website was made using Flutter with the goal of presenting the projects I have realized.

I wanted to create a strong visual identity while making the information available in a clear and organized way.

The name `Xeppelin` was found by mixing my usual pseudonym and the word "zeppelin" which I chose because it combines the feeling of lightness and might. These values, I hope I can make appear in my work through rock-solid-yet-epurated interface and features.

## Code structure:

The code is organized in the following way:

```md
- assets/:          The static fonts and images used.
- lib/:             The source code
    - classes/:     The data structures and other services
    - tabs/:        The different pages (and pseudo-pages) of the website.
    - components/:  The non-top-level composite widgets (the menu, the contact form, etc.)
    - widgets/:     The low-level, basic widgets.
    - utils/:       The translations and utility functions.
- scripts/:         The various automation scripts making development easier.
```

## Hosting

The website is hosted via an O2Switch server.
I set up a remote git repository there to simplify pushing production code.
The server also contains the remote assets and the API.

## Contact Me

You can contact me through the contact form on [xeppelin.org](www.xeppelin.org) or via my [LinkedIn](https://www.linkedin.com/in/xavier-lhinares).