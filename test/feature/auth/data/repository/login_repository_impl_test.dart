import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mosque_finder_app/core/networks/exception_handler/auth_exceptions.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/local/local_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_response.dart';
import 'package:mosque_finder_app/feature/auth/data/model/user_model.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository_impl.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteAuthDatasource, LocalAuthDatasource])
void main() {
  late LoginRepositoryImpl repository;
  late MockRemoteAuthDatasource mockRemoteDataSource;
  late MockLocalAuthDatasource mockLocalDataSource;

  final testUser = UserModel(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    isVerified: true,
  );

  final testResponse = LoginResponse(
    accessToken: 'access_token_123',
    refreshToken: 'refresh_token_123',
    user: testUser,
    expiresIn: 3600,
  );

  setUp(() {
    mockRemoteDataSource = MockRemoteAuthDatasource();
    mockLocalDataSource = MockLocalAuthDatasource();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('LoginRepositoryImpl', () {
    group('login', () {
      test('should save token and user locally on successful login', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          mockRemoteDataSource.login(any),
        ).thenAnswer((_) async => testResponse);
        when(
          mockLocalDataSource.saveToken(
            any,
            refreshToken: anyNamed('refreshToken'),
          ),
        ).thenAnswer((_) async {});
        when(mockLocalDataSource.saveUser(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.login(email, password);

        // Assert
        expect(result.email, email);
        expect(result.name, testUser.name);
        verify(mockRemoteDataSource.login(any)).called(1);
        verify(
          mockLocalDataSource.saveToken(
            any,
            refreshToken: anyNamed('refreshToken'),
          ),
        ).called(1);
        verify(mockLocalDataSource.saveUser(any)).called(1);
      });

      test(
        'should throw UnauthorizedException on remote datasource error',
        () async {
          // Arrange
          const email = 'test@example.com';
          const password = 'wrongpassword';

          when(
            mockRemoteDataSource.login(any),
          ).thenThrow(InvalidCredentialsException('Invalid credentials'));

          // Act & Assert
          expect(
            () => repository.login(email, password),
            throwsA(isA<InvalidCredentialsException>()),
          );
          verifyNever(
            mockLocalDataSource.saveToken(
              any,
              refreshToken: anyNamed('refreshToken'),
            ),
          );
        },
      );
    });

    group('refreshToken', () {
      test('should refresh token and update storage on success', () async {
        // Arrange
        const refreshToken = 'refresh_token_123';

        when(
          mockLocalDataSource.getRefreshToken(),
        ).thenAnswer((_) async => refreshToken);
        when(
          mockRemoteDataSource.refreshToken(any),
        ).thenAnswer((_) async => testResponse);
        when(
          mockLocalDataSource.saveToken(
            any,
            refreshToken: anyNamed('refreshToken'),
          ),
        ).thenAnswer((_) async {});
        when(mockLocalDataSource.saveUser(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.refreshToken();

        // Assert
        expect(result.email, testUser.email);
        verify(mockLocalDataSource.getRefreshToken()).called(1);
        verify(mockRemoteDataSource.refreshToken(refreshToken)).called(1);
        verify(
          mockLocalDataSource.saveToken(
            any,
            refreshToken: anyNamed('refreshToken'),
          ),
        ).called(1);
      });

      test('should throw exception when no refresh token is stored', () async {
        // Arrange
        when(
          mockLocalDataSource.getRefreshToken(),
        ).thenAnswer((_) async => null);

        // Act & Assert
        expect(() => repository.refreshToken(), throwsException);
        verifyNever(mockRemoteDataSource.refreshToken(any));
      });

      test(
        'should throw TokenExpiredException on invalid refresh token',
        () async {
          // Arrange
          const refreshToken = 'invalid_token';

          when(
            mockLocalDataSource.getRefreshToken(),
          ).thenAnswer((_) async => refreshToken);
          when(
            mockRemoteDataSource.refreshToken(any),
          ).thenThrow(TokenExpiredException('Token expired'));

          // Act & Assert
          expect(
            () => repository.refreshToken(),
            throwsA(isA<TokenExpiredException>()),
          );
        },
      );
    });

    group('logout', () {
      test(
        'should call remote logout and clear local data on success',
        () async {
          // Arrange
          const token = 'access_token_123';

          when(
            mockLocalDataSource.getAccessToken(),
          ).thenAnswer((_) async => token);
          when(mockRemoteDataSource.logout(any)).thenAnswer((_) async {});
          when(mockLocalDataSource.clearAuth()).thenAnswer((_) async {});

          // Act
          await repository.logout();

          // Assert
          verify(mockLocalDataSource.getAccessToken()).called(1);
          verify(mockRemoteDataSource.logout(token)).called(1);
          verify(mockLocalDataSource.clearAuth()).called(1);
        },
      );

      test('should clear local data even if remote logout fails', () async {
        // Arrange
        const token = 'access_token_123';

        when(
          mockLocalDataSource.getAccessToken(),
        ).thenAnswer((_) async => token);
        when(
          mockRemoteDataSource.logout(any),
        ).thenThrow(NetworkException('Network error'));
        when(mockLocalDataSource.clearAuth()).thenAnswer((_) async {});

        // Act
        await repository.logout();

        // Assert - should still clear local data
        verify(mockLocalDataSource.clearAuth()).called(1);
      });

      test('should handle case when token is null', () async {
        // Arrange
        when(
          mockLocalDataSource.getAccessToken(),
        ).thenAnswer((_) async => null);
        when(mockLocalDataSource.clearAuth()).thenAnswer((_) async {});

        // Act
        await repository.logout();

        // Assert
        verifyNever(mockRemoteDataSource.logout(any));
        verify(mockLocalDataSource.clearAuth()).called(1);
      });
    });

    group('isLoggedIn', () {
      test('should return true when user has token', () async {
        // Arrange
        when(mockLocalDataSource.isLoggedIn()).thenAnswer((_) async => true);

        // Act
        final result = await repository.isLoggedIn();

        // Assert
        expect(result, true);
        verify(mockLocalDataSource.isLoggedIn()).called(1);
      });

      test('should return false when user has no token', () async {
        // Arrange
        when(mockLocalDataSource.isLoggedIn()).thenAnswer((_) async => false);

        // Act
        final result = await repository.isLoggedIn();

        // Assert
        expect(result, false);
        verify(mockLocalDataSource.isLoggedIn()).called(1);
      });
    });

    group('getCurrentUser', () {
      test('should return user when stored locally', () async {
        // Arrange
        when(mockLocalDataSource.getUser()).thenAnswer((_) async => testUser);

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, isNotNull);
        expect(result?.email, testUser.email);
        verify(mockLocalDataSource.getUser()).called(1);
      });

      test('should return null when no user is stored', () async {
        // Arrange
        when(mockLocalDataSource.getUser()).thenAnswer((_) async => null);

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, null);
        verify(mockLocalDataSource.getUser()).called(1);
      });
    });

    group('getAccessToken', () {
      test('should return access token', () async {
        // Arrange
        const token = 'access_token_123';
        when(
          mockLocalDataSource.getAccessToken(),
        ).thenAnswer((_) async => token);

        // Act
        final result = await repository.getAccessToken();

        // Assert
        expect(result, token);
        verify(mockLocalDataSource.getAccessToken()).called(1);
      });
    });
  });
}
