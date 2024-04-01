import 'dart:async';

import 'package:aptitude_test/src/core/util/logger.dart';
import 'package:aptitude_test/src/features/app/app_runner.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () => AppRunner().initializeAndRun(),
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
