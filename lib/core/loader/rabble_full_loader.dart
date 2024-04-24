import 'package:rabble/core/config/export.dart';


class RabbleFullScreenProgressIndicator extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const RabbleFullScreenProgressIndicator({super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return Center(
        child: CircularProgressIndicator(
          color: APPColors.appWhite,
          backgroundColor: APPColors.appPrimaryColor,
        ),
      );
    }
    return child;
  }
}
