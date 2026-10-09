import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/domain/repositories/profile_repository.dart';
import 'package:efood/utils/result.dart';

class ProfileGetUserInfoUseCase({
  required final ProfileRepository _profileRepository,
}) {
  Future<Result<Profile>> getUserInfo() => _profileRepository.getUserInfo();
}
