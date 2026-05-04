import 'package:mosque_finder_app/app/di/di.dart';
import 'package:mosque_finder_app/core/base/base_vm.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/user_entity.dart';

class LoginVm extends BaseViewModel<User> {
  final LoginRepository _loginRepository;

  LoginVm({LoginRepository? loginRepository})
    : _loginRepository = loginRepository ?? locator<LoginRepository>();

  // Form controllers
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;
  String? _customError;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;

  @override
  String? get error => _customError;

  // Form validation
  bool get isEmailValid {
    if (_email.isEmpty) return false;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(_email);
  }

  bool get isPasswordValid => _password.length >= 6;

  bool get isFormValid => isEmailValid && isPasswordValid;

  // Setters
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Login with email and password
  Future<void> login() async {
    if (!isFormValid) {
      setErrorMessage('Please enter valid email and password');
      return;
    }

    isLoading = true;
    _customError = null;
    notifyListeners();

    try {
      final user = await _loginRepository.login(_email, _password);
      setData(user);
    } catch (e) {
      handleAuthError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      await _loginRepository.logout();
      clearData();
      clearError();
    } catch (e) {
      setErrorMessage('Logout failed: ${e.toString()}');
    }
  }

  /// Check if user is logged in
  Future<bool> checkLoginStatus() async {
    return await _loginRepository.isLoggedIn();
  }

  /// Get current user
  Future<void> loadCurrentUser() async {
    try {
      final user = await _loginRepository.getCurrentUser();
      if (user != null) {
        setData(user);
      }
    } catch (e) {
      setErrorMessage('Failed to load user: ${e.toString()}');
    }
  }

  /// Clear form
  void clearForm() {
    _email = '';
    _password = '';
    _isPasswordVisible = false;
    notifyListeners();
  }

  /// Convert exception to user-friendly message
  void handleAuthError(String errorStr) {
    String message = 'An error occurred';

    if (errorStr.contains('InvalidCredentialsException')) {
      message = 'Invalid email or password';
    } else if (errorStr.contains('UnauthorizedException')) {
      message = 'Unauthorized. Please try again';
    } else if (errorStr.contains('TokenExpiredException')) {
      message = 'Session expired. Please login again';
    } else if (errorStr.contains('NetworkException') ||
        errorStr.contains('SocketException')) {
      message = 'Network error. Please check your connection';
    } else if (errorStr.contains('timeout')) {
      message = 'Request timeout. Please try again';
    }

    setErrorMessage(message);
  }

  /// Set error message
  void setErrorMessage(String message) {
    _customError = message;
    notifyListeners();
  }

  /// Clear error
  @override
  void clearError() {
    _customError = null;
    notifyListeners();
  }

  /// Clear data
  void clearData() {
    data = null;
    notifyListeners();
  }

  // Access to loading state for external use
  @override
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool _isLoading = false;
  User? _userData;

  @override
  User? get data => _userData;

  set data(User? value) {
    _userData = value;
  }

  @override
  void setData(User user) {
    _userData = user;
    notifyListeners();
  }
}
