import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _repo;

  ResetPasswordCubit({required this._repo}) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    final result = await _repo.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
