import 'package:logger/logger.dart';

class Log {

  static final Logger _instance = Logger(
    //level: Level.info,
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(
        //methodCount: 1, // number of method calls to be displayed
        //errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp
    ),
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.v(message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.d(message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.i(message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.w(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.e(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance.wtf(message, error, stackTrace);
  }

}