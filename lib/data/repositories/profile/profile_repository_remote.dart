import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/profile_api.dart';
import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/domain/repositories/profile_repository.dart';
import 'package:efood/utils/app_exception.dart';
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

  @override
  Future<Result<String>> updateProfile({
    required Profile profile,
    required String password,
    File? file,
    XFile? data,
  }) async {
    try {
      final fields = <String, dynamic>{
        '_method': 'put',
        'f_name': profile.fName,
        'l_name': profile.lName,
        'phone': profile.phone,
      };

      if (password.isNotEmpty) {
        fields['password'] = password;
      }

      if (file != null) {
        fields['image'] = await MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
        );
      } else if (data != null) {
        fields['image'] = MultipartFile.fromBytes(
          await data.readAsBytes(),
          filename: data.name,
          contentType: DioMediaType.parse('image/jpeg'),
        );
      }

      final response = await _profileApi.updateProfile(FormData.fromMap(fields));
      return Result.ok(response.message);
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    } on Exception catch (e, st) {
      return Result.error(UnknownException(cause: e, stackTrace: st));
    }
  }
}
