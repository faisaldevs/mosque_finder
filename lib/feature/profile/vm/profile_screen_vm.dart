import 'package:mosque_finder_app/core/base/base_vm.dart';

class ProfileScreenVm extends BaseViewModel<void> {
  // Preferences
  int _calculationMethodIndex = 0; // Default to Muslim World League
  double _searchRadius = 5.0; // Default in km
  bool _azanRemindersEnabled = true;

  static const List<String> _calculationMethods = [
    'Karachi / Hanafi',
    'Muslim World League',
    'Egyptian',
    'North America (ISNA)',
    'Umm Al-Qura',
    'Dubai',
  ];

  static const List<String> _calculationMethodDescriptions = [
    'South Asia · Bangladesh, Pakistan, India',
    'General · Europe, Far East',
    'Egypt, Africa, Syria',
    'USA, Canada',
    'Saudi Arabia',
    'UAE',
  ];

  String get calculationMethod => _calculationMethods[_calculationMethodIndex];
  double get searchRadius => _searchRadius;
  bool get azanRemindersEnabled => _azanRemindersEnabled;
  int get calculationMethodIndex => _calculationMethodIndex;
  List<String> get calculationMethods => _calculationMethods;
  List<String> get calculationMethodDescriptions =>
      _calculationMethodDescriptions;

  void updateCalculationMethod(int index) {
    _calculationMethodIndex = index;
    notifyListeners();
    // TODO: Persist to local storage
  }

  void updateSearchRadius(double radius) {
    _searchRadius = radius;
    notifyListeners();
    // TODO: Persist to local storage
  }

  void toggleAzanReminders(bool enabled) {
    _azanRemindersEnabled = enabled;
    notifyListeners();
    // TODO: Persist to local storage
  }

  // Logout functionality
  Future<void> logout() async {
    // TODO: Implement logout logic
    // Clear user data, tokens, etc.
  }
}
