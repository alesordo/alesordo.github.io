# Jekyll personal portfolio website

This is my personal portfolio website, realized using Jekyll and deployed on GitHub pages.

It is based on the [portfolYOU](https://github.com/YoussefRaafatNasry/portfolYOU) theme by @YoussefRaafatNasry, adapted to my needs.

## Changes to the original theme
- Removed the dependency with the theme's remote Ruby Gem - to have more customization freedom;
- Changed the [404 page](https://alesordo.github.io/404.html);
- Changed the footer layout;
- Removed wow.js for animations, as it's overkill and not needed for my use;
- Changed the theme color from Bootstrap's primary to danger;
- Changed the landing page by adding a brief about me and my main skills;
- Added a greetings script on the landing page, to greet users based on their local time - inspired by [Miika Tuominen's website](https://miikat.dev/);
- General customization of the theme on the _config.yml file;
- Removed 'About me' page;
- Added CV and Contact pages.

## How to run this theme
If you want to run a local demo of my website on your computer, first, clone the repository.

Make sure that you installed Ruby and Jekyll, if not, check [this page](https://jekyllrb.com/docs/installation/).

If everything's ready, open your terminal and run these commands:

```
cd <directory-where-you-cloned-the-repo>  # To move on the right directory
bundle install                            # To install the needed Ruby Gems
bundle exec jekyll serve                  # To run the demo
```
Afterwards, you should see something like `Server running... press ctrl-c to stop.`.

If so, go on your browser, type `localhost:4000` and see the magic happen 🧙!

## How to customize this theme
Okay, maybe your name is not Alessio Sordo, so you may ask how to put your name and all your personal stuff in this website.

It's very straightforward. You'll find all the basic customizations on the `_config.yml` file. Here you can follow the comments and change the values as you like.

If you need to add any posts or projects, take a look on the `_posts` and `_projects` directories, you'll find some examples. You can also edit your about page description by going on `pages/about.md`. To edit your skills and the timeline in the about page, take a look at the `_data` directory.

Keep in mind that all the customization is done either in [Markdown format](https://www.markdownguide.org/cheat-sheet/) for the `.md` files, or [Yaml format](https://quickref.me/yaml.html) for the `.yml` files.

For a more detailed guide, always refer to the portfolYOU official [documentation](https://youssefraafatnasry.github.io/portfolYOU/docs/).

## How to deploy this website online
There are [many ways](https://jekyllrb.com/docs/deployment/third-party/#:~:text=Sites%20on%20GitHub%20Pages%20are,Jekyll%2Dpowered%20website%20for%20free.) to deploy Jekyll websites remotely. What I used are GitHub pages. If you want to take a look at how they work, refer to the [original guide by GitHub](https://docs.github.com/en/pages/quickstart).

## Credits
1. [portfolYOU](https://github.com/YoussefRaafatNasry/portfolYOU) *a theme by YoussefRaafatNasry*
2. [404 page](https://codepen.io/code2rithik/pen/PoWQYGa) *a cool coder 404 page by Rithik Samanthula*
