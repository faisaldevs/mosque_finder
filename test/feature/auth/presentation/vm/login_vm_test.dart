import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/user_entity.dart';
import 'package:mosque_finder_app/feature/auth/presentation/vm/login_vm.dart';

import 'login_vm_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late LoginVm viewModel;
  late MockLoginRepository mockLoginRepository;

  final testUser = User(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    phone: '1234567890',
    isVerified: true,
  );

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    viewModel = LoginVm(loginRepository: mockLoginRepository);
  });

  group('LoginVm Form Validation', () {
    test('should validate email correctly', () {
      // Arrange - empty email
      viewModel.setEmail('');
      expect(viewModel.isEmailValid, false);

      // Act - invalid email
      viewModel.setEmail('invalidemail');
      expect(viewModel.isEmailValid, false);

      // Act - valid email
      viewModel.setEmail('test@example.com');
      expect(viewModel.isEmailValid, true);
    });

    test('should validate password correctly', () {
      // Arrange - empty password
      viewModel.setPassword('');
      expect(viewModel.isPasswordValid, false);

      // Act - short password
      viewModel.setPassword('12345');
      expect(viewModel.isPasswordValid, false);

      // Act - valid password
      viewModel.setPassword('password123');
      expect(viewModel.isPasswordValid, true);
    });

    test('should validate complete form', () {
      // Arrange - empty form
      expect(viewModel.isFormValid, false);

      // Act - fill email only
      viewModel.setEmail('test@example.com');
      expect(viewModel.isFormValid, false);

      // Act - fill password
      viewModel.setPassword('password123');
      expect(viewModel.isFormValid, true);

      // Act - invalidate form
      viewModel.setEmail('invalid');
      expect(viewModel.isFormValid, false);
    });
  });

  group('LoginVm Password Visibility', () {
    test('should toggle password visibility', () {
      expect(viewModel.isPasswordVisible, false);

      viewModel.togglePasswordVisibility();
      expect(viewModel.isPasswordVisible, true);

      viewModel.togglePasswordVisibility();
      expect(viewModel.isPasswordVisible, false);
    });
  });

  group('LoginVm Form Management', () {
    test('should clear form', () {
      // Arrange
      viewModel.setEmail('test@example.com');
      viewModel.setPassword('password123');
      viewModel.togglePasswordVisibility();

      // Act
      viewModel.clearForm();

      // Assert
      expect(viewModel.email, '');
      expect(viewModel.password, '');
      expect(viewModel.isPasswordVisible, false);
    });

    test('should update email on setEmail', () {
      const email = 'test@example.com';
      viewModel.setEmail(email);
      expect(viewModel.email, email);
    });

    test('should update password on setPassword', () {
      const password = 'password123';
      viewModel.setPassword(password);
      expect(viewModel.password, password);
    });
  });

  group('LoginVm Error Handling', () {
    test('should handle InvalidCredentialsException', () {
      // Act
      viewModel.handleAuthError(
        'InvalidCredentialsException: Invalid email or password',
      );

      // Assert
      expect(viewModel.error, 'Invalid email or password');
    });

    test('should handle UnauthorizedException', () {
      // Act
      viewModel.handleAuthError('UnauthorizedException: Unauthorized');

      // Assert
      expect(viewModel.error, 'Unauthorized. Please try again');
    });

    test('should handle TokenExpiredException', () {
      // Act
      viewModel.handleAuthError('TokenExpiredException: Session expired');

      // Assert
      expect(viewModel.error, 'Session expired. Please login again');
    });

    test('should handle NetworkException', () {
      // Act
      viewModel.handleAuthError('NetworkException: Network error');

      // Assert
      expect(viewModel.error, 'Network error. Please check your connection');
    });

    test('should handle timeout errors', () {
      // Act
      viewModel.handleAuthError('timeout: Connection timeout');

      // Assert
      expect(viewModel.error, 'Request timeout. Please try again');
    });

    test('should handle generic errors', () {
      // Act
      viewModel.handleAuthError('Some random error');

      // Assert
      expect(viewModel.error, 'An error occurred');
    });

    test('should clear error message', () {
      // Arrange
      viewModel.setErrorMessage('Some error');
      expect(viewModel.error, 'Some error');

      // Act
      viewModel.clearError();

      // Assert
      expect(viewModel.error, null);
    });

    test('should set custom error message', () {
      const message = 'Custom error message';
      viewModel.setErrorMessage(message);
      expect(viewModel.error, message);
    });
  });

  group('LoginVm Data Management', () {
    test('should clear data', () {
      // Act
      viewModel.clearData();

      // Assert
      expect(viewModel.data, null);
    });

    test('should prevent login with invalid form', () async {
      // Arrange
      viewModel.setEmail('invalid');
      viewModel.setPassword('12345');

      // Act
      await viewModel.login();

      // Assert
      expect(viewModel.error, 'Please enter valid email and password');
      expect(viewModel.isLoading, false);
    });
  });

  group('LoginVm Loading State', () {
    test('should have correct initial state', () {
      expect(viewModel.isLoading, false);
      expect(viewModel.error, null);
      expect(viewModel.data, null);
    });
  });
}
