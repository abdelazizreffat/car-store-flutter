import 'package:car_store/features/auth/presentation/views/forgot_password_view.dart';
import 'package:car_store/features/auth/presentation/views/login_view.dart';
import 'package:car_store/features/auth/presentation/views/reset_password_view.dart';
import 'package:car_store/features/auth/presentation/views/sign_up_view.dart';
import 'package:car_store/features/auth/presentation/views/verify_email_view.dart';
import 'package:car_store/features/auth/presentation/views/verify_reset_otp_view.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/presentation/views/car_details_view.dart';
import 'package:car_store/features/home/presentation/views/home_view.dart';
import 'package:car_store/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kLoginView = '/login';
  static const kSignUpView = '/signUp';
  static const kVerifyEmailView = '/verifyEmail';
  static const kHomeView = '/home';
  static const kForgotPasswordView = '/forgotPassword';
  static const kVerifyResetOtpView = '/verifyResetOtp';
  static const kResetPasswordView = '/resetPassword';
  static const kCarDetailsView = '/car';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
          path: kSplashView,
          builder: (_, _) => const SplashView()),
      GoRoute(
          path: kLoginView,
          builder: (_, _) => const LoginView()),
      GoRoute(
          path: kSignUpView,
          builder: (_, _) => const SignUpView()),
      GoRoute(
          path: kVerifyEmailView,
          builder: (_, state) => VerifyEmailView(
              email: state.uri.queryParameters['email'] ?? '')),
      GoRoute(
          path: kHomeView,
          builder: (_, _) => const HomeView()),
      GoRoute(
          path: kForgotPasswordView,
          builder: (_, state) => ForgotPasswordView(
              prefillEmail: state.uri.queryParameters['email'] ?? '')),
      GoRoute(
          path: kVerifyResetOtpView,
          builder: (_, state) => VerifyResetOtpView(
              email: state.uri.queryParameters['email'] ?? '')),
      GoRoute(
          path: kResetPasswordView,
          builder: (_, state) => ResetPasswordView(
              email: state.uri.queryParameters['email'] ?? '')),
      GoRoute(
        path: '$kCarDetailsView/:carId',
        builder: (_, state) => CarDetailsView(
          carId: state.pathParameters['carId'] ?? '',
          prefetched: state.extra as CarModel?,
        ),
      ),
    ],
  );
}