import 'package:rabble/config/export.dart';
import 'package:rabble/core/loader/rabble_full_loader.dart';

class ProductWidget extends StatelessWidget {
  final bool isHorizontal;
  final ProducerDetail? producerDetail;
  final bool? showHeading;
  final bool? showViewAll;
  final String? headingProduct;
  final VoidCallback? callBackEmpty;

  const ProductWidget(
      {Key? key,
      required this.isHorizontal,
      required this.showHeading,
      this.producerDetail,
      this.showViewAll,
      this.callBackEmpty,
      this.headingProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.1;

    return CubitProvider<RabbleBaseState, ProductListCubit>(
        create: (BuildContext context) => ProductListCubit(producerDetail!.id!),
        builder: (BuildContext context, RabbleBaseState state,
            ProductListCubit bloc) {
          return RabbleFullScreenProgressIndicator(
            enabled: state.primaryBusy,
            child: BehaviorSubjectBuilder<List<ProductDetail>>(
                subject: bloc.productListSubject$,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductDetail>> snapshot) {
                  return Container(
                    color: APPColors.bgColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        !showHeading!
                            ? const SizedBox.shrink()
                            : Container(
                                margin: isHorizontal
                                    ? PagePadding.horizontalSymmetric(1.w)
                                    : PagePadding.horizontalSymmetric(3.w),
                                child: ViewAllWidget(
                                  title: headingProduct ?? kProduct,
                                  showViewAllBtn: showViewAll ?? true,
                                  callback: () {
                                    NavigatorHelper()
                                        .navigateTo("/product_tab");
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 1.h,
                        ),
                        snapshot.data!.isEmpty
                            ? const Empty(
                                msg: kNoProductFound,
                              )
                            : isHorizontal
                                ? SizedBox(
                                    height: context.allHeight * 0.3,
                                    child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SharedProductItemWidget(
                                            snapshot.data![index],
                                            isHorizontal: isHorizontal,
                                          );
                                        }),
                                  )
                                : GridView.builder(
                                    itemCount: snapshot.data!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio:
                                                (itemWidth / itemHeight)),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SharedProductItemWidget(
                                        snapshot.data![index],
                                        businessDetail: producerDetail,
                                        isHorizontal: false,
                                      );
                                    },
                                  )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
