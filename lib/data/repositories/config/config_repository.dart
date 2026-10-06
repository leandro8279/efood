import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/result.dart';

abstract class ConfigRepository {
  Config get config;

  Future<Result<Config>> getConfig();
}
