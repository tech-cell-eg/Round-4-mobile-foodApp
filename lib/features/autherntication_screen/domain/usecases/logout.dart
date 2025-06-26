import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout({required this.authRepository});

  Future<ApiResponse> call() async {
    return await authRepository.logout();
  }
}
