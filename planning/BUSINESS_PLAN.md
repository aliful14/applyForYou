# Job Application Automation Platform — Business Plan & Notes

**Brand / trade name:** ApplyForYou (use on website, email, and marketing; register the trade name with your province if required when operating under a name other than your legal name).

## Business Idea

A platform/service where we apply for jobs on behalf of unemployed people. We handle resume polishing, cover letter writing, and daily job application submissions. The client only needs to attend interviews and prepare for them.

### Pricing Model
- **One-time signup fee:** $200 CAD (includes resume polish + multiple cover letter writeups)
- **Monthly subscription:** $25 CAD/month (ongoing job applications until they get a job or ask to stop)

### Operational Cost
- **Bangladesh employee:** $150 CAD/month (handles manual steps, CAPTCHAs, QA)
- One employee can handle approximately 15-25 active clients

### Unit Economics (10-20 clients/year)
- Signup fees: 10-20 × $200 = $2,000 - $4,000
- Subscriptions (avg 4 months/client): 10-20 × $25 × 4 = $1,000 - $2,000
- Total annual revenue: ~$3,000 - $6,000 CAD
- Bangladesh employee cost: $150 × 12 = $1,800/year
- Estimated profit: $1,200 - $4,200/year at small scale

---

## Automation vs. Manual — What Can Be Automated

| Task | Automation Level | How |
|---|---|---|
| Resume polishing/ATS optimization | 95% AI | LLM agent with ATS scoring |
| Cover letter generation per job | 95% AI | LLM agent with job description input |
| Job scraping & matching | 90% AI | Web scraping + AI matching |
| LinkedIn Easy Apply | 80% automation | Browser automation (Playwright) |
| Indeed Apply | 70% automation | Browser automation |
| Workday/Taleo/Greenhouse portals | 30-50% automation | Semi-automated + manual labor |
| Custom application questions | 60% AI + human review | LLM drafts, human verifies |
| CAPTCHA solving | Manual | Bangladesh employee handles |
| Tracking & reporting to client | 95% automated | Dashboard + email notifications |

---

## Agent Architecture (5 Core Agents)

### 1. Resume Optimization Agent
- Input: client's raw resume + target job type
- Uses an LLM to rewrite for ATS keyword optimization
- Scores against common ATS parsers
- Outputs multiple versions (tech, management, general)

### 2. Cover Letter Generation Agent
- Input: optimized resume + specific job description
- Generates a tailored cover letter per application
- Maintains client's "voice" and story
- Batch generation — can produce 20-30 per day

### 3. Job Discovery & Matching Agent
- Scrapes LinkedIn, Indeed, Glassdoor, company career pages
- Filters by: location, job type, experience level, salary range
- Ranks jobs by match score against client's resume
- Outputs a daily queue of jobs to apply to

### 4. Application Submission Agent (Browser Automation)
- Uses Playwright/Puppeteer to automate form filling
- Handles LinkedIn Easy Apply end-to-end
- For complex portals (Workday, etc.), pre-fills what it can and flags for manual completion
- Takes screenshots as proof of submission

### 5. Client Dashboard & CRM
- Client portal: see applied jobs, status tracking, weekly reports
- Admin panel: manage clients, assign to Bangladesh employee, monitor agent performance
- Payment integration (Stripe) for $200 signup + $25/month subscription

---

## Workflow

```
Client Signs Up ($200)
    ↓
Resume Optimization Agent → polished resume + ATS variants
    ↓
Client provides: job preferences (location, type, salary range)
    ↓
Daily Loop:
    ├── Job Discovery Agent → finds 20-30 matching jobs
    ├── Cover Letter Agent → generates tailored letters
    ├── Application Agent → auto-applies where possible
    └── Bangladesh Employee → handles manual portals, CAPTCHAs, QA
    ↓
Dashboard updates → client gets daily/weekly report
    ↓
Client interviews → gets job → churns (success!)
```

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend API | Python (FastAPI) or Node.js |
| AI/LLM | OpenAI GPT-4 API or Claude API |
| Browser Automation | Playwright (Python) |
| Job Scraping | Scrapy + Playwright for JS-heavy sites |
| Database | PostgreSQL |
| Queue/Task System | Celery + Redis (for async job processing) |
| Frontend Dashboard | Next.js or React |
| Payments | Stripe |
| Hosting | AWS or Railway |

