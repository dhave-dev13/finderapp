import 'dart:io';

import 'package:logger/logger.dart';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

// Interface implementation for ConsoleOutput
class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (kReleaseMode || !Platform.isIOS) {
      event.lines.forEach(debugPrint);
    } else {
      event.lines.forEach(developer.log);
    }
  }
}

final appLogger = AppLogger('AppLogger', noBoxingByDefault: true, includeStackTrace: false);

class AppLogger extends Logger {
  AppLogger(this.className, {this.includeStackTrace = true, this.noBoxingByDefault = false, this.printIcons = true})
    : super(
        filter: _AppLogFilter(),
        printer: _AppLogPrinter(className: className, includeStackTrace: includeStackTrace, removeBox: noBoxingByDefault, printIcons: printIcons),
        output: ConsoleOutput(),
      );
  final String className;
  final bool includeStackTrace;
  final bool noBoxingByDefault;
  final bool printIcons;
}

class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (!kReleaseMode) {
      if (event.level == Level.error || event.level == Level.info) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

class _AppLogPrinter extends PrettyPrinter {
  _AppLogPrinter({required this.className, required this.includeStackTrace, required this.removeBox, required this.printIcons})
    : super(
        printEmojis: printIcons,
        methodCount: includeStackTrace ? 1 : 0,
        stackTraceBeginIndex: 2,
        noBoxingByDefault: removeBox,
      );
  final String className;
  final bool includeStackTrace;
  final bool removeBox;
  final bool printIcons;

  @override
  List<String> log(LogEvent event) {
    return super.log(LogEvent(event.level, '[$className] ${event.message}', error: event.error, stackTrace: event.stackTrace));
  }
}
