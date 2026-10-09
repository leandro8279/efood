import 'dart:async';

import 'package:dio/dio.dart';
import 'package:efood/domain/repositories/auth_session_repository.dart';
import 'package:efood/utils/result.dart';

class AuthInterceptor({required final AuthSessionRepository _authSessionRepository}) extends Interceptor {
  static const publicRoute = <String, Object>{_publicRouteKey: true};

  static const _publicRouteKey = 'publicRoute';
  static const _sessionEndedStatus = {401, 403};

  final _unauthorized = StreamController.broadcast();

  Stream<void> get onUnauthorized => _unauthorized.stream;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra[_publicRouteKey] == true) {
      handler.next(options);
      return;
    }

    switch (await _authSessionRepository.readToken()) {
      case Ok<String?>(value: final token):
        if (token != null && token.isNotEmpty && !options.headers.containsKey('Authorization')) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
        return;
      case Error<String?>(:final error):
        handler.reject(DioException(requestOptions: options, error: error));
        return;
    }
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
