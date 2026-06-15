# Lake bathymetry data

Survey-accurate depth contours for the Lake Charts feature, digitized from
**Alaska Department of Fish & Game** bathymetric maps and used **with ADF&G's
written permission**. ADF&G is credited in the app per that permission.

## How a lake gets accurate depths

1. Obtain the lake's ADF&G contour map (ALDAT / the Cook Inlet Morphometric
   Atlas / the Anchorage Lakes PDF) — or a GIS shapefile if ADF&G provides one.
2. Georeference the map and trace each depth contour into a polygon (QGIS,
   or any GIS tool), then export GeoJSON in WGS84 (EPSG:4326).
3. Save it here as `{lakeId}.geojson` — the id must match `Lake.id`
   in `lib/data/lakes_data.dart` (e.g. `jewel.geojson`, `delong.geojson`).

The app loads it automatically (`BathymetryLoader`) and the map renders the
real contours in place of the stylized rings. No code changes needed.

## File schema

A GeoJSON `FeatureCollection`. Each feature is the area at least `depth_ft`
deep — i.e. one isobath polygon per surveyed depth. Coordinates are
`[longitude, latitude]` (GeoJSON order), WGS84.

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": { "depth_ft": 0 },
      "geometry": { "type": "Polygon", "coordinates": [ [ [lng, lat], ... ] ] }
    },
    {
      "type": "Feature",
      "properties": { "depth_ft": 5 },
      "geometry": { "type": "Polygon", "coordinates": [ [ [lng, lat], ... ] ] }
    }
  ]
}
```

Notes:
- `depth_ft: 0` is the shoreline; deeper contours nest inside it.
- `Polygon` (with optional holes) and `MultiPolygon` are both supported.
- Depths are feet. If a source is in meters, convert on export (× 3.281).
