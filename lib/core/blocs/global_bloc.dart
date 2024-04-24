//This bloc will contain the db paths etc and other properties
//Init Db will be there

import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/GlobalVariable.dart';
import 'package:rabble/feature/basket/widget/clear_basket_sheet.dart';

enum SystemStyle {
  DEFAULT,
  POST,
}

/// Global logic
class GlobalBloc {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'global:scaffold');
  final GlobalKey<ScaffoldMessengerState> mainScreenScaffoldKey =
      GlobalKey<ScaffoldMessengerState>(
          debugLabel: 'global:mainscreenscaffold');

  BehaviorSubject<int> cartItemQty = BehaviorSubject<int>.seeded(0);

  var stopwatch = Stopwatch(); //Creates a new StopWatch, not Stopwatch

  final GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

  final resetGoogleMap = BehaviorSubject<bool>.seeded(false);
  final recallApi = BehaviorSubject<bool>.seeded(false);
  final postalCodeChanged = BehaviorSubject<bool>.seeded(false);
  final isNotifcation = BehaviorSubject<bool>.seeded(false);
  final isBackNotifcation = BehaviorSubject<bool>.seeded(false);

  Function(bool) get updateResetGoogleMapFlag => resetGoogleMap.add;

  final _connectionErrorSnackbarSubject = BehaviorSubject<bool>();
  final _httpErrorSnackbarSubject = BehaviorSubject<SnackBar>();
  final isAppFunctional$ = BehaviorSubject<bool>.seeded(false);

  Function(bool) get setIsAppFunctional => isAppFunctional$.add;

  bool get isAppFunctional => isAppFunctional$.value;
  bool initialized = false;



  GlobalBloc() {
    _connectionErrorSnackbarSubject
        .throttleTime(const Duration(milliseconds: 6000))
        .listen((_) => _showConnectionErrorSnackBar());
    _httpErrorSnackbarSubject
        .throttleTime(const Duration(milliseconds: 6000))
        .listen((snackbar) => showSuccessSnackBar(snackbar: snackbar));
  }

  /// Idempotent!
  /// Initialize all app things that require a logged in user
  /// Currently this is run from the NavigatorHelper
  /// but ideally it'd be run somewhere else, somewhere more central
  initializeGlobalState() async {
    if (initialized) return;
    // Optimistic about initialisation
    initialized = true;
    setIsAppFunctional(true);
  }

  showSuccessSnackBar({
    String? message,
    Widget? content,
    SnackBarAction? action,
    Duration? duration,
    bool main = false,
    bool both = false,
    SnackBar? snackbar,
  }) {
    //if snackBar is provided it will override everything
    assert(!(message != null && content != null), 'Mutually exclusive');
    // Duration Material spec: min 4s, max 10s
    // This works OK for notifications
    if (duration == null && action == null) {
      duration = const Duration(milliseconds: 2000);
    }
    // Actionable snackbars should stick around for a bit
    if (duration == null && action != null) {
      duration = const Duration(milliseconds: 4000);
    }

    if (message != null) {
      content = Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: APPColors.appGreen4,
            size: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width:200,
            child: RabbleText.subHeaderText(
              text: message,
              textAlign: TextAlign.start,
              fontFamily: cPoppins,
              fontWeight: FontWeight.w500,
              color: APPColors.appGreen4,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              hideSnackBar;
            },
            child: const Icon(
              Icons.close,
              color: APPColors.bg_grey27,
              size: 24,
            ),
          ),
        ],
      );
    }
    if (snackbar != null) {
      snackbar = SnackBar(
        backgroundColor: APPColors.appGreen5,
        content: GestureDetector(onTap: hideSnackBar, child: snackbar.content),
        duration: snackbar.duration,
        action: snackbar.action,
      );
    }
    final snack = snackbar ??
        SnackBar(
          backgroundColor: APPColors.appGreen5,
          content: GestureDetector(onTap: hideSnackBar, child: content),
          duration: duration!,
          action: action,
        );

    //Hide previous first
    hideSnackBar();
    hideSnackBar(main: true);

    if (main) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    } else {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    }
  }

  showErrorSnackBar({
    String? message,
    Widget? content,
    SnackBarAction? action,
    Duration? duration,
    bool main = false,
    bool both = false,
    SnackBar? snackbar,
  }) {
    //if snackBar is provided it will override everything
    assert(!(message != null && content != null), 'Mutually exclusive');
    // Duration Material spec: min 4s, max 10s
    // This works OK for notifications
    if (duration == null && action == null) {
      duration = const Duration(milliseconds: 2000);
    }
    // Actionable snackbars should stick around for a bit
    if (duration == null && action != null) {
      duration = const Duration(milliseconds: 4000);
    }

    if (message != null) {
      content = Row(
        children: [
          const Icon(
            Icons.error,
            color: Color(0xffFF1A35),
            size: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          RabbleText.subHeaderText(
            text: message,
            fontFamily: cPoppins,
            fontWeight: FontWeight.w500,
            color: Color(0xffFF1A35),
            fontSize: 18,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              hideSnackBar;
            },
            child: const Icon(
              Icons.close,
              color: APPColors.bg_grey27,
              size: 24,
            ),
          ),
        ],
      );
    }
    if (snackbar != null) {
      snackbar = SnackBar(
        backgroundColor: Color(0xffFFE5E9),
        content: GestureDetector(onTap: hideSnackBar, child: snackbar.content),
        duration: snackbar.duration,
        action: snackbar.action,
      );
    }
    final snack = snackbar ??
        SnackBar(
          backgroundColor: Color(0xffFFE5E9),
          content: GestureDetector(onTap: hideSnackBar, child: content),
          duration: duration!,
          action: action,
        );

    //Hide previous first
    hideSnackBar();
    hideSnackBar(main: true);

    if (main) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    } else {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    }
  }

  showWarningSnackBar({
    String? message,
    Widget? content,
    SnackBarAction? action,
    Duration? duration,
    bool main = false,
    bool both = false,
    SnackBar? snackbar,
  }) {
    //if snackBar is provided it will override everything
    assert(!(message != null && content != null), 'Mutually exclusive');
    // Duration Material spec: min 4s, max 10s
    // This works OK for notifications
    if (duration == null && action == null) {
      duration = const Duration(milliseconds: 2000);
    }
    // Actionable snackbars should stick around for a bit
    if (duration == null && action != null) {
      duration = const Duration(milliseconds: 4000);
    }

    if (message != null) {
      content = Row(
        children: [
          const Icon(
            Icons.warning,
            color: Color(0xffB54708),
            size: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width:
            250,

            child: RabbleText.subHeaderText(
              text: message,
              textAlign: TextAlign.start,
              fontFamily: cPoppins,
              fontWeight: FontWeight.w500,
              color: Color(0xffB54708),
              fontSize: message.length >20? 11.sp : 18,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              hideSnackBar;
            },
            child: const Icon(
              Icons.close,
              color: APPColors.bg_grey27,
              size: 24,
            ),
          ),
        ],
      );
    }
    if (snackbar != null) {
      snackbar = SnackBar(
        backgroundColor: Color(0xffFFFAE5),
        content: GestureDetector(onTap: hideSnackBar, child: snackbar.content),
        duration: snackbar.duration,
        action: snackbar.action,
      );
    }
    final snack = snackbar ??
        SnackBar(
          backgroundColor: Color(0xffFFFAE5),
          content: GestureDetector(onTap: hideSnackBar, child: content),
          duration: duration!,
          action: action,
        );


    //Hide previous first
    hideSnackBar();
    hideSnackBar(main: true);

    if (main) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    } else {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    }
  }

  _showConnectionErrorSnackBar() {
    // showWarningSnackBar(
    //   message: 'Please check your connection',
    //   duration: const Duration(milliseconds: 4000),
    // );
  }

  showConnectionErrorSnackBar() {
    _connectionErrorSnackbarSubject.add(true);
  }

  showHttpErrorSnackBar(SnackBar snackbar) {
    _httpErrorSnackbarSubject.add(snackbar);
  }

  showDisabledForAlphaSnackBar() => showSuccessSnackBar(
        // message: Platform.isIOS
        message: false ? 'Feature coming soon!' : 'Disabled for alpha — sorry!',
        action: SnackBarAction(
          label: "OH OK",
          onPressed: () {},
        ),
      );

  showValidationFailedDialog() {
    showRabbleDialog(
      ValidationErrorDialog.fromErrors(
        title: 'Validation Failed',
        defaultMessage: "Some of the validation failed please have a look.",
      ),
    );
  }

  // Doesn't want to go away
  showStubbornSnackBar({
    required String message,
    Widget? content,
    required SnackBarAction action,
  }) =>
      showSuccessSnackBar(
          message: message,
          content: content,
          action: action,
          duration: const Duration(seconds: 300));

  hideSnackBar({bool main = true}) {
    //if scaffold keys are not linked to the scaffold just return
    if (mainScreenScaffoldKey.currentContext == null ||
        scaffoldKey.currentContext == null) return;
    if (main) mainScreenScaffoldKey.currentState?.hideCurrentSnackBar();
    scaffoldKey.currentState?.hideCurrentSnackBar();
  }

  /// If [localized = false] it will use the the build context
  /// in which the password with [scaffoldKey] key builds to show the dialog
  Future<T?> showRabbleDialog<T>(
    Widget dialog, {
    bool dismissible = true,
    bool localized = true,
  }) {
    BuildContext context = localized
        ? NavigatorHelper.navigatorKey.currentContext!
        : scaffoldKey.currentContext!;
    return showDialog<T>(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: dismissible,
    );
  }

  showConnectionErrorDialog([DioError? error]) {
    // Could perhaps use the DioError to distinguish
    return showRabbleDialog(noConnectionDialog);
  }

  reset() {
    setIsAppFunctional(false);
  }

  Future<bool> productDeleteDialog(BuildContext context) async {
    return CustomBottomSheet.showQuitBottomModelSheet(
        context, ClearBasketSheet(), true,true,
        isRemove: true);
  }
}

final globalBloc = GlobalBloc();
