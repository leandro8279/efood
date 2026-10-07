import 'dart:async';

import 'package:get/get.dart';

class AuthSessionNotifier({
  //  required final AuthLogoutUseCase _authLogoutUseCase,
  // required final AuthRestoreSessionUseCase _authRestoreSessionUseCase,
  required final Stream<void> sessionEnded,
}) extends GetxController {
  final _restored = false;
  late final StreamSubscription<void> _sessionEnded;

  bool get isRestored => _restored;
  // AuthSessionUser? get user => _user;
  bool get isSignedIn => false;

  this {
    print("AuthSessionNotifier");
    unawaited(_restore());

    _sessionEnded = sessionEnded.listen((_) {
      print("SESSIONENADED");
    });
  }

  Future<void> _restore() async {
    print("RESTORE");
  }

  @override
  void dispose() {
    _sessionEnded.cancel();
    super.dispose();
  }
}
