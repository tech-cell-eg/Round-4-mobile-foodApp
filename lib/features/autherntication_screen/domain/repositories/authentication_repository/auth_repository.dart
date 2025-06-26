// features/autherntication_screen/domain/repositories/auth_repository.dart
import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/authentication_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/registration_entity.dart';

abstract class AuthRepository {
  Future<ApiResponse> register(RegistrationEntity registration);
  Future<ApiResponse> login(LoginEntity login);
  Future<ApiResponse> logout();
}
