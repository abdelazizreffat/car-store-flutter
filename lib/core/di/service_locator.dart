import 'package:car_store/core/network/auth_interceptor.dart';
import 'package:car_store/core/network/dio_factory.dart';
import 'package:car_store/core/services/google_sign_in_service.dart';
import 'package:car_store/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:car_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/google_sign_in/google_sign_in_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_email/verify_email_cubit.dart';
import 'package:car_store/features/auth/presentation/cubits/verify_reset_otp/verify_reset_otp_cubit.dart';
import 'package:car_store/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository_impl.dart';
import 'package:car_store/features/cars/presentation/cubits/car_details_cubit.dart';
import 'package:car_store/features/favorites/data/favorites_local_data_source.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:car_store/features/home/presentation/cubits/home_cubit.dart';
import 'package:car_store/features/home/presentation/cubits/search_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // Network
  sl.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(storage: sl()));
  sl.registerLazySingleton(() => DioFactory.createDio(authInterceptor: sl()));

  // Auth data sources + repository
  sl.registerLazySingleton(() => AuthRemoteDataSource(dio: sl()));
  sl.registerLazySingleton(() => AuthLocalDataSource(storage: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: sl(), local: sl()));

  // Cars data source + repository
  sl.registerLazySingleton(() => CarsRemoteDataSource(sl()));
  sl.registerLazySingleton<CarsRepository>(() => CarsRepositoryImpl(sl()));

  // Favorites
  sl.registerLazySingleton(
      () => FavoritesLocalDataSource(sl<FlutterSecureStorage>()));

  // Services
  sl.registerLazySingleton(() => GoogleSignInService());

  // Auth cubits
  sl.registerFactory(() => AuthCubit(repo: sl()));
  sl.registerFactory(() => LoginCubit(repo: sl()));
  sl.registerFactory(() => RegisterCubit(repo: sl()));
  sl.registerFactory(() => VerifyEmailCubit(repo: sl()));
  sl.registerFactory(() => ForgotPasswordCubit(repo: sl()));
  sl.registerFactory(() => VerifyResetOtpCubit(repo: sl()));
  sl.registerFactory(() => ResetPasswordCubit(repo: sl()));
  sl.registerFactory(
      () => GoogleSignInCubit(repo: sl(), googleService: sl()));

  // Cars cubits
  sl.registerFactory(() => HomeCubit(repo: sl()));
  sl.registerFactory(() => SearchCubit(repo: sl()));
  sl.registerFactory(() => CarDetailsCubit(repo: sl()));
  sl.registerFactory(
      () => FavoritesCubit(local: sl(), repo: sl()));
}