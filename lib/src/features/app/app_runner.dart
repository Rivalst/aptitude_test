import 'package:aptitude_test/src/core/util/bloc_observer.dart';
import 'package:aptitude_test/src/core/util/init.dart';
import 'package:aptitude_test/src/core/util/logger.dart';
import 'package:aptitude_test/src/features/app/widgets/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AppRunner {
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // Override logging
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = const AppBlocObserver();

    Future<void> initializeAndRun() async {
      try {
        final result = await const InitializationProcessor().initialize();
        runApp(
          App(
            result: result,
          ),
        );
      } catch (e, stackTrace) {
        logger.error('Initialization failed', error: e, stackTrace: stackTrace);
        // In this place we can ran app with error if init process was finished with error;
        // runApp(
        //   const InitializationFailedApp(

        //       ),
        // );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
