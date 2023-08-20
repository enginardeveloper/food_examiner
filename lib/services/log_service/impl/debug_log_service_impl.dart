import 'package:logger/logger.dart';
// Interact with developer tools such as the debugger and inspector.
import 'dart:developer' as developer;
import '../log_service.dart';

class DebugLogServiceImpl implements LogService {


  late final Logger _logger;

  DebugLogServiceImpl({Logger? logger}) {
    _logger = logger ?? Logger(
        printer: PrefixPrinter(
          PrettyPrinter( methodCount: 0,
            errorMethodCount: 500,
            lineLength: 100,),
        ),
      output: _MyConsoleOutput(),
    );

  }

  @override
  void e(String message, e, StackTrace? stackTrace) {
    _logger.e(message, e, stackTrace);
  }

  @override
  void i(String message) {
    _logger.i(message);
  }

  @override
  void w(String message, [e, StackTrace? stack]) {
    _logger.w(message, e, stack);
  }

}

class _MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(developer.log);
  }
}