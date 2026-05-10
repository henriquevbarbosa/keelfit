# Keel — Design System

> Dark mode by default. Spotify-inspired palette with `#C8FF00` accent.

## Philosophy

Gym context = low light, early morning / late night. Dark-first is not an option, it's the default. Light mode exists but is not optimized for MVP.

## Color Tokens

### Primary Palette (Dark Mode)

| Token | Hex | Usage |
|---|---|---|
| `background` | `#0A0A0A` | App background |
| `surface` | `#141414` | Cards, sheets, modals |
| `surfaceElevated` | `#1A1A1A` | Elevated cards, popovers |
| `divider` | `#2A2A2A` | Separators, borders |
| `textPrimary` | `#FFFFFF` | Headlines, primary text |
| `textSecondary` | `#A0A0A0` | Body, captions |
| `textTertiary` | `#6B6B6B` | Disabled, placeholders |

### Accent

| Token | Hex | Usage |
|---|---|---|
| `accent` | `#C8FF00` | CTAs, active states, progress fill |
| `accentDim` | `#9ECC00` | Hover/pressed accent |
| `accentGlow` | `#C8FF0040` | Accent shadow / glow (25% opacity) |

### Semantic

| Token | Hex | Usage |
|---|---|---|
| `success` | `#00E676` | Positive feedback, PR hit |
| `warning` | `#FFB300` | Caution, moderate intensity |
| `error` | `#FF5252` | Negative, validation error |
| `info` | `#448AFF` | Neutral info, tips |

### Macros

| Macro | Color | Progress bar |
|---|---|---|
| Protein | `#FF6B6B` | Red-coral |
| Carbs | `#4ECDC4` | Teal |
| Fat | `#FFE66D` | Yellow |

## Typography

Uses system fonts (SF Pro on iOS, Roboto on Android via Skip).

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Display | 34pt | Bold (700) | 40pt | Hero numbers (total volume, macros) |
| Title 1 | 28pt | Bold | 34pt | Screen titles |
| Title 2 | 22pt | Semibold (600) | 28pt | Section headers |
| Title 3 | 18pt | Semibold | 24pt | Card titles |
| Body | 16pt | Regular (400) | 22pt | Primary reading |
| Callout | 14pt | Semibold | 20pt | Buttons, labels |
| Caption | 12pt | Regular | 16pt | Timestamps, metadata |

## Spacing

Base unit: 4pt.

| Token | Value | Usage |
|---|---|---|
| `spaceXs` | 4pt | Tight padding, icon gaps |
| `spaceSm` | 8pt | Default internal padding |
| `spaceMd` | 12pt | Card padding, list item gaps |
| `spaceLg` | 16pt | Section padding |
| `spaceXl` | 24pt | Screen edge padding |
| `space2xl` | 32pt | Section separators |
| `space3xl` | 48pt | Major breaks |

## Radius

| Token | Value | Usage |
|---|---|---|
| `radiusSm` | 4pt | Small buttons, chips |
| `radiusMd` | 8pt | Default buttons, inputs |
| `radiusLg` | 12pt | Cards, sheets |
| `radiusXl` | 16pt | Modals, paywall cards |
| `radiusFull` | 9999pt | Circular buttons, avatars |

## Shadows (Dark Mode)

| Token | Value |
|---|---|
| `shadowSm` | `0 1px 2px rgba(0,0,0,0.5)` |
| `shadowMd` | `0 4px 6px rgba(0,0,0,0.4)` |
| `shadowLg` | `0 10px 15px rgba(0,0,0,0.3)` |

## Layout

- **Safe area margins:** Respect `safeAreaInsets` on all screens
- **Max content width:** 430pt (iPhone 16 Pro Max logical width)
- **Touch target:** Minimum 44×44pt per Apple HIG
- **List row height:** 56pt minimum

## Components (Atomic)

### Buttons

**PrimaryButton**
- Background: `accent`
- Text: `background` (black on lime)
- Padding: `spaceMd` horizontal, `spaceSm` vertical
- Radius: `radiusMd`
- Font: Callout (14pt Semibold)
- Pressed: scale 0.97, background `accentDim`

**SecondaryButton**
- Background: `surface`
- Text: `textPrimary`
- Border: 1pt `divider`
- Same padding/radius as primary

**GhostButton**
- Background: transparent
- Text: `accent`
- No border

### Inputs

**TextField**
- Background: `surface`
- Border: 1pt `divider`, focused = `accent`
- Text: `textPrimary`
- Placeholder: `textTertiary`
- Padding: `spaceMd`
- Radius: `radiusMd`

### Progress

**MacroProgressBar**
- Track: `surface` with 1pt `divider` border
- Fill: macro color (Protein/Carbs/Fat)
- Height: 8pt
- Radius: `radiusFull`
- Animation: spring, 0.3s
- Label overlay: percentage in `caption` style

**WorkoutIntensityBadge**
- Leve: `info` background, `textPrimary` text
- Moderado: `warning` background, `background` text
- Pesado: `error` background, `background` text
- Radius: `radiusSm`
- Padding: `spaceXs` horizontal

### Cards

**PaywallCard**
- Background: `surfaceElevated`
- Border: 1pt `divider`
- Accent top border: 2pt `accent`
- Radius: `radiusXl`
- Shadow: `shadowMd`
- Padding: `spaceLg`

## Screens (Reference)

1. **Onboarding** — 3 steps: weight → goal → activity level
2. **Workout Log (Tela 1)** — Group selector, exercise list, set rows, CTA
3. **Macro Target (Tela 2)** — Contextual banner, targets, meal log, progress bars
4. **History** — 7-day list, expand details, paywall gate
5. **Paywall** — Pricing, feature list, CTA

## Animation Principles

- **Entrance:** Opacity 0→1 + translateY 8pt→0, 0.25s ease-out
- **State change:** Scale 0.97→1 + opacity, 0.15s spring
- **Progress:** Width animated with `withAnimation(.spring)`
- **Navigation:** Default iOS slide (Skip handles cross-platform)
