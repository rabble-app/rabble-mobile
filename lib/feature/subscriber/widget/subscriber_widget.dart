import 'package:rabble/config/export.dart';

class SubscriberWidget extends StatelessWidget {

  final bool showRequst;
  const SubscriberWidget({Key? key, required this.showRequst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SubscriberItemWidget(showRequst: showRequst,);
        });
  }
}
