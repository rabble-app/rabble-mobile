import 'package:rabble/core/config/export.dart';

enum LoaderSize { SMALL, MEDIUM, LARGE }

class RabbleSecondaryScreenProgressIndicator extends StatelessWidget {
  final bool enabled;
  final Color? loaderColor;

  const RabbleSecondaryScreenProgressIndicator({
    super.key,
    required this.enabled,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          color: APPColors.appWhite,
          backgroundColor: loaderColor ?? APPColors.appPrimaryColor,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
