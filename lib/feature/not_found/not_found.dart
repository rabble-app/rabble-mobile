import 'package:rabble/core/config/export.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RabbleButton.primaryFilled(
          child: const Text('NO FOUND GO BACK'),
          onPressed: () {
            NavigatorHelper().pop();
          },
        ),
      ),
    );
  }
}
