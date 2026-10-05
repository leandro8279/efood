import 'package:efood/domain/models/config/config.dart';
import 'package:efood/utils/result.dart';

abstract class SplashRepository {
  Future<Result<Config>> getConfig();
  Future<Result<String>> getPolicyPage();
  Future<Result<void>> initSharedData();
  Future<Result<void>> removeSharedData();
}
