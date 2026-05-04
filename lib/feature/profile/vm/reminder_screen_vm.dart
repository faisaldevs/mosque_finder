import 'package:mosque_finder_app/core/base/base_vm.dart';

class ReminderScreenVm extends BaseViewModel<void> {
  // Prayer reminders
  final List<bool> _enabled = [true, true, false, true, true];
  final List<String> _prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  final List<String> _times = [
    '5:12 AM',
    '12:30 PM',
    '4:05 PM',
    '6:18 PM',
    '7:45 PM',
  ];

  // Timing options
  int _timing = 1; // 0=at time, 1=5min, 2=10min, 3=15min
  static const List<String> _timingLabels = [
    'At prayer time',
    '5 min before',
    '10 min before',
    '15 min before',
  ];

  // Getters
  List<bool> get enabled => _enabled;
  List<String> get prayers => _prayers;
  List<String> get times => _times;
  int get timing => _timing;
  List<String> get timingLabels => _timingLabels;

  String getTimingLabel(int index) {
    return _timingLabels[index];
  }

  String getPrayerTime(int index) {
    return _times[index];
  }

  bool isEnabled(int index) {
    return _enabled[index];
  }

  bool isTimingSelected(int index) {
    return index == _timing;
  }

  // Actions
  void togglePrayer(int index) {
    _enabled[index] = !_enabled[index];
    notifyListeners();
  }

  void selectTiming(int index) {
    _timing = index;
    notifyListeners();
  }

  // Save preferences
  Future<void> savePreferences() async {
    await execute(() async {
      // TODO: Save to local storage or API
      await Future.delayed(const Duration(seconds: 1));
    });
  }

  // Load preferences
  Future<void> loadPreferences() async {
    await execute(() async {
      // TODO: Load from local storage or API
      // For now, keep defaults
    });
  }
}
