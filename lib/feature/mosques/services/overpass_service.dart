// // import 'dart:convert';
// // import 'dart:developer';

// // import 'package:http/http.dart' as http;

// // import '../models/mosque.dart';

// // class OverpassService {
// //   // Free Overpass API endpoints (rotated for reliability)
// //   static const _endpoints = [
// //     'https://overpass-api.de/api/interpreter',
// //     'https://overpass.kumi.systems/api/interpreter',
// //   ];

// //   static Future<List<Mosque>> fetchNearbyMosques({
// //     required double lat,
// //     required double lng,
// //     int radiusMeters = 3000,
// //   }) async {
// //     // Overpass QL query: find all nodes, ways, and relations tagged as mosques
// //     //     final query = '''
// //     // [out:json][timeout:25];
// //     // (
// //     //   node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
// //     //   way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
// //     //   relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
// //     //   node["building"="mosque"](around:$radiusMeters,$lat,$lng);
// //     //   way["building"="mosque"](around:$radiusMeters,$lat,$lng);
// //     // );
// //     // out center tags;
// //     // ''';
// //     // In overpass_service.dart, modify the query to be more inclusive:
// //     final query =
// //         '''
// // [out:json][timeout:25];
// // (
// //   // Broader search for mosques
// //   node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
// //   way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
// //   relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);

// //   // Also search for building=mosque without religion tag
// //   node["building"="mosque"](around:$radiusMeters,$lat,$lng);
// //   way["building"="mosque"](around:$radiusMeters,$lat,$lng);

// //   // Add these common alternative tags
// //   node["amenity"="mosque"](around:$radiusMeters,$lat,$lng);
// //   way["amenity"="mosque"](around:$radiusMeters,$lat,$lng);

// //   // Search for any place of worship with "mosque" or "masjid" in the name
// //   node["amenity"="place_of_worship"]["name"~"mosque|masjid|mosjid|মসজিদ",i](around:$radiusMeters,$lat,$lng);
// //   way["amenity"="place_of_worship"]["name"~"mosque|masjid|mosjid|মসজিদ",i](around:$radiusMeters,$lat,$lng);
// // );
// // out center tags;
// // ''';
// //     log(
// //       '🔍 Searching for mosques near $lat, $lng with radius $radiusMeters meters',
// //     );

// //     for (final endpoint in _endpoints) {
// //       try {
// //         final response = await http
// //             .post(
// //               Uri.parse(endpoint),
// //               headers: {'Content-Type': 'application/x-www-form-urlencoded'},
// //               body: {'data': query},
// //             )
// //             .timeout(const Duration(seconds: 30));
// //         log('📡 Response status: ${response.statusCode}');

// //         if (response.statusCode == 200) {
// //           final data = jsonDecode(response.body);
// //           final elements = data['elements'] as List<dynamic>;
// //           log('📊 Found ${elements.length} elements from Overpass');

// //           final seen = <String>{};
// //           final mosques = <Mosque>[];

// //           for (final el in elements) {
// //             final mosque = Mosque.fromOverpassElement(
// //               el as Map<String, dynamic>,
// //             );
// //             // Deduplicate by name+approximate position
// //             final key =
// //                 '${mosque.name}_${mosque.lat.toStringAsFixed(3)}_${mosque.lng.toStringAsFixed(3)}';
// //             if (!seen.contains(key) && mosque.lat != 0 && mosque.lng != 0) {
// //               seen.add(key);
// //               mosques.add(mosque);
// //             }
// //           }
// //           log('🕌 After deduplication: ${mosques.length} unique mosques');

// //           return mosques;
// //         } else {
// //           log('❌ Error response: ${response.body}');
// //         }
// //       } catch (e) {
// //         log('❌ Exception: $e');

// //         // Try next endpoint
// //         continue;
// //       }
// //     }

// //     return [];
// //   }
// // }
// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import '../../models/mosque.dart';

// class OverpassService {
//   static const _endpoints = [
//     'https://overpass-api.de/api/interpreter',
//     'https://overpass.kumi.systems/api/interpreter',
//   ];

//   static Future<List<Mosque>> fetchNearbyMosques({
//     required double lat,
//     required double lng,
//     int radiusMeters = 3000,
//   }) async {
//     // Fixed query - use GET request format
//     //     final query =
//     //         '''
//     // [out:json][timeout:25];
//     // (
//     //   node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//     //   way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//     //   relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//     //   node["building"="mosque"](around:$radiusMeters,$lat,$lng);
//     //   way["building"="mosque"](around:$radiusMeters,$lat,$lng);
//     //   node["amenity"="mosque"](around:$radiusMeters,$lat,$lng);
//     //   way["amenity"="mosque"](around:$radiusMeters,$lat,$lng);
//     // );
//     // out center tags;
//     // ''';
//     final query =
//         '''
// [out:json][timeout:25];
// (
//   // Mosques
//   node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//   way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//   relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
//   node["building"="mosque"](around:$radiusMeters,$lat,$lng);
//   way["building"="mosque"](around:$radiusMeters,$lat,$lng);
//   node["amenity"="mosque"](around:$radiusMeters,$lat,$lng);
//   way["amenity"="mosque"](around:$radiusMeters,$lat,$lng);

//   // Eidgah (prayer grounds)
//   node["amenity"="place_of_worship"]["religion"="muslim"]["prayer_ground"="yes"](around:$radiusMeters,$lat,$lng);
//   way["amenity"="place_of_worship"]["religion"="muslim"]["prayer_ground"="yes"](around:$radiusMeters,$lat,$lng);

