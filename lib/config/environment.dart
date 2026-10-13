final class Environment._() {
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://155.181.165.64/efood/api/v1');

  static String url(String path) => '$baseUrl$path';
}
