import 'package:flutter/material.dart';

mixin ValidatorMixin {
  String? validateRequiredField(dynamic val) {
    if (val == null ||
        (val is num && val == 0) ||
        (val is String && val.trim().isEmpty)) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.trim().isEmpty) return 'Email address cannot be empty';
    final valid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!valid) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String password) {
    password = password.trim();
    if (password.isEmpty) return 'Enter a password for your account';
    if (password.length < 8) return 'At least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String confirmPassword, String password) {
    if (password.isEmpty) return null;
    if (confirmPassword.trim() != password.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateDate(
      String date, String separator, int? earliestYear, int? latestYear) {
    if (date.isEmpty) {
      return 'Date of Birth is required';
    }

    final components = date.split(separator);
    if (components.length != 3) {
      return 'Enter a valid date';
    }

    final month = int.tryParse(components[1]);
    final day = int.tryParse(components[0]);
    final year = int.tryParse(components[2]);

    if (month == null || month > 12 || month < 1) {
      return 'Date month cannot be ${components[1]}';
    }

    if (year == null) {
      return 'Provide a valid year for this date';
    }

    if (earliestYear != null && year < earliestYear) {
      return 'Year cannot be earlier than $earliestYear';
    }

    if (latestYear != null && year > latestYear) {
      return 'Year cannot be after $latestYear';
    }

    final days = DateUtils.getDaysInMonth(year, month);
    if (day == null || day > days || day < 1) {
      return 'Date day cannot be ${components[0]}';
    }
    return null;
  }

  String? validateSSN(String ssn) {
    const pattern = r'^\d{3}-\d{2}-\d{4}$';
    final regExp = RegExp(pattern);
    final isValid = regExp.hasMatch(ssn);
    if (isValid) {
      return null;
    } else {
      return 'Enter a valid social security number';
    }
  }

  String? validateBVN(String bvn) {
    const pattern = r'^[0-9]{11}$';
    final regExp = RegExp(pattern);
    final isValid = regExp.hasMatch(bvn);
    if (isValid) {
      return null;
    } else {
      return 'Enter a valid BVN';
    }
  }

/*   String? validatePhone(String? phone, CountryModel? country) {
    if (country == null) {
      return "Select country's phone code";
    }
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (phone.length < 7) {
      return 'Enter a valid phone number';
    }
    return null;
  } */
}
