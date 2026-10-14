abstract class AppAssets {
  // Private constructor to prevent instantiation
  AppAssets._();

  // Base path
  // TODO : Add Flutter Assets Gen or FlutterGen pakage
  static const String _basePath = 'assets/images';

  static const String splashLogo = '$_basePath/splash_logo.svg';
  static const String googleLogo = '$_basePath/google_logo.svg';

  static const String teslaCar = '$_basePath/tesla.png';
}
