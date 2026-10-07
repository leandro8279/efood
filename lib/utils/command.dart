import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> {
  final RxBool _running = false.obs;
  final _result = Rxn<Result<T>>();

  bool get error => _result.value is Error;
  bool get complete => _result.value is Ok;

  RxBool get running => _running;
  Rxn<Result<T>> get result => _result;

  void clearResult() {
    _result.value = null;
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running.value) return;

    _running.value = true;
    _result.value = null;

    try {
      _result.value = await action();
    } finally {
      _running.value = false;
    }
  }
}

class Command0<T>(final CommandAction0<T> _action) extends Command<T> {
  Future<void> execute() => _execute(_action);
}

class Command1<T, A>(final CommandAction1<T, A> action) extends Command<T> {
  Future<void> execute(A argument) => _execute(() => action(argument));
}
