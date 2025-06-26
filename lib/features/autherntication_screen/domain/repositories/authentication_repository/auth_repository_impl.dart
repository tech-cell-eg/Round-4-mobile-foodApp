// features/autherntication_screen/data/repositories/auth_repository_impl.dart
import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/core/network/end_points.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/authentication_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/registration_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiHelper _apiHelper;

  AuthRepositoryImpl(this._apiHelper);

  @override
  Future<ApiResponse> register(RegistrationEntity registration) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': registration.name,
          'email': registration.email,
          'password': registration.password,
          'password_confirmation': registration.passwordConfirmation,
          'phone_number': registration.phoneNumber,
        },
        isFormData: true,
      );

      if (response.status &&
          response.data['data'] != null &&
          response.data['data']['token'] != null) {
        return response;
      } else {
        return ApiResponse(
          status: false,
          statusCode: response.statusCode,
          message: response.data['message'] ?? 'Registration failed',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  @override
  Future<ApiResponse> login(LoginEntity login) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': login.email, 'password': login.password},
      );

      if (response.status &&
          response.data['data'] != null &&
          response.data['data']['token'] != null) {
        return response;
      } else {
        return ApiResponse(
          status: false,
          statusCode: response.statusCode,
          message: response.data['message'] ?? 'Login failed',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
