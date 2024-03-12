import 'package:rabble/config/export.dart';
import 'package:rabble/core/widgets/CustomTabView.dart';

class ProductTabView extends StatelessWidget {
  final ProducerDetail businessDetail;

  const ProductTabView({Key? key, required this.businessDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.1;

    return CubitProvider<RabbleBaseState, ProductTabCubit>(
        create: (context) => ProductTabCubit(businessDetail.id!,{}),
        builder: (context, state, bloc) {
          return RabbleFullScreenProgressIndicator(
              enabled: state.primaryBusy,
              child: BehaviorSubjectBuilder<List<ProductData>>(
                  subject: bloc.productListSubject$,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProductData>> productSnapshot) {
                    return BehaviorSubjectBuilder<int>(
                        subject: bloc.currentIndexSubject,
                        builder: (context, snapshot) {
                          return RabbleFullScreenProgressIndicator(
                              enabled: state.primaryBusy,
                              child: BehaviorSubjectBuilder<List<ProductData>>(
                                  subject: bloc.productListSubject$,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<ProductData>> productSnapshot) {
                                    return BehaviorSubjectBuilder<int>(
                                        subject: bloc.currentIndexSubject,
                                        builder: (context, snapshot) {
                                          return CustomTabView(
                                              itemCount: productSnapshot
                                                  .data![snapshot.data!].products!.length,
                                              tabBuilder: (context, index) =>
                                                  RabbleText.subHeaderText(
                                                    text: productSnapshot
                                                        .data![snapshot.data!].name,
                                                  ),
                                              pageBuilder: (context, index) {
                                                return Padding(
                                                  padding: PagePadding.custom(
                                                      0.w, 4.w, 5.w, 0.w),
                                                  child: Container(
                                                    color: APPColors.bgColor,
                                                    child: GridView.builder(
                                                      itemCount: productSnapshot
                                                          .data![snapshot.data!]
                                                          .products!
                                                          .length,
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio:
                                                          (itemWidth /
                                                              itemHeight)),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                          int index) {
                                                        return SharedProductItemWidget(
                                                          productSnapshot
                                                              .data![snapshot.data!]
                                                              .products![index],
                                                          businessDetail:
                                                          businessDetail,
                                                          isHorizontal: false,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              });
                                        });
                                  }));
                        });
                  })

          );
        });
  }


}
