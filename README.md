# Alaska Atlas 🏔️

A rugged, dark-forest-green tourism app for the Last Frontier. Built with Flutter for iPhone and Android.

## Features

- **Explore** — curated recommendations: editor's picks, hot spots filterable by category, and "eat like a local" picks.
- **Hot Spot Map** — an interactive statewide map with two base layers (dark atlas / rugged topo), category filters, and rich detail sheets for every pin. No API keys required.
- **Field Guides** — long-form, Alaska-specific know-how: backcountry camping, salmon & halibut fishing, fly fishing for grayling and Dolly Varden, ice fishing, survival, bear & moose safety, aurora hunting, deep-cold layering, off-trail travel, and glacier basics.
- **Rent Gear** — the Turnagain Outfitters rental catalog: camping, fishing, winter, and safety/navigation kits with per-day pricing and booking requests.

## Tech

- Flutter (Material 3, dark theme), Riverpod, go_router
- `flutter_map` with CARTO dark / OpenTopoMap tiles
- Bitter (slab serif) + Inter via Google Fonts
- Turnagain Outfitters catalog served from a bundled offline list, with a
  Base44 connector hook in `lib/services/turnagain_service.dart` that switches
  to live inventory once the app id / API key are configured.

## Running

```sh
flutter pub get
flutter run
```
