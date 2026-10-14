import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepository _repo;

  VerifyEmailCubit({required this._repo}) : super(VerifyEmailInitial());

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(VerifyEmailLoading());

    final result = await _repo.verifyEmail(email: email, otp: otp);

    result.fold(
      // API returns the remaining attempts in the message — pass it through directly.
      (failure) => emit(VerifyEmailError(failure.message)),
      (user) => emit(VerifyEmailSuccess(user)),
    );
  }
}