---

## Legal Risks & Mitigation

### Status: Canadian Permanent Resident
- PRs have the exact same right as citizens to start and run a business in Canada
- Immigration status has zero impact on ability to operate a business
- Key consideration: tax compliance is reviewed during citizenship applications — be extra careful to report all income

### Risk 1: Tax Reporting (MUST DO)
- Report all income on T1 personal tax return under Line 13500 (self-employment income)
- Keep a simple spreadsheet: date, client name, amount received, what it was for
- Track expenses (Bangladesh employee payments, software, API costs) — these reduce taxable income
- File taxes on time
- CRITICAL FOR PR: Tax compliance is checked during citizenship application
- Cost: $0

### Risk 2: Credential Mishandling (MUST DO)
- Use Bitwarden (free) to store client credentials
- Never share credentials over unencrypted channels
- Delete credentials when a client leaves
- Cost: $0

### Risk 3: Client Consent (MUST DO)
- Get signed authorization before starting work
- Template text:
  > "I, [Client Name], authorize [Your Name] to apply for jobs on my behalf using the resume, cover letter, and personal information I have provided. I understand that [Your Name] will submit applications to job postings matching my stated preferences. I consent to [Your Name] collecting, using, and storing my personal information (resume, contact details, work history, and login credentials) for the sole purpose of applying to jobs on my behalf. My data will be deleted within 30 days of service cancellation."
- Even a reply to an email saying "I agree" counts
- Cost: $0

### Risk 4: No Guarantees (MUST DO)
- Never promise interviews or jobs — promise activity ("20 applications per week")
- Keep proof of every application submitted (screenshots, confirmation emails)
- If someone is unhappy, offer a partial refund and move on
- Cost: $0

### Risk 5: Platform ToS Violations (LOW RISK)
- At small scale with manual/semi-manual applications, risk is very low
- Apply at human pace, don't use aggressive automation early on
- Include in authorization form: "There is a small risk that job platforms may restrict your account. [Your Name] is not liable for platform actions."
- Cost: $0

### Risk 6: Privacy Law / PIPEDA (LOW RISK AT SMALL SCALE)
- PIPEDA technically applies even with consent — consent is one requirement within the law
- At small scale, the Privacy Commissioner is not going after sole proprietors with 10 clients
- Three rules: (1) Don't collect what you don't need, (2) Don't use data for anything else, (3) Delete data when client leaves
- Consent in the authorization form covers most PIPEDA principles
- Cost: $0

### Risk 7: Paying Bangladesh Employee (LOW RISK)
- Pay via Wise (TransferWise) — cheap, traceable, legitimate
- Keep records of payments (date, amount, what it was for)
- They are a foreign independent contractor — no CPP, EI, or payroll deductions required
- Cost: $0 beyond Wise transfer fees

### Business Registration
- NOT REQUIRED as long as operating under your own legal name
- No revenue threshold that makes it mandatory
- Can skip for 1 year, 2 years, 5 years — no time limit
- Register only if: (a) you want a business name other than your legal name, or (b) your province specifically requires it
- Cost when needed: $40-60 depending on province

### GST/HST Registration
- NOT REQUIRED until revenue exceeds $30,000 in four consecutive quarters
- At 10-20 clients, nowhere near this threshold

### Incorporation
- NEVER mandatory regardless of revenue
- Only worth considering at $50-60K+ profit for tax advantages
- Not relevant at small scale

---

## Marketing Strategy

### Free / Near-Free Channels

#### Reddit (Highest ROI)
- Target subreddits: r/jobs, r/careerguidance, r/resumes, r/canadajobs, r/PersonalFinanceCanada, r/immigration
- Strategy: post helpful content, comment on frustrated job seekers, share before/after results
- Don't spam — be helpful first, pitch second

