import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/entities/authentication_entity.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/repositories/authentication_repository/auth_repository.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/authentication/authentication_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repository;

  LoginCubit(this._repository) : super(LoginInitial());

  Future<void> loginUser(LoginEntity login) async {
    emit(LoginLoading());
    try {
      final response = await _repository.login(login);

      if (response.status) {
        print('Login Response: ${response.data}');
        final token = response.data['data']['token'] as String;
        final userData = response.data['data']['user'];
        final username = userData['name'] as String;
        await CacheHelper.saveData(key: CacheKeys.accessToken, value: token);
        await CacheHelper.saveData(key: CacheKeys.userName, value: username);
        CacheData.accessToken = token;
        CacheData.userName = username;
        emit(LoginSuccess());
      } else {
        final errorMsg = response.data['message'] ?? 'Login failed';
        emit(LoginFailure(errorMsg));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: ${e.toString()}'));
    }
  }
}
