# 🕌 Mosque Finder — Flutter MVP

Find mosques near you using **100% free, no-API-key** services.

## Free APIs Used

| Service | What it does | Cost |
|---|---|---|
| **OpenStreetMap** | Map tiles (background map) | Free forever |
| **Overpass API** | Mosque data (location, name, address) | Free forever |
| **Adhan (offline)** | Prayer time calculation | Free, no internet needed |

No Google Maps API key. No credit card. No limits for personal use.

---

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── mosque.dart              # Mosque data model
├── screens/
│   ├── home_screen.dart         # Map + list view
│   └── detail_screen.dart       # Mosque detail + prayer times
└── services/
    ├── location_service.dart    # GPS location
    ├── overpass_service.dart    # Fetch mosques from OSM
    └── prayer_service.dart      # Prayer time calculation
```

---

## Setup Instructions

### 1. Install Flutter
Make sure Flutter is installed: https://docs.flutter.dev/get-started/install

### 2. Get dependencies
```bash
cd mosque_finder
flutter pub get
```

### 3. Android — no extra setup needed!
The AndroidManifest.xml already has location permissions.

### 4. iOS — no extra setup needed!
Info.plist already has location usage descriptions.

### 5. Run the app
```bash
flutter run
```

---

## Features

- **Interactive map** using OpenStreetMap tiles (flutter_map)
- **Nearby mosque search** via Overpass API (Overpass QL query)
- **Distance calculation** and sorted list view
- **Prayer times** (Fajr, Dhuhr, Asr, Maghrib, Isha) calculated offline
  - Uses Hanafi/Karachi method (standard for Bangladesh/South Asia)
- **Directions** — opens Google Maps or browser for navigation
- **Tap any pin** for quick mosque info sheet
- **Detail screen** with full prayer schedule

---

## Overpass API Query Explained

```
[out:json][timeout:25];
(
  node["amenity"="place_of_worship"]["religion"="muslim"](around:3000,LAT,LNG);
  way["amenity"="place_of_worship"]["religion"="muslim"](around:3000,LAT,LNG);
  relation[...](around:...);
  node["building"="mosque"](...);
  way["building"="mosque"](...);
);
out center tags;
```

This finds all OSM elements tagged as mosques within 3km of the user. The `out center tags` returns the center coordinate for ways/relations (polygons) and all metadata tags.

---

## Customization

**Change search radius** — in `overpass_service.dart`:
```dart
radiusMeters: 3000   // change to 5000 for 5km
```

**Change prayer method** — in `prayer_service.dart`:
```dart
CalculationMethod.karachi     // for BD/Pakistan/India
CalculationMethod.muslimWorldLeague  // for general use
CalculationMethod.egyptian    // for Egypt/Africa
CalculationMethod.northAmerica // for USA/Canada
```

**Change map style** — replace the tile URL in `home_screen.dart`:
```dart
// Standard OSM
urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'

// Humanitarian style (better for South Asia)
urlTemplate: 'https://tile-{s}.openstreetmap.fr/hot/{z}/{x}/{y}.png'

// CyclOSM (clear streets)
urlTemplate: 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png'
```

---

## Packages Used

- `flutter_map` — OSM map rendering (no Google Maps SDK)
- `latlong2` — coordinate types for flutter_map
- `geolocator` — GPS location
- `http` — HTTP requests to Overpass API
- `adhan` — offline prayer time calculation
- `url_launcher` — open directions in external maps app
- `intl` — time formatting

---

## OSM Usage Policy

OpenStreetMap tiles are free for reasonable use. For a production app with many users, consider:
- Self-hosting tiles with a tool like `tileserver-gl`
- Using a tile provider like Stadia Maps (free tier available)
- Caching tiles locally to reduce requests
