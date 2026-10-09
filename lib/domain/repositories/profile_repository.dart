import 'package:efood/domain/models/profile/profile.dart';
import 'package:efood/utils/result.dart';

abstract interface class ProfileRepository {
  Future<Result<Profile>> getUserInfo();
}
