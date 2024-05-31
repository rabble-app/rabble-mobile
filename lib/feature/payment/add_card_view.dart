import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:rabble/core/config/export.dart';

class AddNewCardView extends StatelessWidget {
  AddNewCardView({super.key});

  final StreamController<bool> _over18Stream =
      StreamController<bool>.broadcast();

  dynamic toggleSwitch(bool val) {
    if (val) {
      _over18Stream.sink.add(false);
    } else {
      _over18Stream.sink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, PaymentCubit>(
        create: (context) => PaymentCubit(fetchMyCard: false),
        builder: (context, state, bloc) {
          return ToucheDetector(
            child: Scaffold(
              backgroundColor: APPColors.bgColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 13.h,
                    color: APPColors.appBlack,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        InkWell(
                          onTap: () {
                            if(!state.secondaryBusy) {
                              NavigatorHelper().pop();
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 7.w,
                            height: 5.h,
                            child: CircleAvatar(
                              backgroundColor: APPColors.appPrimaryColor,
                              child: const Icon(
                                Icons.close,
                                color: APPColors.appBlack4,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        RabbleText.subHeaderText(
                          text: kAddANewCard,
                          color: APPColors.appPrimaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: PagePadding.all(4.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            RabbleText.subHeaderText(
                              text: kCardDetail,
                              color: APPColors.appBlack4,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            RabbleText.subHeaderText(
                              text: kCardNumber,
                              color: APPColors.appTextPrimary,
                              fontSize: 9.sp,
                              fontFamily: cPoppins,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            RabbleTextField.border(
                              keyBoardType: TextInputType.number,
                              color: APPColors.appBlack,
                              textAlign: TextAlign.start,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              borderColor: APPColors.bg_grey25,
                              hint: k44444,
                              onChange: bloc.cardNumberC,
                              formater: [
                                FilteringTextInputFormatter.digitsOnly,
                                CardNumberFormatter(),
                              ],
                              filledColor: Colors.transparent,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.6,
                              hintFontSize: 10.sp,
                              maxLines: 1,
                              hintColor: APPColors.bg_grey27,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: kCVV,
                                        color: APPColors.appTextPrimary,
                                        fontSize: 9.sp,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      SizedBox(
                                        width: 43.w,
                                        child: RabbleTextField.border(
                                          keyBoardType: TextInputType.text,
                                          color: APPColors.appBlack,
                                          textAlign: TextAlign.start,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          obscureText: true,
                                          borderColor: APPColors.bg_grey25,
                                          onChange: bloc.cvvC,
                                          formater: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          hint: kCVVStar,
                                          filledColor: Colors.transparent,
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0.6,
                                          hintFontSize: 10.sp,
                                          maxLines: 1,
                                          hintColor: APPColors.bg_grey27,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: kExpiry,
                                        color: APPColors.appTextPrimary,
                                        fontSize: 9.sp,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      SizedBox(
                                        width: 43.w,
                                        child: RabbleTextField.border(
                                          keyBoardType: TextInputType.number,
                                          color: APPColors.appBlack,
                                          textAlign: TextAlign.start,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          onChange: bloc.expiryC,
                                          borderColor: APPColors.bg_grey25,
                                          hint: kExpiryDate,
                                          formater: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            ExpiryDateFormatter()
                                          ],
                                          filledColor: Colors.transparent,
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0.6,
                                          hintFontSize: 10.sp,
                                          maxLines: 1,
                                          hintColor: APPColors.bg_grey27,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BehaviorSubjectBuilder<bool>(
                                    subject: bloc.markPrimaryCardSubject$,
                                    builder: (context, primaryCardSnapshot) {
                                      return Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor:
                                              APPColors.appBorder,
                                        ),
                                        child: Transform.scale(
                                          scale: 1.3,
                                          child: Checkbox(
                                            value: primaryCardSnapshot.data,
                                            onChanged: (bool? newValue) {
                                              bloc.markPrimaryCardSubject$.sink
                                                  .add(newValue!);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: BorderSide(
                                                color: primaryCardSnapshot.data!
                                                    ? APPColors.appBlack
                                                    : APPColors.bg_grey25,
                                              ),
                                            ),
                                            checkColor:
                                                APPColors.appPrimaryColor,
                                            activeColor: APPColors.appBlack,
                                            fillColor: MaterialStateProperty
                                                .all<Color>(
                                                    primaryCardSnapshot.data!
                                                        ? APPColors.appBlack
                                                        : APPColors.bg_grey25),
                                          ),
                                        ),
                                      );
                                    }),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: 'Set as primary payment method',
                                        height: 1.3,
                                        textAlign: TextAlign.start,
                                        color: APPColors.appBlack4,
                                        fontSize: 11.sp,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      RabbleText.subHeaderText(
                                        text:
                                            'We will use this payment method for all your orders',
                                        fontFamily: cPoppins,
                                        fontSize: 8.5.sp,
                                        color: APPColors.bg_grey27,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.8,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: StreamBuilder<bool>(
                                  stream: bloc.validateCardFields,
                                  initialData: false,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    return Container(
                                      margin:
                                          PagePadding.custom(0, 0, 4.w, 5.w),
                                      child: RabbleButton.tertiaryFilled(
                                        buttonSize: ButtonSize.large,
                                        bgColor: snapshot.data!
                                            ? APPColors.appPrimaryColor
                                            : APPColors.bg_grey25,
                                        onPressed: state.secondaryBusy
                                            ? null
                                            : () async {
                                                if (snapshot.data!) {
                                                  var date = bloc
                                                      .expirySubject$.value
                                                      .split('/');
                                                  var stripePaymentMethodId =
                                                      await createPaymentMethodId(
                                                          bloc.cardNumberSubject$
                                                              .value,
                                                          date[0],
                                                          date[1],
                                                          bloc.cvvSubject$
                                                              .value);
                                                  bloc.addMyCard(
                                                      stripePaymentMethodId);
                                                }
                                              },
                                        child: state.secondaryBusy
                                            ? Container(
                                                padding: PagePadding
                                                    .horizontalSymmetric(5.w),
                                                child: const Center(
                                                  child:
                                                      RabbleSecondaryScreenProgressIndicator(
                                                    enabled: true,
                                                  ),
                                                ),
                                              )
                                            : RabbleText.subHeaderText(
                                                text: kAddNewCard,
                                                fontSize: 14.sp,
                                                fontFamily: 'Gosha',
                                                color: snapshot.data!
                                                    ? APPColors.appBlack
                                                    : APPColors.bg_grey27,
                                                fontWeight: FontWeight.bold,
                                              ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> createPaymentMethodId(String cardNumber,
      String cardExpiryMonth, String cardExpiryYear, String cardCvc) async {
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    stripe.CardDetails card = stripe.CardDetails(
        cvc: cardCvc,
        number: cardNumber,
        expirationMonth: int.parse(cardExpiryMonth),
        expirationYear: int.parse(cardExpiryYear));

    await stripe.Stripe.instance.dangerouslyUpdateCardDetails(card);

    final paymentMethod = await stripe.Stripe.instance.createPaymentMethod(
        params: stripe.PaymentMethodParams.card(
      paymentMethodData: stripe.PaymentMethodData(
        billingDetails: stripe.BillingDetails(
          phone: userModel.phone ?? '',
          email: userModel.email ?? '',
          address: stripe.Address(
            city: userModel.email ?? '',
            country: 'GB',
            line1: '',
            line2: '',
            state: '',
            postalCode: userModel.postalCode ?? '',
          ),
        ),
      ),
    ));
    return paymentMethod.id;
  }
}
