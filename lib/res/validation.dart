
class Validation {
  /// Validates email field
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // if (!emailRegex.hasMatch(value.trim())) {
    //   return 'Enter a valid email address';
    // }

    return null;
  }

  /// Validates password (for login)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // if (value.length < 6) {
    //   return 'Password must be at least 6 characters';
    // }
    return null;
  }

  /// Validates new password (for registration or reset)
  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }

    // if (value.length < 8) {
    //   return 'Password must be at least 8 characters long';
    // }

    // final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    // final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    // final hasDigit = RegExp(r'\d').hasMatch(value);
    // final hasSpecialChar = RegExp(r'[!@#\$&*~]').hasMatch(value);

    // if (!hasUppercase) {
    //   return 'Password must include at least one uppercase letter';
    // }
    // if (!hasLowercase) {
    //   return 'Password must include at least one lowercase letter';
    // }
    // if (!hasDigit) {
    //   return 'Password must include at least one digit';
    // }
    // if (!hasSpecialChar) {
    //   return 'Password must include at least one special character (!@#\$&*~)';
    // }

    return null;
  }

  /// Validates confirm password
  static String? validateConfirmPassword(String? value, String? newPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    // if (value != newPassword) {
    //   return 'Passwords do not match';
    // }
    return null;
  }
  static String? validateOtp(String? value, {int length = 6}) {
    // if (value == null || value.isEmpty) {
    //   return 'OTP is required';
    // }
    // if (value.length != length) {
    //   return 'OTP must be $length digits';
    // }
    // if (!RegExp(r'^\d+$').hasMatch(value)) {
    //   return 'OTP must contain only numbers';
    // }
    return null;
  }
}
