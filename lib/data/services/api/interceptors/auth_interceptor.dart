import 'dart:async';

import 'package:dio/dio.dart';
import 'package:efood/domain/repositories/auth_session_repository.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';

class AuthInterceptor({required final AuthSessionRepository _authSessionRepository}) extends Interceptor {
  static const publicRoute = <String, Object>{_publicRouteKey: true};

  static const _publicRouteKey = 'publicRoute';
  static const _sessionEndedStatus = {401};

  final _unauthorized = StreamController.broadcast();
  final _log = AppLogger('AuthInterceptor');

  Stream<void> get onUnauthorized => _unauthorized.stream;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra[_publicRouteKey] == true) {
      return handler.next(options);
    }

    final result = await _authSessionRepository.readToken();
    switch (result) {
      case Ok<String?>(:final value):
        if (value != null && value.isNotEmpty && !options.headers.containsKey('Authorization')) {
          options.headers['Authorization'] = 'Bearer $value';
        }
        return handler.next(options);
      default:
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_endsSession(err)) {
      _unauthorized.add(null);
    }
    handler.next(err);
  }

  bool _endsSession(DioException err) =>
      _sessionEndedStatus.contains(err.response?.statusCode) && err.requestOptions.headers.containsKey('Authorization');

  void dispose() {}
}
