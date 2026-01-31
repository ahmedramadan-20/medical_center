import 'dart:developer' as developer;
import 'package:logging/logging.dart';

/// Centralized logging service for the Medical Center app.
///
/// Uses the `logging` package with integration to `dart:developer`
/// for better DevTools support.
///
/// Usage:
/// ```dart
/// final logger = LoggerService('FeatureName');
/// logger.info('User logged in');
/// logger.error('Failed to load data', error, stackTrace);
/// ```
class LoggerService {
  /// Creates a logger for a specific component or feature.
  LoggerService(String name) : _logger = Logger(name);

  final Logger _logger;

  /// Initialize the logging system.
  ///
  /// Call this once during app initialization in main().
  static void initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // Forward to dart:developer for DevTools integration
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });
  }

  /// Log an informational message.
  void info(String message) => _logger.info(message);

  /// Log a warning message.
  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  /// Log an error message.
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  /// Log a debug message.
  void debug(String message) => _logger.fine(message);

  /// Log a verbose/trace message.
  void trace(String message) => _logger.finer(message);
}
