abstract class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required.';
    }
    final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (value != password) {
      return 'Passwords do not match.';
    }

    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required.';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP code is required.';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'OTP must be exactly 6 digits.';
    }

    return null;
  }
}
