import 'package:flutter/material.dart';
import 'package:mosque_finder_app/core/base/base_vm.dart';

class ChangePasswordVm extends BaseViewModel<void> {
  // Form fields
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  // UI state
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  double _strength = 0;
  Color _strColor = const Color(0xFFE0E0E0); // Default border color
  String _strLabel = '';

  // Getters
  String get currentPassword => _currentPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;
  bool get showCurrent => _showCurrent;
  bool get showNew => _showNew;
  bool get showConfirm => _showConfirm;
  double get strength => _strength;
  Color get strColor => _strColor;
  String get strLabel => _strLabel;

  // Setters
  void setCurrentPassword(String value) {
    _currentPassword = value;
    notifyListeners();
  }

  void setNewPassword(String value) {
    _newPassword = value;
    _evalStrength(value);
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void toggleShowCurrent() {
    _showCurrent = !_showCurrent;
    notifyListeners();
  }

  void toggleShowNew() {
    _showNew = !_showNew;
    notifyListeners();
  }

  void toggleShowConfirm() {
    _showConfirm = !_showConfirm;
    notifyListeners();
  }

  // Password strength evaluation
  void _evalStrength(String v) {
    double s = 0;
    if (v.length >= 8) s += 0.34;
    if (v.contains(RegExp(r'[A-Z]'))) s += 0.33;
    if (v.contains(RegExp(r'[0-9!@#\$%^&*]'))) s += 0.33;

    _strength = s;
    if (s <= 0) {
      _strLabel = '';
      _strColor = const Color(0xFFE0E0E0);
    } else if (s <= 0.34) {
      _strLabel = 'Weak';
      _strColor = const Color(0xFFEF4444); // Error color
    } else if (s <= 0.67) {
      _strLabel = 'Fair';
      _strColor = const Color(0xFFF59E0B); // Warning color
    } else {
      _strLabel = 'Strong';
      _strColor = const Color(0xFF10B981); // Success color
    }
  }

  // Validation
  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Current password is required';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9!@#\$%^&*]'))) {
      return 'Password must contain at least one number or symbol';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != _newPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Change password
  Future<void> changePassword() async {
    await execute(() async {
      // TODO: Implement change password API call
      // Validate current password, update with new password
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    });
  }
}
