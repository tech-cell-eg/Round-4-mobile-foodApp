import 'package:fruit_hub/core/network/api_helper.dart';
import 'package:fruit_hub/core/network/api_response.dart';
import 'package:fruit_hub/core/network/end_points.dart';

class AuthRepository {
  final ApiHelper _apiHelper;

  AuthRepository(this._apiHelper);

  Future<ApiResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phoneNumber,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'phone_number': phoneNumber,
        },
        isFormData: true,
      );
      return response;
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
