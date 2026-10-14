abstract class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://carstore-api.vercel.app/api';

  static const String loginPath = '/auth/login';
  static const String registerPath = '/auth/register';
  static const String verifyEmailPath = '/auth/verify-email';
  static const String refreshTokenPath = '/auth/refresh';
  static const String mePath = '/auth/me';
  static const String forgotPasswordPath = '/auth/forgot-password';
  static const String verifyResetOtpPath = '/auth/verify-reset-otp';
  static const String resetPasswordPath = '/auth/reset-password';
  static const String googleSignIn = '/auth/google/mobile';

  static const String carsPath = '/cars';
  static const String featuredCarsPath = '/cars/featured';
  static const String filterOptionsPath = '/cars/filter-options';

  static const Set<String> skipRefreshPaths = {
    loginPath,
    registerPath,
    verifyEmailPath,
    refreshTokenPath,
    forgotPasswordPath,
    verifyResetOtpPath,
    resetPasswordPath,
  };

  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';
}
