import 'package:efood/data/services/local/secure_storage_service.dart';
import 'package:efood/data/services/local/storage_keys.dart';
import 'package:efood/domain/repositories/auth_session_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class AuthSessionRepositoryLocal({required final SecureStorageService _storage}) implements AuthSessionRepository {
  @override
  Future<Result<String?>> readToken() async {
    try {
      return Result.ok(await _storage.fetch(StorageKeys.authToken));
    } on StorageException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> delete() async {
    try {
      await _storage.delete(StorageKeys.authToken);
      return Result.done;
    } on StorageException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> save(String token) async {
    try {
      await _storage.save(key: StorageKeys.authToken, value: token);

      return Result.done;
    } on StorageException catch (e) {
      await delete();
      return Result.error(e);
    }
  }
}
