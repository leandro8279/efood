final class Environment._() {
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://localhost:3001');

  static String url(String path) => '$baseUrl$path';
}
