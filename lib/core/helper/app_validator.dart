abstract class AppValidator {
  String? validate(String? value);
}

class EmailValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }
}

class PasswordValidator extends AppValidator {
  PasswordValidator({this.confirm});
  final String? confirm;
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';

    if (value.isNotEmpty && confirm != null && value != value) {
      return 'Passwords do not match';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}

class PhoneValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';

    // Allow only digits (0-9) and optional '+' prefix
    final phoneRegex = RegExp(r'^\+?[0-9]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Phone number must contain only numbers';
    }

    // Ensure length is reasonable (e.g., 7-15 digits)
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return 'Phone number must be 7-15 digits long';
    }

    return null;
  }
}

class IntegerValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (int.tryParse(value) == null) return 'Enter a valid integer';
    return null;
  }
}

class RequiredValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Field is required';
    return null;
  }
}

class CVVValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'CVV is required';
    final cvvRegex = RegExp(r'^\d{3,4}$');
    if (!cvvRegex.hasMatch(value)) return 'Enter a valid CVV';
    return null;
  }
}
