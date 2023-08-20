class AppConfig {

  static String baseUrl = '';

  static const String defaultLocale = 'en';

  static void configDev() {
    baseUrl = 'https://dog.ceo/api';
  }

  static void configTest() {
  }

  static void configProduction() {
  }

}