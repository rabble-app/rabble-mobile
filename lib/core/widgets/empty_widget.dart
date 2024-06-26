import 'package:rabble/core/config/export.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key, this.msg}) : super(key: key);
  final String? msg;

  @override
  Widget build(BuildContext context) {
    if (msg != null) {
      return SizedBox(
        height: 20.h,
        child: Center(
          child: RabbleText.subHeaderText(
            text: msg!,
            fontFamily: cGosha,
            fontWeight: FontWeight.bold,
            color: APPColors.appPrimaryColor,
            fontSize: 16.sp,
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 0.0,
        height: 0.0,
      );
    }
  }
}

class EmptySliver extends StatelessWidget {
  const EmptySliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Empty(),
    );
  }
}
