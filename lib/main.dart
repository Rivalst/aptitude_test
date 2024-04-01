import 'dart:async';

import 'package:aptitude_test/src/core/util/logger.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () => null,
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
