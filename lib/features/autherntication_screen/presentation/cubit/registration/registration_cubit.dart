import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/registration_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/registration/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _repository;

  RegistrationCubit(this._repository) : super(RegistrationInitial());
  Future<void> registerUser(RegistrationEntity registration) async {
    emit(RegistrationLoading());
    try {
      final response = await _repository.register(registration);
      if (response.status) {
        final token = response.data['data']['token'];
        final name = response.data['data']['name'];

        await CacheHelper.saveData(key: CacheKeys.accessToken, value: token);
        await CacheHelper.saveData(key: CacheKeys.userName, value: name);

        CacheData.accessToken = token;
        CacheData.userName = name;

        emit(RegistrationSuccess());
      } else {
        // Provide more detailed error message
        final errorMsg =
            response.data['message'] ??
            response.message ??
            'Registration failed';
        emit(RegistrationFailure(errorMsg));
      }
    } catch (e) {
      // Provide more specific error message
      emit(
        RegistrationFailure(
          e is DioException
              ? e.message ?? 'Network error'
              : 'An error occurred',
        ),
      );
    }
  }
}
