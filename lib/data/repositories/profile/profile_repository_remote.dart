import 'package:dio/dio.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/profile_api.dart';
import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/domain/repositories/profile_repository.dart';
import 'package:efood/utils/result.dart';

class ProfileRepositoryRemote({required final ProfileApi _profileApi}) implements ProfileRepository {
  @override
  Future<Result<Profile>> getUserInfo() async {
    try {
      final profile = await _profileApi.getUserInfo();
      return Result.ok(profile.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
