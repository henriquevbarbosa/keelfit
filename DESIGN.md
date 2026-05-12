# Keel — Design System

## Philosophy

Dark-mode-first, minimal, high-contrast. Built for gym use — readable under bright lights, no unnecessary ornamentation.

## Color Tokens

| Token | Hex | Usage |
|---|---|---|
| `background` | `#0A0A0A` | App background |
| `surface` | `#141414` | Cards, sheets |
| `surfaceElevated` | `#1A1A1A` | Elevated cards |
| `divider` | `#2A2A2A` | Separators |
| `textPrimary` | `#FFFFFF` | Headlines |
| `textSecondary` | `#A0A0A0` | Body |
| `textTertiary` | `#6B6B6B` | Disabled |
| `accent` | `#C8FF00` | CTAs, active |
| `accentDim` | `#9ECC00` | Pressed |
| `success` | `#00E676` | Positive |
| `warning` | `#FFB300` | Caution |
| `error` | `#FF5252` | Negative |

## Typography

System fonts (SF Pro iOS, Roboto Android via Skip).

| Style | Size | Weight | Line Height |
|---|---|---|---|
| Display | 34pt | Bold | 40pt |
| Title 1 | 28pt | Bold | 34pt |
| Title 2 | 22pt | Semibold | 28pt |
| Title 3 | 18pt | Semibold | 24pt |
| Body | 16pt | Regular | 22pt |
| Callout | 14pt | Semibold | 20pt |
| Caption | 12pt | Regular | 16pt |

## Spacing (base 4pt)

| Token | Value |
|---|---|
| `xs` | 4pt |
| `sm` | 8pt |
| `md` | 12pt |
| `lg` | 16pt |
| `xl` | 24pt |
| `2xl` | 32pt |
| `3xl` | 48pt |

## Radius

| Token | Value |
|---|---|
| `sm` | 4pt |
| `md` | 8pt |
| `lg` | 12pt |
| `xl` | 16pt |
| `full` | 9999pt |

## Components

### PrimaryButton
- Background: `accent`, text: `background`
- Padding: `md` H, `sm` V
- Radius: `md`
- Pressed: scale 0.97, bg `accentDim`

### SecondaryButton
- Background: `surface`, border: 1pt `divider`

### MacroProgressBar
- Track: `surface` with `divider` border
- Fill: macro color (protein/carb/fat)
- Height: 8pt, radius `full`

### WorkoutSetRow
- Number tag → reps input → × → weight input → unit → delete
- Inputs: `surface` bg, `sm` radius

## Animation

- Entrance: opacity 0→1 + translateY 8pt→0, 0.25s ease-out
- State change: scale 0.97→1, 0.15s spring
- Progress: width animated with `.spring`
