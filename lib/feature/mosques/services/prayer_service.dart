import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerTimesService {
  static PrayerTimes getPrayerTimes(double lat, double lng) {
    final coordinates = Coordinates(lat, lng);
    // Karachi calculation method is standard for Bangladesh/South Asia
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    // Add offsets (in minutes)
    params.adjustments.fajr = 0;
    params.adjustments.sunrise = 0;
    params.adjustments.dhuhr = 60; // <-- shift to ~1:00 PM
    params.adjustments.asr = 0;
    params.adjustments.maghrib = 0;
    params.adjustments.isha = 0;

    return PrayerTimes.today(coordinates, params);
  }

  static String formatTime(DateTime? dt) {
    if (dt == null) return '--:--';
    return DateFormat('h:mm a').format(dt);
  }

  static Prayer getCurrentPrayer(PrayerTimes times) {
    return times.currentPrayer();
  }

  static Prayer getNextPrayer(PrayerTimes times) {
    return times.nextPrayer();
  }

  static List<Map<String, String>> getPrayerList(PrayerTimes times) {
    return [
      {'name': 'Fajr', 'time': formatTime(times.fajr)},
      {'name': 'Sunrise', 'time': formatTime(times.sunrise)},
      {'name': 'Dhuhr', 'time': formatTime(times.dhuhr)},
      {'name': 'Asr', 'time': formatTime(times.asr)},
      {'name': 'Maghrib', 'time': formatTime(times.maghrib)},
      {'name': 'Isha', 'time': formatTime(times.isha)},
    ];
  }

  static String prayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return 'Fajr';
      case Prayer.sunrise:
        return 'Sunrise';
      case Prayer.dhuhr:
        return 'Dhuhr';
      case Prayer.asr:
        return 'Asr';
      case Prayer.maghrib:
        return 'Maghrib';
      case Prayer.isha:
        return 'Isha';
      default:
        return '';
    }
  }
}
