enum PlaceType { mosque, eidgah }

// class Mosque {
//   final String id;
//   final String name;
//   final double lat;
//   final double lng;
//   final String? address;
//   final String? phone;
//   final String? website;
//   final double? rating;
//   double? distanceMeters;

//   Mosque({
//     required this.id,
//     required this.name,
//     required this.lat,
//     required this.lng,
//     this.address,
//     this.phone,
//     this.website,
//     this.rating,
//     this.distanceMeters,
//   });

//   factory Mosque.fromOverpassElement(Map<String, dynamic> element) {
//     final tags = element['tags'] as Map<String, dynamic>? ?? {};

//     double lat;
//     double lng;
//     if (element['type'] == 'node') {
//       lat = (element['lat'] as num).toDouble();
//       lng = (element['lon'] as num).toDouble();
//     } else {
//       // way or relation - use center
//       final center = element['center'] as Map<String, dynamic>? ?? {};
//       lat = (center['lat'] as num? ?? 0).toDouble();
//       lng = (center['lon'] as num? ?? 0).toDouble();
//     }

//     String name = tags['name'] ?? tags['name:en'] ?? tags['name:bn'] ?? 'Mosque';

//     String? address;
//     final parts = <String>[];
//     if (tags['addr:street'] != null) parts.add(tags['addr:street']);
//     if (tags['addr:suburb'] != null) parts.add(tags['addr:suburb']);
//     if (tags['addr:city'] != null) parts.add(tags['addr:city']);
//     if (parts.isNotEmpty) address = parts.join(', ');

//     return Mosque(
//       id: '${element['type']}_${element['id']}',
//       name: name,
//       lat: lat,
//       lng: lng,
//       address: address,
//       phone: tags['phone'] ?? tags['contact:phone'],
//       website: tags['website'] ?? tags['contact:website'],
//     );
//   }

//   String get distanceText {
//     if (distanceMeters == null) return '';
//     if (distanceMeters! < 1000) {
//       return '${distanceMeters!.round()} m';
//     }
//     return '${(distanceMeters! / 1000).toStringAsFixed(1)} km';
//   }
// }

class Mosque {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String? address;
  final String? phone;
  final String? website;
  final double? rating;
  double? distanceMeters;

  // ✅ NEW
  final PlaceType type;

  Mosque({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.address,
    this.phone,
    this.website,
    this.rating,
    this.distanceMeters,
    required this.type, // ✅ NEW
  });

  factory Mosque.fromOverpassElement(Map<String, dynamic> element) {
    final tags = element['tags'] as Map<String, dynamic>? ?? {};

    double lat;
    double lng;

    if (element['type'] == 'node') {
      lat = (element['lat'] as num).toDouble();
      lng = (element['lon'] as num).toDouble();
    } else {
      final center = element['center'] as Map<String, dynamic>? ?? {};
      lat = (center['lat'] as num? ?? 0).toDouble();
      lng = (center['lon'] as num? ?? 0).toDouble();
    }

    // ✅ Better name fallback
    String name =
        tags['name'] ?? tags['name:en'] ?? tags['name:bn'] ?? 'Unknown';

    final lowerName = name.toLowerCase();

    // 🔥 CRITICAL: Eidgah detection (Bangladesh optimized)
    final isEidgah =
        tags['prayer_ground'] == 'yes' ||
        lowerName.contains('eidgah') ||
        lowerName.contains('eid ga') ||
        lowerName.contains('eidgah math') ||
        lowerName.contains('eidgah maath') ||
        lowerName.contains('maath') ||
        lowerName.contains('ঈদগাহ');

    // Address build
    String? address;
    final parts = <String>[];
    if (tags['addr:street'] != null) parts.add(tags['addr:street']);
    if (tags['addr:suburb'] != null) parts.add(tags['addr:suburb']);
    if (tags['addr:city'] != null) parts.add(tags['addr:city']);
    if (parts.isNotEmpty) address = parts.join(', ');

    return Mosque(
      id: '${element['type']}_${element['id']}',
      name: name,
      lat: lat,
      lng: lng,
      address: address,
      phone: tags['phone'] ?? tags['contact:phone'],
      website: tags['website'] ?? tags['contact:website'],
      type: isEidgah ? PlaceType.eidgah : PlaceType.mosque, // ✅ NEW
    );
  }

  String get distanceText {
    if (distanceMeters == null) return '';
    if (distanceMeters! < 1000) {
      return '${distanceMeters!.round()} m';
    }
    return '${(distanceMeters! / 1000).toStringAsFixed(1)} km';
  }

  // ✅ Optional helper (very useful in UI)
  bool get isEidgah => type == PlaceType.eidgah;
}