//   // Name fallback (Bangladesh critical)
//   // node["name"~"eidgah|eid ga(h)?|ঈদগাহ",i](around:$radiusMeters,$lat,$lng);
//   // way["name"~"eidgah|eid ga(h)?|ঈদগাহ",i](around:$radiusMeters,$lat,$lng);
//   node["name"~"eidgah|eid ga(h)?|eidgah math|eidgah maath|ঈদগাহ|ঈদগাহ মাঠ",i](around:$radiusMeters,$lat,$lng);
// way["name"~"eidgah|eid ga(h)?|eidgah math|eidgah maath|ঈদগাহ|ঈদগাহ মাঠ",i](around:$radiusMeters,$lat,$lng);
// );
// out center tags;
// ''';

//     log(
//       '🔍 Searching for mosques near $lat, $lng with radius $radiusMeters meters',
//     );

//     for (final endpoint in _endpoints) {
//       try {
//         // Use GET request with proper headers
//         final uri = Uri.parse(
//           endpoint,
//         ).replace(queryParameters: {'data': query});

//         final response = await http
//             .get(
//               uri,
//               headers: {
//                 'User-Agent': 'MosqueFinder/1.0 (your-email@example.com)',
//                 'Accept': 'application/json',
//               },
//             )
//             .timeout(const Duration(seconds: 30));

//         log('📡 Response status: ${response.statusCode}');

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final elements = data['elements'] as List<dynamic>;

//           log('📊 Found ${elements.length} elements from Overpass');

//           final seen = <String>{};
//           final mosques = <Mosque>[];

//           for (final el in elements) {
//             final mosque = Mosque.fromOverpassElement(
//               el as Map<String, dynamic>,
//             );
//             // Deduplicate by name + exact position for more accuracy
//             final key = '${mosque.name}_${mosque.lat}_${mosque.lng}';
//             if (!seen.contains(key) && mosque.lat != 0 && mosque.lng != 0) {
//               seen.add(key);
//               mosques.add(mosque);
//             }
//           }

//           log('🕌 After deduplication: ${mosques.length} unique mosques');

//           if (mosques.isEmpty) {
//             log(
//               '⚠️ No mosques found in this area. Try increasing radius or check if area has tagged mosques.',
//             );
//           }

//           return mosques;
//         } else if (response.statusCode == 429) {
//           log('⚠️ Rate limited on $endpoint, trying next endpoint...');
//           // Wait a bit before trying next endpoint
//           await Future.delayed(const Duration(seconds: 2));
//           continue;
//         } else {
//           log('❌ Error response (${response.statusCode}): ${response.body}');
//         }
//       } catch (e) {
//         log('❌ Exception with $endpoint: $e');
//         continue;
//       }
//     }

//     log('❌ All endpoints failed');
//     return [];
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/mosque.dart';

class OverpassService {
  static const _endpoints = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
  ];

  static Future<List<Mosque>> fetchNearbyMosques({
    required double lat,
    required double lng,
    int radiusMeters = 5000,
  }) async {
    final query =
        '''
[out:json][timeout:180];
(
  // 🕌 Mosques
  node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
  way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);
  relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lng);

  node["building"="mosque"](around:$radiusMeters,$lat,$lng);
  way["building"="mosque"](around:$radiusMeters,$lat,$lng);

  node["amenity"="mosque"](around:$radiusMeters,$lat,$lng);
  way["amenity"="mosque"](around:$radiusMeters,$lat,$lng);

  // 🌿 Eidgah (proper tag)
  node["amenity"="place_of_worship"]["religion"="muslim"]["prayer_ground"="yes"](around:$radiusMeters,$lat,$lng);
  way["amenity"="place_of_worship"]["religion"="muslim"]["prayer_ground"="yes"](around:$radiusMeters,$lat,$lng);

  // 🔎 Eidgah fallback (Bangladesh naming)
  node["name"~"eidgah|eid ga(h)?|eidgah math|eidgah maath|ঈদগাহ|ঈদগাহ মাঠ",i](around:$radiusMeters,$lat,$lng);
  way["name"~"eidgah|eid ga(h)?|eidgah math|eidgah maath|ঈদগাহ|ঈদগাহ মাঠ",i](around:$radiusMeters,$lat,$lng);
);
out center tags;
''';

    log('🔍 Searching near $lat, $lng (radius: $radiusMeters m)');

    for (final endpoint in _endpoints) {
      try {
        final uri = Uri.parse(
          endpoint,
        ).replace(queryParameters: {'data': query});

        final response = await http.get(
          uri,
          headers: {
            'User-Agent': 'MosqueFinder/1.0 (your-email@example.com)',
            'Accept': 'application/json',
          },
        );
        
        // .timeout(const Duration(seconds: 60));
        log( "Response 2255: ${response.body}" );
        log('📡 Status: ${response.statusCode}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final elements = data['elements'] as List<dynamic>;

          final seen = <String>{};
          final places = <Mosque>[];

          for (final el in elements) {
            final place = Mosque.fromOverpassElement(
              el as Map<String, dynamic>,
            );
            log('Type: ${place.type} | Name: ${place.name}'); // ✅ HERE

            if (place.lat == 0 || place.lng == 0) continue;

            final key = '${place.name}_${place.lat}_${place.lng}';

            if (!seen.contains(key)) {
              seen.add(key);
              places.add(place);
            }
          }

          log('🕌 Total unique places: ${places.length}');
          return places;
        }

        if (response.statusCode == 429) {
          log('⚠️ Rate limited → trying next endpoint');
          await Future.delayed(const Duration(seconds: 2));
          continue;
        }
      } catch (e) {
        log('❌ Error with $endpoint: $e');
        continue;
      }
    }

    log('❌ All endpoints failed');
    return [];
  }
}
