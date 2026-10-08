import 'dart:async';

import 'package:efood/domain/repositories/auth_session_repository.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class AuthSessionNotifier({
  required final AuthSessionRepository authSessionRepository,
  required final Stream<void> sessionEnded,
}) extends GetxController {
  final AuthSessionRepository _authSessionRepository = authSessionRepository;
  final _log = AppLogger('AuthSessionNotifier');
  final RxnString _token = RxnString();
  final RxBool _restored = false.obs;
  late final StreamSubscription<void> _sessionEnded;

  bool get isRestored => _restored.value;
  bool get isSignedIn => _token.value?.isNotEmpty == true;

  this {
    _sessionEnded = sessionEnded.listen((_) => unawaited(_clearSession()));
  }

  Future<void> restoreSession() => _restore();

  Future<void> _restore() async {
    switch (await _authSessionRepository.readToken()) {
      case Ok<String?>(:final value):
        _token.value = value?.isNotEmpty == true ? value : null;
        _restored.value = true;
      case Error<String?>(:final error):
        _log.error(
          'Falha ao restaurar a sessão',
          error: error,
          stackTrace: error.stackTrace,
        );
    }
  }

  void signedIn(String token) {
    _token.value = token.isNotEmpty ? token : null;
    _restored.value = true;
  }

  void signedOut() {
    _token.value = null;
    _restored.value = true;
  }

  Future<void> _clearSession() async {
    signedOut();
    final result = await _authSessionRepository.delete();
    if (result case Error<void>(:final error)) {
      _log.error(
        'Falha ao remover o token da sessão',
        error: error,
        stackTrace: error.stackTrace,
      );
    }
  }

  @override
  void dispose() {
    _sessionEnded.cancel();
    super.dispose();
  }
}
