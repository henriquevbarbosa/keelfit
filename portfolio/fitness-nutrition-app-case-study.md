---
title: "Keel — Workout + Macro Tracker"
type: portfolio
status: in-progress
created: 2026-05-09
updated: 2026-05-09
---

## Keel — Workout + Macro Tracker

**Role:** Product Designer + Design Engineer
**Duration:** 2–4 weeks
**Stack:** Skip.dev (SwiftUI + Jetpack Compose), SwiftData, RevenueCat, PostHog
**Status:** In progress — P0 Foundation

---

### Problem

Gym-goers who track workouts (Hevy) and macros (separate app) waste time switching between apps. No unified tool exists for the bulk/cut cycle that is both fast to log and accurate for nutrition.

---

### AI Tools Used

| Tool | Purpose | Where in project |
|---|---|---|
| Claude Code + Figma MCP | Screen design from reference apps | 6 competitor screens analyzed → 4 original screens |
| Claude Code + Skip.dev | SwiftUI code generation | Components, screens, data models |
| Hermes Agent | Task orchestration + documentation | Wiki updates, skill creation, roadmap tracking |
| Claude Design | DESIGN.md generation | Dark mode tokens, accent color, spacing system |

---

### Process

1. **Research:** 6 apps analyzed via Figma board → pain points documented in wiki
2. **Design:** Figma frames → SwiftUI previews (interactive proto) → refinements
3. **Build:** Skip.dev scaffold → SwiftData models → UI components → screens
4. **Ship:** TestFlight → App Store + Google Play in parallel

---

### Key Decisions with AI

- **Skip over Rork:** Chose Skip.dev (open source, iOS+Android) over Rork Max (iOS-only, $$$) — AI research found Skip fits portfolio narrative better
- **Dark mode by default:** DESIGN.md dark-first aligned with gym context (low light, early morning/late night)
- **Hardcoded exercise library:** AI suggested auto-expanding library; we rejected — manual curation reduces decision fatigue

---

### Tradeoffs Documented

- **Privacy:** Macros calculated locally (SwiftData), never sent to LLM — data stays on device
- **Scope:** Cut wearables, coaching, AI meal photo recognition for V1 — validated by user research showing "logging speed" is #1 priority
- **Platform:** Android via Skip is "good enough" not pixel-perfect — acceptable for MVP validation

---

### Errors Overcome

- *(To document during build: AI hallucinations, SwiftData migration issues, Figma-to-code fidelity gaps)*

---

### Result

| Metric | Target | Actual |
|---|---|---|
| Waitlist (48h) | 50 emails | — |
| Downloads week 1 | 100 | — |
| D7 retention | >15% | — |
| M1 revenue | >$100 | — |

---

### Links

- [[smart-workout-loggers]] — original idea spec
- [[fitness-nutrition-app-roadmap]] — master project roadmap
- [[indie-hacking-validation]] — validation framework applied
