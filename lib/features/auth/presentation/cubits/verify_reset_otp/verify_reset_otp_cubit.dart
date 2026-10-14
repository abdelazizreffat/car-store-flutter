import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'verify_reset_otp_state.dart';

class VerifyResetOtpCubit extends Cubit<VerifyResetOtpState> {
  final AuthRepository _repo;

  VerifyResetOtpCubit({required this._repo}) : super(VerifyResetOtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(VerifyResetOtpLoading());
    final result = await _repo.verifyResetOtp(email: email, otp: otp);
    result.fold(
      (failure) => emit(VerifyResetOtpError(failure.message)),
      (resetToken) =>
          emit(VerifyResetOtpSuccess(email: email, resetToken: resetToken)),
    );
  }
}
