final class Environment._() {
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://efood-admin.6amtech.com/api/v1');

  static String url(String path) => '$baseUrl$path';
}
