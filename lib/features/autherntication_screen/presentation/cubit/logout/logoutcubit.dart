import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cache/cache_data.dart';
import 'package:fruit_hub/features/autherntication_screen/domain/usecases/logout.dart';
import 'package:fruit_hub/features/autherntication_screen/presentation/cubit/logout/logoutstate.dart';

class AuthCubit extends Cubit<AuthState> {
  final Logout logout;

  AuthCubit({required this.logout}) : super(AuthInitial());

  Future<void> userLogout() async {
    emit(AuthLoading());
    try {
      final response = await logout();
      if (response.status) {
        await CacheData.clear(); // Clear cache on successful logout
        emit(LogoutSuccess());
      } else {
        emit(AuthError(message: response.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
