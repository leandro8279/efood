import 'dart:async';

import 'package:efood/domain/repositories/auth_session_repository.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class AuthSessionNotifier extends GetxController {
  AuthSessionNotifier({
    required ProfileGetUserInfoUseCase profileGetUserInfoUseCase,
    required Stream<void> sessionEnded,
  }) : _profileGetUserInfoUseCase = profileGetUserInfoUseCase {
    _log.info('Inicializando gerenciador de sessão.');

    unawaited(_getUserInfo());

    _sessionEnded = sessionEnded.listen(
      (_) {
        _log.info('Evento de encerramento de sessão recebido.');
        unawaited(logout());
      },
      onError: (Object error, StackTrace stackTrace) {
        _log.error(
          'Erro no fluxo de encerramento da sessão.',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  final ProfileGetUserInfoUseCase _profileGetUserInfoUseCase;
  final AppLogger _log = AppLogger('AuthSessionNotifier');

  final RxBool _restored = false.obs;
  final RxBool _isSignedIn = false.obs;
  final Rx<Profile?> _profile = Rx<Profile?>(null);

  late final StreamSubscription<void> _sessionEnded;

  bool get isRestored => _restored.value;
  RxBool get isSignedIn => _isSignedIn;
  Rx<Profile?> get profile => _profile;

  Future<void> _getUserInfo() async {
    _log.info('Iniciando restauração da sessão.');

      final result = await _profileGetUserInfoUseCase.getUserInfo();

      if (_restored.value) {
        _log.info('Sessão já restaurada. Ignorando resultado.');
        return;
      }

      switch (result) {
        case Ok(:final value):
          _profile.value = value;
          _isSignedIn.value = value != null;

          if (value != null) {
            _log.info('Sessão restaurada com sucesso. Usuário autenticado.');
          } else {
            _log.info('Nenhum usuário autenticado encontrado.');
          }

        case Error(:final error):
          _profile.value = null;
          _isSignedIn.value = false;

          _log.error(
            'Falha ao recuperar os dados do usuário.',
            error: error,
          );
      }

      _restored.value = true;
      _log.info('Processo de restauração da sessão finalizado.');
  }

  Future<void> signedIn() async {
    _log.info('Solicitada atualização da sessão após o login.');

    _restored.value = false;
    await _getUserInfo();
  }

  Future<void> logout() async {
    _log.info('Iniciando encerramento da sessão.');

    _profile.value = null;
    _isSignedIn.value = false;

    _log.info('Sessão encerrada. Dados do usuário removidos.');
  }

  @override
  void onClose() {
    _log.info('Encerrando AuthSessionNotifier.');

    unawaited(_sessionEnded.cancel());

    super.onClose();
  }
}