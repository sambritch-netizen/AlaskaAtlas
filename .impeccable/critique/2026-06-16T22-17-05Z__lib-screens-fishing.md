---
target: lib/screens/fishing
total_score: 30
p0_count: 0
p1_count: 1
timestamp: 2026-06-16T22-17-05Z
slug: lib-screens-fishing
---
## Design Health Score — Fishing Flow (post-fix)

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3 | Breadcrumb now shows region · sub on water screen |
| 2 | Match System / Real World | 4 | Species monograms + place-named breadcrumbs read in angler language |
| 3 | User Control and Freedom | 3 | No clear path from species → back to source water |
| 4 | Consistency and Standards | 4 | Section-header trailing slot standardized; species tokens uniform |
| 5 | Error Prevention | 3 | Reg banner warns before users assume bag/length shown |
| 6 | Recognition Rather Than Recall | 3 | Breadcrumb removes recall burden |
| 7 | Flexibility and Efficiency | 2 | No search-within-region, no recents, no favorites |
| 8 | Aesthetic and Minimalist Design | 3 | Hero-metrics removed; primary/secondary hierarchy on species |
| 9 | Error Recovery | 2 | No real error states |
| 10 | Help and Documentation | 3 | Reg banner cites 2025 ADF&G + emergency-order URL |
| **Total** | | **30/40** | **Good** |

## Anti-Patterns Verdict
LLM: no longer reads AI-generated. Species monogram on colored token is committed. Banner uses full-border tinted container. No hero-metric template.
Deterministic scan: unavailable (detect.mjs missing config module).

## Priority Issues
- [P1] Species detail dead-ends back to root nav. Add "More at this water" chip strip.
- [P2] No favorites/recents. Star + Recent section at top of regions screen.
- [P3] Static empty state for missing species profile. Show name, color token, back link.

## Persona Red Flags
Casey: species → other species on same water is 3 taps; chip strip → 1.
Alex: no favorites/recents; drills root every session.
Sam: Semantics added on badges + chips. Risk: 10–12px text under accessibility scaling.

## Minor Observations
- Icons.phishing still on water hero (line 75); replace with Icons.water.
- Guides stagger ~555ms at edge of tolerance.
- Breadcrumb truncation: region truncates before sub; flip order.
