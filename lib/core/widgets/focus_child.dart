import 'package:rabble/core/config/export.dart';
class FocusChild extends StatelessWidget {
  const FocusChild({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: child,
    );
  }
}
