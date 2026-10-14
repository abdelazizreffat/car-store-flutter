import 'package:car_store/core/constants/google_auth_constants.dart';
import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/theme/app_theme.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GoogleSignIn.instance.initialize(
    serverClientId: GoogleAuthConstants.serverClientId,
  );

  await setupServiceLocator();

  runApp(const CarStoreApp());
}

class CarStoreApp extends StatelessWidget {
  const CarStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<FavoritesCubit>(
          create: (_) => sl<FavoritesCubit>()..loadFavorites(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
