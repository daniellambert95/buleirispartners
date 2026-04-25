# Blue Iris Partners — Project Context for Claude

## What This Is

A static marketing website for **Blue Iris Partners**, a financial advisory firm offering CFO services to small/mid-sized businesses. The site generates leads and books consultations via Calendly.

## Tech Stack

- **Static HTML** — no build process, no package.json, no bundler
- **Bootstrap 5** — layout and components (bundled in `css/vendors.min.css` / `js/vendors.min.js`)
- **jQuery** — DOM manipulation, included in `js/jquery.js` and `js/vendors.min.js`
- **Swiper.js** — hero carousels, configured via `data-slider-options` JSON attributes
- **Anime.js** — scroll-triggered animations via `data-anime` attributes
- **GSAP** — timeline animations (bundled in vendors)
- **Calendly** — external meeting scheduling widget, loaded from CDN

## File Structure

```
blueirispartners/
├── *.html                  # All pages (10 total — see pages below)
├── includes/
│   ├── header.html         # Shared nav — loaded via AJAX by load-components.js
│   └── footer.html         # Shared footer
├── css/                    # Pre-minified CSS (do not edit directly)
│   ├── vendors.min.css     # Bootstrap + vendor libs
│   ├── style.min.css       # Main theme styles
│   ├── responsive.min.css  # Media queries
│   ├── icon.min.css        # Icon fonts
│   └── demos/finance/finance.css  # Brand-specific overrides (editable)
├── js/
│   ├── main.js             # Core site logic (animations, nav, sliders)
│   ├── vendors.min.js      # jQuery, Bootstrap, Swiper, Anime, GSAP, Isotope
│   ├── jquery.js           # jQuery standalone
│   └── load-components.js  # AJAX header/footer injection
├── images/                 # All image assets (~390MB)
├── fonts/                  # Web fonts (~10MB)
├── demos/                  # Theme demo CSS files (mostly unused)
└── revolution/             # Revolution Slider plugin (unused)
```

## Pages

| File | Purpose |
|---|---|
| `index.html` | Home — hero slider, industries, services overview |
| `about.html` | Company story and team |
| `services.html` | Service listings |
| `who-we-help.html` | Industry focus (12 industries) |
| `contact.html` | Contact form |
| `pricing.html` | Pricing tiers |
| `a-clear-path-training.html` | Training program landing page |
| `live-training.html` | Live workshop details |
| `blog-single.html` | Blog post template |
| `thank-you.html` | Form submission confirmation |

## Brand Colors

| Variable | Hex | Use |
|---|---|---|
| `--primary-blue` | `#1C3D5A` | Headings, nav active state, overlays |
| `--primary-gold` | `#bc8947` | Accents, hover states, CTA buttons, mobile menu |
| `--base-color` | `#2946f3` | Alternative primary (less common) |

## Key Patterns

### Animations
Scroll animations are declarative — add `data-anime` JSON to any element:
```html
<h2 data-anime='{"translateY": [50,0], "opacity": [0,1], "duration": 600}'>Text</h2>
```
Fancy text animations use `data-fancy-text` with stagger effects.

### Header/Footer
Loaded dynamically via AJAX (`load-components.js`). Edit `includes/header.html` or `includes/footer.html` to change nav links, logo, footer content. Changes apply site-wide.

### Calendly
Two helper functions in `main.js`:
- `openCalendly(url)` — opens popup widget
- `openCalendlyFromMenu(url)` — closes mobile menu first, then opens

Current booking URL: `https://calendly.com/ben-hogan-blueirispartners/new-meeting`

### Contact Form
Posts to `email-templates/contact-form.php`. After submission, redirects to `thank-you.html`.

## What to Edit vs. What Not to Touch

**Safe to edit:**
- Any `*.html` file — content, structure, classes
- `css/demos/finance/finance.css` — brand-specific style overrides
- `includes/header.html` and `includes/footer.html` — shared nav/footer
- `js/load-components.js` — component loading logic

**Do not edit directly:**
- `css/vendors.min.css`, `css/style.min.css`, `css/responsive.min.css`, `css/icon.min.css` — minified vendor files
- `js/vendors.min.js` — minified vendor bundle

**For custom CSS overrides:** add rules to `css/demos/finance/finance.css` or inline `<style>` in the relevant page's `<head>`.

## Deployment

No build step — deploy the static files directly to any web host. The contact form requires PHP server support for `email-templates/contact-form.php`.
