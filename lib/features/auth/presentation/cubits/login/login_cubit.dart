import 'package:bloc/bloc.dart';
import 'package:car_store/features/auth/data/models/login_result.dart';
import 'package:car_store/features/auth/data/models/requests/login_request_body.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repo;

  LoginCubit({required this._repo}) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await _repo.login(
      LoginRequestBody(email: email, password: password),
    );

    switch (result) {
      case LoginResultSuccess(:final user):
        emit(LoginSuccess(user));
      case LoginResultEmailNotVerified(:final email):
        emit(LoginEmailNotVerified(email));
      case LoginResultFailure(:final failure):
        emit(LoginError(failure.message));
    }
  }
}
