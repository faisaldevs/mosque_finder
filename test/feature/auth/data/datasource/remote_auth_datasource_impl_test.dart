import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mosque_finder_app/core/networks/exception_handler/auth_exceptions.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource_impl.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_request.dart';

import 'remote_auth_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late RemoteAuthDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = RemoteAuthDatasourceImpl(mockDio);
  });

  group('RemoteAuthDatasourceImpl', () {
    group('login', () {
      test('should return LoginResponse on successful login', () async {
        // Arrange
        final request = LoginRequest(
          email: 'test@example.com',
          password: 'password123',
        );
        final responseData = {
          'access_token': 'access_token_123',
          'refresh_token': 'refresh_token_123',
          'user': {
            'id': '1',
            'email': 'test@example.com',
            'name': 'Test User',
            'is_verified': true,
          },
          'expires_in': 3600,
        };

        when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await datasource.login(request);

        // Assert
        expect(result.accessToken, 'access_token_123');
        expect(result.refreshToken, 'refresh_token_123');
        expect(result.user.email, 'test@example.com');
        verify(mockDio.post(any, data: anyNamed('data'))).called(1);
      });

      test(
        'should throw InvalidCredentialsException on 400 response',
        () async {
          // Arrange
          final request = LoginRequest(
            email: 'test@example.com',
            password: 'wrongpassword',
          );

          when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/auth/v1/login'),
              response: Response(
                statusCode: 400,
                statusMessage: 'Invalid credentials',
                requestOptions: RequestOptions(path: ''),
              ),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act & Assert
          expect(
            () => datasource.login(request),
            throwsA(isA<InvalidCredentialsException>()),
          );
        },
      );

      test('should throw UnauthorizedException on 401 response', () async {
        // Arrange
        final request = LoginRequest(
          email: 'test@example.com',
          password: 'password123',
        );

        when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/v1/login'),
            response: Response(
              statusCode: 401,
              statusMessage: 'Unauthorized',
              requestOptions: RequestOptions(path: ''),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        // Act & Assert
        expect(
          () => datasource.login(request),
          throwsA(isA<UnauthorizedException>()),
        );
      });

      test('should throw NetworkException on timeout', () async {
        // Arrange
        final request = LoginRequest(
          email: 'test@example.com',
          password: 'password123',
        );

        when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/v1/login'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => datasource.login(request),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('refreshToken', () {
      test('should return LoginResponse on successful token refresh', () async {
        // Arrange
        const refreshToken = 'refresh_token_123';
        final responseData = {
          'access_token': 'new_access_token_123',
          'refresh_token': 'new_refresh_token_123',
          'user': {'id': '1', 'email': 'test@example.com', 'name': 'Test User'},
        };

        when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await datasource.refreshToken(refreshToken);

        // Assert
        expect(result.accessToken, 'new_access_token_123');
        expect(result.refreshToken, 'new_refresh_token_123');
        verify(mockDio.post(any, data: anyNamed('data'))).called(1);
      });

      test('should throw TokenExpiredException on 401 response', () async {
        // Arrange
        const refreshToken = 'invalid_refresh_token';

        when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/v1/login'),
            response: Response(
              statusCode: 401,
              statusMessage: 'Unauthorized',
              requestOptions: RequestOptions(path: ''),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        // Act & Assert
        expect(
          () => datasource.refreshToken(refreshToken),
          throwsA(isA<TokenExpiredException>()),
        );
      });
    });

    group('logout', () {
      test('should call logout endpoint with token', () async {
        // Arrange
        const token = 'access_token_123';

        when(mockDio.post(any, options: anyNamed('options'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        await datasource.logout(token);

        // Assert
        verify(mockDio.post(any, options: anyNamed('options'))).called(1);
      });

      test('should handle logout error gracefully', () async {
        // Arrange
        const token = 'access_token_123';

        when(mockDio.post(any, options: anyNamed('options'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/v1/logout'),
            type: DioExceptionType.unknown,
          ),
        );

        // Act & Assert - should not throw
        expect(() => datasource.logout(token), returnsNormally);
      });
    });
  });
}
