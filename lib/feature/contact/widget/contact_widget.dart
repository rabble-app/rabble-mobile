import 'package:rabble/core/config/export.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TeamData teamData = ModalRoute.of(context)!.settings.arguments as TeamData;

    return CubitProvider<RabbleBaseState, ContactCubit>(
        create: (context) => ContactCubit(),
        builder: (context, state, bloc) {
          return RabbleFullScreenProgressIndicator(
            enabled: state.primaryBusy,
            child: Padding(
              padding: PagePadding.custom(0,0, 0, 1.w),
              child: Column(
                children: [
                  Container(
                    height: 4.7.h,
                    decoration: ContainerDecoration.boxDecoration(
                        bg: Color(0xff33405480).withOpacity(0.4),
                        border:Colors.transparent,
                        width: 1,
                        radius: 8),
                    margin: PagePadding.custom(4.w, 4.w, 0, 0),

                    child: Padding(
                      padding: PagePadding.horizontalSymmetric(2.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 1.w,
                          ),
                          Assets.svgs.search_normal
                              .svg(color: APPColors.bg_grey26),
                          Container(
                              width: 60.w,
                              padding: EdgeInsets.only(top: 3.w),
                              child: RabbleTextField.borderLess(
                                controller: bloc.controller,
                                color: APPColors.appWhite,
                                keyBoardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                cursoeColor: Colors.white,
                                hint: 'Search',
                                onChange: (String query) {
                                  if(query.isNotEmpty){
                                    bloc.searchContact(query);
                                  }else{
                                    bloc.resetContact();  // Add a method to reset the _filteredList to the original list
                                  }
                                },
                                filledColor: Colors.transparent,
                                fontFamily: cPoppins,
                                letterSpacing: 0.2,
                                hintColor: APPColors.bg_grey27,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Expanded(
                    child: Container(
                      color: APPColors.bgColor,

                      child: Column(
                        children: [
                          BehaviorSubjectBuilder<int>(
                              subject: bloc.totalSelectedContactSubject$,
                              builder: (context, snapshot) {
                                return Container(
                                  padding: PagePadding.custom(3.w, 3.w, 2.w, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: kContactsSelected,
                                        fontSize: 16.sp,
                                        fontFamily: 'Gosha',
                                        color: APPColors.appBlack4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      RabbleText.subHeaderText(
                                        text: snapshot.data.toString(),
                                        fontSize: 16.sp,
                                        fontFamily: 'Gosha',
                                        color: APPColors.appTextPrimary,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                );
                              }),
                          Expanded(
                              child: BehaviorSubjectBuilder<List<ContactData>>(
                                  subject: bloc.contactDataSubject$,
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData) return const Empty();
                                    if(snapshot.data!.isEmpty) return const Empty();

                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return ContactItemWidget(
                                            data: snapshot.data![index],
                                            callBack: (ContactData data) {
                                              bloc.onSelectedContact(data);
                                            },
                                          );
                                        });
                                  })),
                          BehaviorSubjectBuilder<int>(
                              subject: bloc.totalSelectedContactSubject$,
                              builder: (context, snapshot) {
                                return Container(
                                  margin: PagePadding.custom(3.w, 3.w, 0, 2.w),
                                  child: RabbleButton.tertiaryFilled(
                                    buttonSize: ButtonSize.large,
                                    bgColor: snapshot.data != 0
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: state.secondaryBusy
                                        ? null
                                        : () {
                                      bloc.inviteContacts(teamData);
                                    },
                                    child: state.secondaryBusy
                                        ? const RabbleSecondaryScreenProgressIndicator(
                                      enabled: true,
                                    )
                                        : RabbleText.subHeaderText(
                                      text: kInviateContact,
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
                                      color: snapshot.data != 0
                                          ? APPColors.appBlack
                                          : APPColors.bg_grey27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
