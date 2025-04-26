import 'dart:developer';

class AppValidator {
  AppValidator._();

  static String? validateEmailCreation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // Trim the value
    final email = value.trim();

    // Check for basic email pattern
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    // Check for spaces in the email
    if (email.contains(' ')) {
      return 'Email should not contain spaces';
    }

    // Check for multiple @ symbols
    if ('@'.allMatches(email).length > 1) {
      return 'Email should contain only one @ symbol';
    }

    // Check domain validity
    final parts = email.split('@');
    if (parts.length != 2) return 'Invalid email format';

    final domain = parts[1];
    if (domain.isEmpty) {
      return 'Domain part is missing';
    }

    // Check for valid domain extension
    if (!RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(domain)) {
      return 'Invalid domain format';
    }

    // Check for consecutive dots
    if (domain.contains('..')) {
      return 'Domain should not contain consecutive dots';
    }

    // Check for top-level domain length
    final domainParts = domain.split('.');
    if (domainParts.length < 2) {
      return 'Invalid domain structure';
    }

    final tld = domainParts.last;
    if (tld.length < 2) {
      return 'Top-level domain should be at least 2 characters';
    }

    // Check for common disposable email domains
    const disposableDomains = [
      'tempmail.com',
      'mailinator.com',
      '10minutemail.com',
      'guerrillamail.com',
      'throwawaymail.com',
      'fakeinbox.com',
    ];

    if (disposableDomains.any((d) => domain.toLowerCase().contains(d))) {
      return 'Disposable email addresses are not allowed';
    }

    // Additional professional checks
    if (email.startsWith('.')) {
      return 'Email should not start with a dot';
    }

    if (email.endsWith('.')) {
      return 'Email should not end with a dot';
    }

    return null; // Return null if validation succeeds
  }

  //!=====================================================================
  static String? getEmailSuggestion(String email) {
    final commonDomains = [
      'gmail.com',
      'yahoo.com',
      'outlook.com',
      'hotmail.com',
    ];
    final parts = email.split('@');

    if (parts.length == 2) {
      final domain = parts[1].toLowerCase();
      final matchedDomain = commonDomains.firstWhere(
        (d) => d.startsWith(domain) || domain.startsWith(d),
        orElse: () => '',
      );

      if (matchedDomain.isNotEmpty && matchedDomain != domain) {
        return 'Did you mean ${parts[0]}@$matchedDomain?';
      }
    }
    return null;

    // return null;
  }

  //!=====================================================================
  static String? validatePasswordCreation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check for minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letters
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    // Check for common passwords (you might want to expand this list)
    final commonPasswords = ['password', '12345678', 'qwerty'];
    if (commonPasswords.contains(value.toLowerCase())) {
      return 'This password is too common';
    }

    return null; // Return null if the password is valid
  }
  //!=====================================================================

  static String? validatePasswordSignIn(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
  //!=====================================================================

  static double calculatePasswordStrength(String password) {
    double strength = 0;

    // Length contributes up to 40% of strength
    strength += (password.length / 20).clamp(0, 0.4);

    // Character variety contributes up to 60%
    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasLower = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'[0-9]'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int varietyCount =
        [hasUpper, hasLower, hasDigit, hasSpecial].where((e) => e).length;
    strength += (varietyCount * 0.15);

    return strength.clamp(0, 1);
  }
  //!=====================================================================

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    // Remove all non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check for minimum length (typically 7-15 digits)
    if (digitsOnly.length < 7) {
      return 'Phone number is too short';
    }

    // Check for maximum length
    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }
    return null; // Return null if validation succeeds
  }
  //!=====================================================================

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name or nickname';
    }

    // Trim whitespace from both ends
    final trimmedValue = value.trim();

    // Check minimum length (at least 2 characters)
    if (trimmedValue.length < 2) {
      return 'Name is too short (min 2 characters)';
    }

    // Check maximum length (reasonable limit)
    if (trimmedValue.length > 30) {
      return 'Name is too long (max 30 characters)';
    }

    return null;

    // Check for invalid characters (allow letters, spaces, hyphens, apostrophes)
  }
}
