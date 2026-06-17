---
target: fishing flow
total_score: 21
p0_count: 1
p1_count: 2
timestamp: 2026-06-16T21-44-14Z
slug: lib-screens-fishing
---
## Design Health Score — Alaska Atlas: Fishing Flow

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 2 | No data-freshness indicator; "COMING SOON" works but no loading states or dates on regulation data |
| 2 | Match System / Real World | 2 | "Sub-region" and "regulated water" are ADF&G administrative terms; anglers think in river systems and drainages |
| 3 | User Control and Freedom | 2 | No breadcrumb; users arriving via search are orphaned in the hierarchy with only the system back button |
| 4 | Consistency and Standards | 3 | Visually cohesive; border-radius values drift (16/14/12) across cards without a single token |
| 5 | Error Prevention | 2 | Safety-critical disclaimer is buried below all region cards in 11px textMuted text |
| 6 | Recognition Rather Than Recall | 2 | Water screen omits region/subregion context; no reverse lookup |
| 7 | Flexibility and Efficiency | 3 | Global search shortcut is well-designed; species chips from water screens enable forward branching |
| 8 | Aesthetic and Minimalist Design | 2 | Strong palette and topo texture, undercut by icon monoculture and eyebrow saturation |
| 9 | Error Recovery | 1 | Species-not-found fallback is a bare AppBar + centered muted text with no action |
| 10 | Help and Documentation | 2 | Disclaimer links to adfg.alaska.gov but cites no regulation year; no in-app glossary |
| **Total** | | **21/40** | **Acceptable — significant improvements needed** |

## Anti-Patterns Verdict

**LLM assessment:** Strong foundation (per-species color system, topo texture, search-first IA) undercut by three patterns:
1. Icons.phishing for all 13 species — icon monoculture, zero identification value
2. Eyebrow saturation — 10 uppercase section markers across 5 screens
3. Triple-identical _InfoCard on species screen — no visual hierarchy between use-case priorities

**Deterministic scan:** detect.mjs failed — missing scripts/lib/impeccable-config.mjs. Analysis is code-review-based only.

## Overall Impression

Capable dark-mode utility app that falls short of the "Trapper's Field Journal" north star. Data model and IA are smart; visual execution and UX copywriting need work. Most urgent issues are correctness/safety, not aesthetics.

## What's Working

1. Per-species color system (13 distinct species-accurate colors as design tokens)
2. Search-first architecture with flattened water index
3. Topo background at calibrated 30% opacity

## Priority Issues

**[P0] Safety-critical disclaimer is invisible**
- 11px textMuted text buried at the bottom of the regions screen
- User acting on omitted bag/length limit data could violate ADF&G regulations
- Fix: Prominent warning banner near top of regions screen + one-liner on each water screen; add regulation year

**[P1] Icons.phishing x 13 species = no visual taxonomy**
- Same fishhook icon for every species; screen readers announce "phishing" 13 times
- Add Semantics(label: species) to all badges/chips immediately; source fish silhouettes for v1.1

**[P1] No breadcrumb context on water screen**
- Water screen shows no region or subregion; users arriving via search are context-blind
- Fix: Add region/subregion subtitle line; _WaterHit already carries this data

**[P2] Info card ordering doesn't match fisher priority**
- Tactics & Gear is last; it's what the angler needs first at streamside
- Fix: Reorder to Prime Window → Tactics & Gear → Identification → Habitat

**[P2] textMuted fails WCAG AA at small sizes**
- ~3.0:1 contrast on disclaimer (11px), stat chip labels, scientific name variants
- Fix: Shift textMuted to ~0xFF7A9A80 (~4.6:1)

## Persona Red Flags

**Casey (Mobile, on the river):** Disclaimer never reached; species/methods conflation on water screen; no recently viewed waters

**Jordan (First-Timer):** "Sub-region" unexplained; "regulated water" implies unsafe alternatives; species strip and region cards have no explanatory context; species screen is a dead end

**Sam (Screen Reader):** All species badges read "phishing"; bullet dots are not semantic lists; stagger animation has no live region announcement

**The Experienced Alaska Fisher:** 5-6 taps to reach a specific water via browse; ADF&G administrative region names; no favorites/recents

## Minor Observations

- fontSize 9.5 (scientific name) and 9 (COMING SOON pill) below readable field-condition minimum
- No debounce on search onChanged
- Colors.white in SpeciesChip (not AppColors token)
- SliverAppBar expandedHeight varies: 124/132/150/196px across detail screens
- Border radius hardcoded per-widget (16/14/13/12) — no named scale
- Stagger animation peaks at 670ms for 13th card; cap at 400ms
- FishingRegionScreen class lives in fishing_subregion_screen.dart — naming mismatch

## Questions to Consider

1. Searcher vs. browser: which is the primary entry? Should search be the dominant hero with browse as secondary?
2. Data freshness: is the regulation data static per app version? Users need a regulation year.
3. Is "subregion" meaningful to anglers vs. drainage-system navigation?
4. Bag-limit strategy: legal/liability, data-freshness, or scope decision?
