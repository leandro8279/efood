import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/result.dart';

abstract interface class ConfigRepository {
  Config get config;

  Future<Result<Config>> getConfig();
}
