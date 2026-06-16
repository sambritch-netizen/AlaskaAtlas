---
name: Alaska Atlas
description: A field-grade outdoor guide for Alaska — fishing, camping, gear rental, and navigation.
colors:
  background: "#0B120C"
  surface: "#111B12"
  surface-elevated: "#1A2A1C"
  card: "#152115"
  pine: "#4C9A5F"
  pine-dark: "#2F7042"
  pine-deep: "#1B4332"
  rust: "#CD7B3E"
  rust-dark: "#A35E26"
  birch: "#B9A47A"
  water: "#5B8BAB"
  text-primary: "#ECF2EA"
  text-secondary: "#9DB3A0"
  text-muted: "#5C7260"
  border: "#24382A"
  divider: "#1D2F22"
  danger: "#E25B4A"
  warning: "#E0A93E"
  success: "#4C9A5F"
typography:
  display:
    fontFamily: "MudTrack, serif"
    fontSize: "38px"
    fontWeight: 400
    letterSpacing: "0.5px"
  headline:
    fontFamily: "Bitter, Georgia, serif"
    fontSize: "18px"
    fontWeight: 600
    lineHeight: 1.4
  title:
    fontFamily: "Bitter, Georgia, serif"
    fontSize: "16px"
    fontWeight: 600
    lineHeight: 1.4
  body:
    fontFamily: "Inter, system-ui, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.5
  label:
    fontFamily: "Inter, system-ui, sans-serif"
    fontSize: "11px"
    fontWeight: 600
    letterSpacing: "1.2px"
rounded:
  sm: "8px"
  md: "12px"
  lg: "14px"
  xl: "16px"
  full: "9999px"
  sheet: "24px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "14px"
  lg: "20px"
  xl: "28px"
components:
  button-primary:
    backgroundColor: "{colors.pine}"
    textColor: "{colors.background}"
    rounded: "{rounded.md}"
    padding: "14px 24px"
  chip-species:
    backgroundColor: "{colors.surface-elevated}"
    textColor: "{colors.text-secondary}"
    rounded: "{rounded.full}"
    padding: "6px 12px"
  card-default:
    backgroundColor: "{colors.card}"
    textColor: "{colors.text-primary}"
    rounded: "{rounded.xl}"
    padding: "16px"
  input-default:
    backgroundColor: "{colors.surface-elevated}"
    textColor: "{colors.text-primary}"
    rounded: "{rounded.md}"
    padding: "14px 16px"
---

# Design System: Alaska Atlas

## 1. Overview

**Creative North Star: "The Trapper's Field Journal"**

Alaska Atlas is the design of a worn, trusted field guide — dense with real information, every detail earned rather than decorated. The background is the deep black-green of a spruce forest at 5am, and everything that appears on it carries weight. This is not a minimal SaaS tool or a consumer travel app. It is reference material that happens to run on a phone.

The palette is built entirely around the land: near-black evergreen surfaces, a single pine-green accent that maps to action and trust, a rust-orange that evokes Turnagain Outfitters' brand heat, a worn birch tan for secondary data, and a water-blue reserved for fishing contexts. Typography pairs Mud Track (a distressed display face with the authority of a carved trail sign) with Bitter (a slab serif that reads like a regulation booklet reborn) and Inter (clean, precise body text). No decoration for its own sake. Every element earns its presence.

The system rejects the two failure modes Alaska Atlas was built to replace: the government-reg site (correct data, visually punishing, no trust-building) and the outdoor-retail app (shopping-first, cross-sell everywhere, no field utility). The design should feel like neither. It should feel like something a guide would hand you.

**Key Characteristics:**
- Deep forest dark mode — never "dark because it looks cool," dark because it's used at dawn in low ambient light
- One saturated accent (pine green) on ≤20% of any surface; its discipline is the point
- Mud Track on display headlines only; everything below headline scale uses Bitter or Inter
- Topo-line texture on backgrounds — subtle, never decorative
- Cards that earn their borders; no nested cards, no side-stripe accents

## 2. Colors: The Evergreen Palette

Five hue families, all anchored to Alaska's landscape. No warm sand, no corporate navy, no SaaS teal.

### Primary
- **Spruce Black** (`#0B120C`): The base surface. Near-black with a green cast — the darkest shadows in a spruce stand. Every screen opens here.
- **Pine Green** (`#4C9A5F`): The single saturated action color. Used on primary buttons, active states, tapped chips, navigation selected states, and fishing-section accents. Forbidden as a background fill on more than 20% of any screen.
- **Pine Dark** (`#2F7042`): Pressed/active variant of pine. Also used for filled-button backgrounds on surfaces already green.
- **Pine Deep** (`#1B4332`): Depth layer — used as tinted surface in prominent callout areas.

