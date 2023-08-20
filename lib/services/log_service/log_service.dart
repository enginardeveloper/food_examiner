abstract class LogService {
  void e(String message, dynamic e, StackTrace? stackTrace);
  void i(String message);
  void w(String message, [dynamic e, StackTrace? stack]);
}