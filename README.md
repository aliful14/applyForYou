# ApplyForYou — Website

A one-page marketing site for ApplyForYou. Plain HTML + CSS + a little vanilla JS. No framework, no build step.

---

## File structure

```
website/
  index.html               Main landing page
  privacy.html             Plain-English privacy policy (PIPEDA-aware)
  robots.txt               Search engine rules
  sitemap.xml              Sitemap for search engines
  assets/
    css/styles.css         All styling (CSS variables at top)
    js/main.js             Mobile menu, FAQ accordion, year stamp
    img/logo.svg           Brand mark (used in nav + favicon source)
    img/favicon.svg        Browser tab icon
    img/og-image.svg       Social-share image (1200x630)
```

---

## Before you go live — replace these placeholders

Open `index.html` and `privacy.html` and replace the following placeholder strings with your real URLs and email. They appear multiple times — use Find and Replace All.

| Placeholder             | Replace with                                                   |
|-------------------------|----------------------------------------------------------------|
| `TALLY_FORM_URL`        | Your Tally intake form URL, e.g. `https://tally.so/r/xxxxxx`   |
| `CALENDLY_URL`          | Your Calendly event URL, e.g. `https://calendly.com/you/15min` |
| `LINKEDIN_PROFILE_URL`  | Your LinkedIn profile or page URL                              |
| `CONTACT_EMAIL`         | Your real email, e.g. `hello@applyforyou.ca`                   |

That is the only thing stopping the site from being launch-ready.

---

## How to preview locally

Any of these will work — the site is fully static.

**Option A — double click**
Open `index.html` in a browser. Most things will work; resume uploads / SVGs loaded by absolute path (`/assets/...`) work best via a local server.

**Option B — local server (recommended)**

**Windows (no Python needed):** from the `website` folder, run:

```powershell
.\serve.ps1
```

The script prints the URL (it tries ports **5500–5509** so a second run still works if 5500 is busy). Press `Ctrl+C` in that window to stop.

To force one port: `.\serve.ps1 -Port 8080`

With Python (if installed):
```powershell
cd website
python -m http.server 5500
```
Then open `http://localhost:5500`.

With Node (if installed):
```powershell
cd website
npx --yes serve .
```

---

## How to edit

**Change colors, fonts, spacing:** open `assets/css/styles.css`. Edit the CSS variables at the top of the file (under `:root`). Everything reskins automatically.

**Change copy (headlines, FAQ, pricing):** edit `index.html` directly. Sections are clearly commented, e.g. `<!-- ========== HERO ========== -->`.

**Update the privacy policy:** edit `privacy.html`.

**Replace the logo:** drop a new SVG at `assets/img/logo.svg`. Keep the viewBox at `0 0 64 64` for best fit in the nav.

**Swap the photo in the About section:** inside `index.html`, find `<div class="about__photo" aria-hidden="true">AH</div>` and replace the contents with `<img src="/assets/img/your-photo.jpg" alt="Your name" />`. CSS already handles cropping to a circle.

---

## Deploying

### Netlify (easiest — drag and drop)

1. Sign up at [netlify.com](https://www.netlify.com) (free).
2. Click **Sites → Add new site → Deploy manually**.
3. Drag the whole `website/` folder into the drop zone.
4. Netlify gives you a URL like `yourname.netlify.app`. Open it to verify.
5. To use your own domain: **Site settings → Domain management → Add custom domain** and follow the DNS instructions. HTTPS is automatic.

### Cloudflare Pages

1. Push the `website/` folder to a GitHub repo.
2. In Cloudflare dashboard: **Workers & Pages → Create → Pages → Connect to Git**.
3. Select the repo. Build command: *(leave blank)*. Build output directory: `website` (or `/` if you push only that folder).
4. Deploy. Cloudflare gives you a `.pages.dev` URL. Add your custom domain from the Cloudflare dashboard.

### GitHub Pages (acceptable fallback)

1. Push the `website/` folder to a repo (or push its contents to the repo root).
2. **Settings → Pages → Source: Deploy from a branch**. Pick `main` and the folder that holds `index.html`.
3. GitHub gives you a `.github.io` URL. Custom domains are supported with a `CNAME` file.

---

## After deploying

- Set the canonical URL. Replace `https://applyforyou.ca/` in `index.html`, `privacy.html`, `robots.txt`, and `sitemap.xml` if your real domain differs.
- Submit your site to Google Search Console (optional) and paste the `sitemap.xml` URL there.
- Test the site on a phone. Check the nav hamburger, the FAQ accordion, and the "Get started" button.

---

## What is intentionally NOT here

- No client login / dashboard.
- No payment checkout (Stripe). We collect payment via e-Transfer after a personal email.
- No blog, newsletter, or chat widget.
- No stock photos of fake teams.

Keep it simple. Trust comes from clarity, not features.