### Secondary
- **Burnt Rust** (`#CD7B3E`): Turnagain Outfitters brand accent. Used on gear rental moments, outfitter card headers, and the Rentals tab's featured cards. Not interchangeable with pine — rust is commercial energy, pine is trusted authority.
- **Rust Dark** (`#A35E26`): Pressed/hover state for rust-colored elements.

### Tertiary
- **Birch Tan** (`#B9A47A`): Warm secondary label color for metadata, subtext in gear cards, and season callouts. Evokes a birch trunk — warm against the evergreen.
- **Water Blue** (`#5B8BAB`): Reserved exclusively for fishing-related surfaces. Species chips, water-body icons, method callout borders. Never used in Camping, Rentals, or Guides contexts.

### Neutral
- **Forest Dark** (`#111B12`): Navigation bar and modal base surface. One step lighter than background.
- **Forest Card** (`#1A2A1C`, `#152115`): Card and elevated-surface fills. The system has two card values; use `surfaceElevated` (#1A2A1C) for interactive containers and `card` (#152115) for content tiles.
- **Topo Border** (`#24382A`): All card and input borders. A single border spec — no variation.
- **Fog Text** (`#ECF2EA`): Primary text. Near-white with a green tint — not pure white, never pure white.
- **Lichen Text** (`#9DB3A0`): Secondary text. Body copy, supporting labels, species descriptions.
- **Muskeg Text** (`#5C7260`): Muted text. Empty states, placeholder copy, nav labels when unselected.

### Named Rules
**The One Green Rule.** Pine (#4C9A5F) is the sole saturated action color. Rust is the Turnagain accent, water is the fishing accent — neither substitutes for pine in navigation or primary interactions. Using two accent colors simultaneously on one screen is prohibited.

**The Water Reservation Rule.** Water blue (#5B8BAB) is fishing-context only. It does not appear in Guides, Rentals, or Map except where a fishing-specific element is present.

## 3. Typography

**Display Font:** Mud Track (licensed distressed serif)
**Section Header Font:** Bitter (Google Fonts, slab serif)
**Body Font:** Inter (Google Fonts, humanist sans)

**Character:** Mud Track handles every screen-level headline, app bar title, and large species name — the carved, weathered authority of a trailhead sign. Bitter brings the legibility of a regulation booklet to section headers and list titles. Inter handles all body copy, metadata, and data labels. The three fonts occupy non-overlapping size ranges; they never compete on the same element.

### Hierarchy
- **Display / App Bar** (Mud Track, 24–38px, letter-spacing 0.5px): Screen titles, species hero names, tab-level headings. Used at full opacity, `#ECF2EA`. Never used below 20px or above 42px.
- **Section Header** (Bitter, 18px, weight 600): Sub-section headers within a screen. `FishingSectionHeader` widget applies this across the fishing section.
- **Title** (Bitter, 16px, weight 600): Card titles, list-item primary labels.
- **Body Large** (Inter, 16px, weight 400, line-height 1.5): Primary content blocks. Species summaries, guide article text, regulation notes.
- **Body Medium** (Inter, 14px, weight 400, line-height 1.5, color `#9DB3A0`): Supporting body copy, bullet items, method descriptions.
- **Body Small / Caption** (Inter, 12px, color `#5C7260`): Timestamps, counts, footnotes.
- **Label** (Inter, 11px, weight 600, letter-spacing 1.2px, uppercase): Section eyebrows where used as a deliberate system element (e.g., "SPECIES PRESENT", "METHODS & MEANS"). Not a default; these labels exist in the fishing section as a branded voice element, not as a scaffold applied to every section.

### Named Rules
**The Mud Track Ceiling Rule.** Mud Track is reserved for display-level text (20px minimum, 42px maximum) and app bar titles. Anything smaller is Bitter or Inter. Using Mud Track at body or label size destroys its authority.

**The Contrast Floor Rule.** Body text on any surface must hit #ECF2EA or #9DB3A0 against their background — no grays invented for "elegance." Muted text (#5C7260) is permitted only for genuinely tertiary information where the reader is not expected to scan it.

## 4. Elevation

Alaska Atlas uses **tonal layering** over box shadows. Depth is expressed through progressive green fills rather than shadow blur — the surfaces are layers of forest, not floating cards.

The four surface levels (darkest to lightest): `background` (#0B120C) → `surface` (#111B12) → `card` (#152115) → `surfaceElevated` (#1A2A1C). Each step is approximately +4–6 lightness in OKLCH. Cards sit on backgrounds; interactive containers sit on cards. Nothing sits on `surfaceElevated` — that is already the highest elevated layer.

The one exception is the card `elevation: 3` with `shadowColor: Colors.black54` in the theme definition. This serves as a depth cue on iOS where layering alone is insufficient; it is ambient and invisible, not structural.

**The No-Float Rule.** Shadows do not appear on elements at rest. They appear only on bottom sheets and modal surfaces as a structural disambiguation, not as a hover delight effect.

## 5. Components

### Buttons
Tactile and grounded. No animation theater — a button changes color on press and stays at rest otherwise.

- **Shape:** Softly curved (12px radius)
- **Primary (FilledButton):** Pine green background (#4C9A5F), dark forest text (#0B120C), 24px horizontal / 14px vertical padding. Inter 15px weight 700.
- **Hover / Active:** Pine Dark (#2F7042) fill. No elevation change, no scale transform.
- **Ghost / Outline variants:** Used contextually in map and filter UI. Transparent fill, pine border, pine text. `_FilterChip` pattern: `color.withValues(alpha: 0.15)` fill when active.

### Chips
Two distinct chip families — species chips and filter chips:

- **Species Chips:** Colored dot + species name. Background `surfaceElevated` (#1A2A1C), full-pill radius (9999px), species-color dot (8px circle). Tap target 36px minimum height.
- **Filter Chips:** Category filter pills in Rentals and Map. Inactive: `surfaceElevated` fill, `border` (#24382A) stroke. Active: `pine.withValues(alpha: 0.15)` fill, pine border, pine text. Full-pill radius.

### Cards / Containers
- **Corner Style:** Consistently rounded (12–16px). `card` tiles at 16px, `surfaceElevated` containers at 12–14px, bottom sheet at 24px top corners only.
- **Background:** `card` (#152115) for content tiles; `surfaceElevated` (#1A2A1C) for input containers and interactive rows.
- **Shadow Strategy:** Ambient only (elevation 3, black54). No hover shadows.
- **Border:** All cards carry `AppColors.border` (#24382A) as a 1px stroke. Non-optional — the border is what separates the card from the forest-dark background at low brightness.
- **Internal Padding:** 14–16px standard.

### Inputs / Fields
- **Style:** Filled, `surfaceElevated` background (#1A2A1C), 12px radius, `border` (#24382A) stroke at rest.
- **Focus:** Pine border (#4C9A5F, 1.5px). No glow, no background shift.
- **Hint Text:** `textMuted` (#5C7260) at 14px Inter.

### Navigation
- **Bottom nav bar:** `surface` (#111B12) background, 68px height. Selected: pine icon + pine label (Inter 11px weight 700). Unselected: muted icon + muted text (Inter 11px weight 500). Selection indicator: `pine.withValues(alpha: 0.18)` pill behind icon.

### Signature: Species Badge
The `SpeciesBadge` widget — a 40–72px circle with the species accent color as background, a white fish icon centered. Used in species hero headers and as avatar-scale identifiers in browse strips. The color-to-species mapping is fixed in `FishingStyle.colorFor()` and is the single source of truth for the fishing section's color vocabulary.

### Signature: Topo Background
A subtle repeating topographic-line texture rendered as a `CustomPainter` at 0.3 opacity. Applied to every screen's background via the `TopoBackground` widget. The lines use `topoLine` (#1C3322) and `topoLineBright` (#26432D). This is the one purely atmospheric element in the system — it connects every screen to the landscape without adding visual noise.

## 6. Do's and Don'ts

### Do:
- **Do** keep Mud Track exclusively at display/AppBar scale (20px+). Below that, it reads as distressed noise rather than authority.
- **Do** put a `border` (#24382A) stroke on every card and input field. At dark ambient light, the border is the only visual separator between layers.
- **Do** use water blue (#5B8BAB) only in fishing-context UI. It is a domain-specific accent, not a general info color.
- **Do** default to `textSecondary` (#9DB3A0) for body content and reserve `textPrimary` (#ECF2EA) for titles and actively selected states.
- **Do** apply `TopoBackground` at 0.3 opacity to every screen — it is a system-level identity element, not an optional decoration.
- **Do** earn trust through precision: every water name, species, and regulation label must be verified against source data. Copy accuracy is a design decision.

### Don't:
- **Don't** use a light or cream background anywhere in the app. This is a field tool used at dawn. The dark-forest palette is a functional decision.
- **Don't** make government-reg-style walls of unformatted text. The fishing regs exist as the anti-reference; bullet card format and section headers are the remedy.
- **Don't** let the Rentals/gear tab feel like REI or Bass Pro. It is a curated outfitter catalog, not a merchandise storefront. Featured first, shopping last.
- **Don't** use `border-left` or any single-side border stripe as a card accent. Rewrite as a full-border tint or leading icon.
- **Don't** apply Mud Track below 20px or above 42px. At small sizes it becomes illegible; at very large sizes it loses authority.
- **Don't** use pine green (#4C9A5F) and rust (#CD7B3E) simultaneously as prominent elements on the same screen. One accent per surface.
- **Don't** add card elevation shadows on hover/active states. This system uses tonal layering; shadow animation reads as generic SaaS, not field-grade tool.
- **Don't** put a side-stripe left border on any callout, alert, or card. The notes callout in fishing uses a full-border tinted container — that pattern is the system standard.
