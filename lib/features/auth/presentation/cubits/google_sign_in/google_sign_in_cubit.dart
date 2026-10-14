import 'package:bloc/bloc.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/services/google_sign_in_service.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final AuthRepository _repo;
  final GoogleSignInService _googleService;

  GoogleSignInCubit({required this._repo, required this._googleService})
    : super(GoogleSignInInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());

    final idToken = await _googleService.getIdToken();

    if (idToken == null) {
      emit(const GoogleSignInError(AppStrings.googleSignInFailed));
      return;
    }

    final result = await _repo.googleSignIn(idToken);

    result.fold(
      (failure) => emit(GoogleSignInError(failure.message)),
      (user) => emit(GoogleSignInSuccess(user)),
    );
  }
}
