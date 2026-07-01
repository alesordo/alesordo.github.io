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
- Added CV and Contact pages;
- Added Privacy policy (thanks to [Termly](https://termly.io/products/privacy-policy-generator/));
- Added Remark42 comments instead of Disqus;
- Added Cookie Policy;
- Added Matomo analytics instead of Google Analytics to comply with GDPR;
- Added Ko-Fi instead of Buy Me a Coffee due to 0% fees.

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

## Environment configuration
Runtime and deployment-specific values are declared in `config/env.yml` and read from either your shell environment or a local `.env` file. The `scripts/write_env_config.rb` script turns those values into `.jekyll-env.yml`, a local Jekyll config overlay. Cloned repositories can build without the optional contact form values, but the public site values below should be configured for a complete render.

| Variable | Required for | Notes |
| --- | --- | --- |
| `SITE_URL` | Production deploys | Full canonical URL, for example `https://example.com`. |
| `SITE_BASEURL` | Production deploys | Base path, usually `/` for a user/organization site or custom domain. |
| `AUTHOR_URL` | Site metadata | Public author/profile URL used in site metadata. |
| `PRIVACY_CONTACT_EMAIL` | Privacy/cookies pages | Contact email rendered in policy pages. |
| `MATOMO_BASE_URL` | Analytics | Matomo host URL, without the trailing path. |
| `REMARK42_HOST` | Comments | Remark42 host URL, without the trailing path. |
| `REMARK42_SITE_ID` | Comments | Remark42 site id for this repository. |
| `PAGES_CNAME` | GitHub Pages | Custom domain written to `CNAME`. |
| `CONTACT_FORM_ENDPOINT` | Contact form | Full backend endpoint URL for contact submissions. Store it as a GitHub secret. |
| `CONTACT_FORM_METHOD` | Contact form | Optional. Defaults to `POST`. |
| `CLOUDFLARE_TURNSTILE_SITE_KEY` | Contact form | Store it as a GitHub secret. It is still visible in the rendered static site. |

On Windows PowerShell, a local run with sample values looks like this:

```powershell
$env:SITE_URL = "https://example.com"
$env:SITE_BASEURL = "/"
$env:AUTHOR_URL = "https://example.com"
$env:PRIVACY_CONTACT_EMAIL = "privacy@example.com"
$env:MATOMO_BASE_URL = "https://matomo.example.com"
$env:REMARK42_HOST = "https://remark42.example.com"
$env:REMARK42_SITE_ID = "remark42.example"
$env:PAGES_CNAME = "www.example.com"
$env:CONTACT_FORM_ENDPOINT = "https://example.com/api/v1/contact/messages"
$env:CONTACT_FORM_METHOD = "POST"
$env:CLOUDFLARE_TURNSTILE_SITE_KEY = "example-site-key"
ruby scripts/write_env_config.rb
ruby scripts/jekyll_local.rb serve --config _config.yml,.jekyll-env.yml
```

You can also copy `.env.example` to `.env` for local development. When `.env` is present, its values are used for the local overlay; CI builds use GitHub Actions secrets and variables because they do not have a local `.env` file.

Values used by browser code are hidden from the repository source, not from visitors. Once Jekyll renders the static HTML and JavaScript, frontend endpoints and Turnstile site keys can be inspected in the deployed page.

## How to customize this theme
Okay, maybe your name is not Alessio Sordo, so you may ask how to put your name and all your personal stuff in this website.

It's very straightforward. You'll find all the basic customizations on the `_config.yml` file. Here you can follow the comments and change the values as you like.

If you need to add any posts or projects, take a look on the `_posts` and `_projects` directories, you'll find some examples. You can also edit your about page description by going on `pages/about.md`. To edit your skills and the timeline in the about page, take a look at the `_data` directory.

Keep in mind that all the customization is done either in [Markdown format](https://www.markdownguide.org/cheat-sheet/) for the `.md` files, or [Yaml format](https://quickref.me/yaml.html) for the `.yml` files.

For a more detailed guide, always refer to the portfolYOU official [documentation](https://youssefraafatnasry.github.io/portfolYOU/docs/).

## How to deploy this website online
There are [many ways](https://jekyllrb.com/docs/deployment/third-party/#:~:text=Sites%20on%20GitHub%20Pages%20are,Jekyll%2Dpowered%20website%20for%20free.) to deploy Jekyll websites remotely. What I used are GitHub pages. If you want to take a look at how they work, refer to the [original guide by GitHub](https://docs.github.com/en/pages/quickstart).

This repository includes a GitHub Actions workflow for GitHub Pages. In the repository settings, set **Pages > Build and deployment > Source** to **GitHub Actions**. Then configure repository variables for public build values such as `SITE_URL`, `SITE_BASEURL`, `AUTHOR_URL`, `PRIVACY_CONTACT_EMAIL`, `MATOMO_BASE_URL`, `REMARK42_HOST`, `REMARK42_SITE_ID`, and `PAGES_CNAME`. Keep `CONTACT_FORM_ENDPOINT` and `CLOUDFLARE_TURNSTILE_SITE_KEY` as repository secrets.

The environment-variable setup is meant for the included GitHub Actions workflow or any Jekyll build that first runs `scripts/write_env_config.rb` and passes `.jekyll-env.yml` through `--config`. GitHub Pages' native branch-based build does not expose repository secrets to Jekyll or run custom pre-build scripts. If you add a new configurable value, declare it in `config/env.yml`, add it to `.env.example`, and expose it in the workflow `env:` block if GitHub Actions needs it.

## Credits
1. [portfolYOU](https://github.com/YoussefRaafatNasry/portfolYOU) *a theme by YoussefRaafatNasry*
2. [404 page](https://codepen.io/code2rithik/pen/PoWQYGa) *a cool coder 404 page by Rithik Samanthula*