#### Facebook Groups
- Join local job seeker groups, newcomer groups, community groups
- Bengali community groups (natural trust advantage)
- Same approach: help first, pitch second

#### LinkedIn
- Post content about resume tips, ATS optimization, job market insights
- Profile becomes your sales page

#### TikTok / Instagram Reels
- Short videos: resume tips, behind-the-scenes of applications, results
- Job content goes viral because many people relate to the pain
- Screen recordings with voiceover work fine

#### Word of Mouth / Referral Program
- "Refer a friend, get one month free"
- Costs $25, could bring in $200+ signup fee

### Paid Ads (Facebook/Instagram)
- AI-generated ad copy is allowed and effective
- Start at $5/day ($150/month) — can bring 1-5 paying clients/month
- Don't start ads until you have: landing page, testimonials, proven messaging
- Target audiences: newcomers to Canada, recent graduates, job seekers
- Meta will reject ads that imply negative personal attributes
  - Bad: "Are you unemployed and struggling?"
  - Good: "Job applications taking too long? Let us handle them."

### Best Target Audiences (Ranked)
1. Newcomers/immigrants to Canada
2. Recent graduates
3. Career switchers
4. Laid-off professionals

### Trust Signals Needed for Strangers
- One-page website (Carrd.co — free)
- Clear service description
- 2-3 testimonials from initial clients
- Professional email (e.g. hello@applyforyou.com or hello@applyforyou.ca — register the domain you choose)
- Simple intake form (Google Form)
- Social media presence

### Launch Plan
- Week 1: Build landing page, write service description, create intake form, set up email/social
- Week 2: Start posting on Reddit, join Facebook groups, first LinkedIn post
- Week 3: Start DMing people who post about job struggles, ask first clients for testimonials
- Week 4: Should have 2-5 paying clients, share first success story

### Pricing Psychology
- Don't say "Pay $200 upfront"
- Say "For less than $8/day, I'll apply to 20+ jobs per week on your behalf"

### The Pitch
> "I handle the entire job application process for you — resume optimization, cover letters, and daily applications — so you can focus on interview prep instead of spending 6 hours a day filling out forms."

---

## Payment Options

### E-Transfer (Recommended at Small Scale)
- Free, instant, no fees, no setup
- Not inherently sketchy — standard for Canadian freelance services
- Make it professional with: proper invoice (Wave — free), confirmation email, online presence
- Trust comes from presentation, not payment method

### Stripe (When Ready for Strangers)
- 2.9% + $0.30 per transaction (~$6.10 on $200)
- Can sign up as Individual / Sole Proprietor — no business registration needed
- Fields: Business type (Individual), your legal name, SIN, personal bank account
- Business number (BN) field is optional — leave blank

### PayPal
- 2.9% fee
- Easy for clients

### Recommendation
- Start with e-transfer for first 5 clients
- Switch to Stripe when you want a proper checkout page on a website

---

## Phased Build Plan

### Phase 1 — Manual MVP (Week 1-2)
- Find 3-5 people willing to pay
- Do applications manually (you + Bangladesh employee)
- Use ChatGPT for resume polish and cover letters
- Track everything in Google Sheet
- Learn which parts are truly painful and repetitive

### Phase 2 — Build Resume & Cover Letter Agents (Week 3-4)
- Automate the highest-value, most automatable pieces
- Build simple admin dashboard

### Phase 3 — Job Discovery Agent (Month 2)
- Automate job scraping and matching
- Add LinkedIn Easy Apply automation

### Phase 4 — Scale Automation (Month 3+)
- Gradually automate more portals
- Build client-facing dashboard
- Add payment integration

---

## Quick-Start Checklist

- [ ] Keep an income/expense spreadsheet
- [ ] Set up Bitwarden for client credentials
- [ ] Write authorization/consent text
- [ ] Never promise results, only activity
- [ ] Screenshot every application as proof
- [ ] Report income on tax return
- [ ] Find first 3-5 clients
- [ ] Start applying manually to validate the process
