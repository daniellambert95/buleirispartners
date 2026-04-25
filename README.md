# Blue Iris Partners

Marketing website for **Blue Iris Partners**, a financial advisory firm providing CFO and financial leadership services to small and mid-sized businesses.

## Overview

Static HTML website with no build process. All assets are pre-minified and ready to deploy. The site drives visitors toward booking a free consultation via Calendly.

## Pages

| Page | File |
|---|---|
| Home | `index.html` |
| About | `about.html` |
| Services | `services.html` |
| Who We Help | `who-we-help.html` |
| Pricing | `pricing.html` |
| Contact | `contact.html` |
| A Clear Path Training | `a-clear-path-training.html` |
| Live Training | `live-training.html` |
| Blog Post | `blog-single.html` |
| Thank You | `thank-you.html` |

## Tech Stack

- **Bootstrap 5** — responsive layout
- **Swiper.js** — hero image carousels
- **Anime.js** — scroll-triggered animations
- **jQuery** — DOM and event handling
- **Calendly** — meeting scheduling (external widget)
- **Google Fonts** — Plus Jakarta Sans, Jost, Inter

## Making Changes

### Content edits
Edit the relevant `*.html` file directly. Content is standard HTML — no templating language.

### Navigation or footer
Edit `includes/header.html` or `includes/footer.html`. These are loaded on every page via AJAX, so changes are site-wide.

### Styles
Add custom CSS to `css/demos/finance/finance.css`. Do **not** edit the minified vendor CSS files (`vendors.min.css`, `style.min.css`, etc.).

### Calendly booking URL
Search for `calendly.com/ben-hogan-blueirispartners` across all HTML files to find and update the booking link.

### Brand colors
- **Blue:** `#1C3D5A`
- **Gold:** `#bc8947`

Override these in `css/demos/finance/finance.css` if they need to change.

## Deployment

No build step required. Upload all files to a web host. A PHP-capable server is needed for the contact form (`email-templates/contact-form.php`).
