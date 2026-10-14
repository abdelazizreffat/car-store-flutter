import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/models/requests/register_request_body.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _repo;

  RegisterCubit({required this._repo}) : super(RegisterInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    final body = RegisterRequestBody.fromFullName(
      fullName: fullName,
      email: email,
      password: password,
    );

    final result = await _repo.register(body);

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      // Pass email to state so VerifyEmailView can use it without asking the user again.
      (data) => emit(RegisterSuccess(data.email ?? email)),
    );
  }
}
