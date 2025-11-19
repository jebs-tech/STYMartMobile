class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://pbp.cs.ui.ac.id/jenisa.bunga/stymart',
  );

  static String get loginUrl => '$baseUrl/auth/login/';
  static String get registerUrl => '$baseUrl/auth/register/';
  static String get logoutUrl => '$baseUrl/auth/logout/';
  static String get createProductUrl => '$baseUrl/create-flutter/';
  static String get productsUrl => '$baseUrl/json/';
  static String get myProductsUrl => '$baseUrl/json/user/';
}

