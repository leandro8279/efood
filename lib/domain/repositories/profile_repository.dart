import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/utils/result.dart';

abstract interface class ProfileRepository {
  Future<Result<Profile>> getUserInfo();
  Future<Result<String>> updateProfile({
    required Profile profile,
    required String password,
    File? file,
    XFile? data,
  });
}
