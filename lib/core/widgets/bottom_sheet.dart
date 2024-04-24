import 'dart:ui';

import 'package:rabble/config/export.dart';

class CustomBottomSheet {
  // survey bottom sheet
  static Future<String> showAccountBottomModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble,
      {bool? isRemove}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: Colors.transparent,
          isScrollControlled: isScrollAble ?? false,
          isDismissible: isRemove ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return SizedBox(
              height: isScrollAble!
                  ? isRemove != null && isRemove
                      ? MediaQuery.of(context).size.height * 0.65
                      : MediaQuery.of(context).size.height * 0.8
                  : MediaQuery.of(context).size.height * 0.4,
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: isScrollAble
                      ? const ClampingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: StatefulBuilder(
                      builder: (lowerContext, innerState) {
                        return child;
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ) ??
        Future.value('nothing');
  }

  static Future<String> showLoginViewModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble,
      {bool? isRemove}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: Colors.transparent,
          isScrollControlled: isScrollAble ?? false,
          isDismissible: isRemove ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: child,
              ),
            );
          },
        ) ??
        Future.value('nothing');
  }

  static Future<bool> showQuitBottomModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble, bool canLeave,
      {bool? isRemove, String? date}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: Colors.transparent,
          isScrollControlled: isScrollAble ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return SizedBox(
              height: date != null
                  ? !canLeave
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.47
                  : MediaQuery.of(context).size.height * 0.4,
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: StatefulBuilder(
                    builder: (lowerContext, innerState) {
                      return child;
                    },
                  ),
                ),
              ),
            );
          },
        ) ??
        Future.value(false);
  }

  static Future<bool> showTeamExistBottomModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble, bool canLeave,
      {bool? isRemove, String? date}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: Colors.transparent,
          isScrollControlled: isScrollAble ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: StatefulBuilder(
                    builder: (lowerContext, innerState) {
                      return child;
                    },
                  ),
                ),
              ),
            );
          },
        ) ??
        Future.value(false);
  }

  static Future<bool> showPortionedBottomModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble,
      {bool? isRemove, String? date}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: Colors.transparent,
          isScrollControlled: isScrollAble ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.53,
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: StatefulBuilder(
                    builder: (lowerContext, innerState) {
                      return child;
                    },
                  ),
                ),
              ),
            );
          },
        ) ??
        Future.value(false);
  }

  static Future<String> show500BottomModelSheet(
      BuildContext ctx, Widget child, bool? isScrollAble,
      {bool? isRemove}) async {
    return await showModalBottomSheet(
          context: ctx,
          backgroundColor: APPColors.bgColor,
          isScrollControlled: isScrollAble ?? false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: StatefulBuilder(
                    builder: (lowerContext, innerState) {
                      return child;
                    },
                  ),
                ),
              ),
            );
          },
        ) ??
        Future.value('nothing');
  }
}
