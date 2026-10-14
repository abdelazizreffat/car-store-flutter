import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _repo;

  ForgotPasswordCubit({required this._repo}) : super(ForgotPasswordInitial());

  Future<void> sendOtp(String email) async {
    emit(ForgotPasswordLoading());
    final result = await _repo.forgotPassword(email);
    result.fold(
      (failure) => emit(ForgotPasswordError(failure.message)),
      (_) => emit(ForgotPasswordOtpSent(email)),
    );
  }
}
