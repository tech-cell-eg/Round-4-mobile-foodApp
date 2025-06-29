import 'package:flutter/material.dart';

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

class ConfirmPasswordValidator extends AppValidator {
  final TextEditingController passwordController;

  ConfirmPasswordValidator(this.passwordController);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) {
      return 'Passwords do not match';
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

    // يقبل 3 أو 4 أرقام فقط
    final cvvRegex = RegExp(r'^\d{3,4}$');
    if (!cvvRegex.hasMatch(value)) return 'Enter a valid CVV';

    return null;
  }
}

class ExpiryDateValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Expiry date is required';

    final parts = value.split('/');
    if (parts.length != 2) return 'Invalid format. Use MM/YY';

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return 'Invalid date';
    if (month < 1 || month > 12) return 'Invalid month';

    final now = DateTime.now();
    final fullYear = 2000 + year;

    // إنشاء تاريخ الانتهاء في آخر يوم من هذا الشهر
    final expiryDate = DateTime(fullYear, month + 1, 0);

    // التحقق إذا كان التاريخ في الماضي
    if (expiryDate.isBefore(DateTime(now.year, now.month, 1))) {
      return 'Card has expired';
    }

    return null;
  }
}

class CreditCardValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }

    final sanitized = value.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^\d+$').hasMatch(sanitized)) {
      return 'Card number must contain only digits';
    }

    if (!_isValidLuhn(sanitized)) {
      return 'Enter a valid card number';
    }

    return null;
  }

  bool _isValidLuhn(String number) {
    int sum = 0;
    bool isSecond = false;

    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);

      if (isSecond) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
      isSecond = !isSecond;
    }

    return sum % 10 == 0;
  }
}

class HolderNameValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card holder name is required';
    }

    final trimmed = value.trim();

    // تأكد إن الاسم يحتوي على حرفين على الأقل ويفصلهم مسافة
    if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$').hasMatch(trimmed)) {
      return 'Enter full name (first and last)';
    }

    return null;
  }
}

class DeliveryAddressValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Delivery address is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 10) {
      return 'Address is too short';
    }

    // (اختياري) نمنع وجود رموز غير مفهومة
    final invalidChars = RegExp(r'[^\w\s,.-]');
    if (invalidChars.hasMatch(trimmed)) {
      return 'Address contains invalid characters';
    }

    return null;
  }
}




