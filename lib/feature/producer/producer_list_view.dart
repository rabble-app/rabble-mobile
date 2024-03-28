import 'package:rabble/core/config/export.dart';

class ProducerListView extends StatelessWidget {
  const ProducerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    return CubitProvider<RabbleBaseState, ProducerCubit>(
        create: (context) => ProducerCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bg_app_primary,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: RabbleAppbar(
                  leadingWidth: 25.w,
                  title: sMeetTP,
                )),
            body: SingleChildScrollView(
              controller: bloc.scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: PagePadding.custom(0, 2.w, 0.w, 0),
                    child: ProducerListWidget(
                      isHorizontal: true,
                      showViewAll: false,
                      showHeading: false,
                      showLoader: true,
                      cubit: bloc,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
