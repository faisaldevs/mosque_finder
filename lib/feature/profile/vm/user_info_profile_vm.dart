import 'package:mosque_finder_app/core/base/base_vm.dart';

class UserInfoProfileVm extends BaseViewModel<void> {
  // Form fields
  String _fullName = '';
  String _phoneNumber = '';
  String _email = '';
  String _city = '';

  // Getters
  String get fullName => _fullName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get city => _city;

  // Validation
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Basic phone validation - can be improved
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return null; // Optional
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  // Setters
  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  // Save changes
  Future<void> saveChanges() async {
    await execute(() async {
      // TODO: Implement save logic - API call or local storage
      // For now, just simulate success
      await Future.delayed(const Duration(seconds: 1));
    });
  }

  // Load user data
  Future<void> loadUserData() async {
    await execute(() async {
      // TODO: Load from API or local storage
      // For now, set some default values
      _fullName = 'Faisal Ahmed';
      _phoneNumber = '+880 1712 345 678';
      _email = '';
      _city = 'Dhaka';
    });
  }
}
