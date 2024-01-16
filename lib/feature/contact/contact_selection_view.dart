import 'package:rabble/config/export.dart';

class ContactSelectionView extends StatefulWidget {
  const ContactSelectionView({Key? key}) : super(key: key);

  @override
  State<ContactSelectionView> createState() => _ContactSelectionViewState();
}

class _ContactSelectionViewState extends State<ContactSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.appBlack,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: RabbleAppbar(
            title: kContactSelection,

            leadingWidth: 21.w,
          )),
      body: const SafeArea(
        child: ContactWidget(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
