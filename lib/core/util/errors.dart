import 'package:rabble/config/export.dart';

// Helper class for error functionality
class Errors {
  static setupErrorHandling() {
    // Catch global uncaught Flutter errors
    FlutterError.onError = Errors.onFlutterError;
    //This is now taken over by instabug
    // For errors that happen outside Flutter
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
    }).sendPort);
  }

  static onFlutterError(FlutterErrorDetails errorDetails) {
    Zone.current.handleUncaughtError(
      errorDetails.exception,
      errorDetails.stack ??
          StackTrace.fromString(
              "IDK what happended here"), //fromString possibly will trhwo an error
    );
  }

  /// Also logs
  static reportAndShowOhNo(
    String log,
    dynamic error, {
    StackTrace? stackTrace,
    String? title,
    String? message,
    List<RabbleDialogButton>? actions,
  }) async {
    //
    globalBloc.showRabbleDialog(SomethingWentWrong(
      title: title,
      message: message,
      actions: actions,
    ));
  }

  static toMessage(dynamic error) {
    if (error is Error) {
      return error.toString();
    } else if (error is Exception) {
      return error.toString();
    } else {
      return error?.toString();
    }
  }
}
