import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;

  AuthCubit({required this._repo}) : super(AuthInitial());

  // Called once at app start (from SplashView) to determine where to navigate.
  Future<void> checkSession() async {
    emit(AuthLoading());

    final hasToken = await _repo.hasValidSession();

    if (!hasToken) {
      emit(AuthUnauthenticated());
      return;
    }

    // Token exists — verify it's still valid with the API.
    final result = await _repo.getCurrentUser();

    result.fold((_) {
      _repo.clearSession();
      emit(AuthUnauthenticated());
    }, (user) => emit(AuthAuthenticated(user)));
  }

  // Called after successful login or email verification.
  void setAuthenticated(UserModel user) => emit(AuthAuthenticated(user));

  void logout() {
    _repo.clearSession();
    emit(AuthUnauthenticated());
  }
}
