import 'package:flutter/material.dart';

class TextControllers {
  // Static controllers that can be accessed directly without creating an instance
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController dateController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
 static final TextEditingController inTimeController = TextEditingController();
 static final TextEditingController outTimeController = TextEditingController();
 static final TextEditingController lunchInTimeController = TextEditingController();
 static final TextEditingController lunchOutTimeController = TextEditingController();

  static void disposeAll() {
    emailController.dispose();
    passwordController.dispose();
    dateController.dispose();
    nameController.dispose();
    // Dispose all others
  }
}
