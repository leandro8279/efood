final class Environment._() {
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://efood-8279.x10.mx/api/v1');

  static String url(String path) => '$baseUrl$path';
}
