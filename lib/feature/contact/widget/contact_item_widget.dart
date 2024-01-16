import 'package:rabble/config/export.dart';

class ContactItemWidget extends StatelessWidget {
  final ContactData data;
  final Function callBack;

  const ContactItemWidget(
      {super.key, required this.data, required this.callBack});

  @override
  Widget build(BuildContext context) {
    List<String> text = data.heading!=null? data.heading!.split(' '):[];

    String firstCharName1  = '';
    String firstCharName2 = '';

    String combination = '';

    print("text ${text.length}");
    if(text.isNotEmpty){
       firstCharName1 = text[0];
       firstCharName2 = text.length >2? text[1]:" ";

       combination = '${firstCharName1 ?? ''} ${firstCharName2 ?? ''}' ;

    }
    return InkWell(
      onTap: () {
        data.isSelected != data.isSelected;
        callBack.call(data);
      },
      child: Container(
        width: 100.w,
        margin: PagePadding.onlyTop(4.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: APPColors.appBorder,
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: data.isSelected,
                      onChanged: (bool? newValue) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: APPColors.bg_grey25,
                        ),
                      ),
                      checkColor: APPColors.appPrimaryColor,
                      activeColor: APPColors.appBlack,
                      fillColor: MaterialStateProperty.all<Color>(
                          data.isSelected!
                              ? APPColors.appBlack
                              : APPColors.bg_grey25),
                    ),
                  ),
                ),
                Container(
                  width: 11.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: data.isSelected!
                        ? APPColors.appBlack
                        : APPColors.bg_grey29,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: combination != null
                          ? combination.length > 3
                              ? combination.substring(0, 2)
                              : combination
                          : '',
                      fontWeight: FontWeight.bold,
                      color: APPColors.appPrimaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RabbleText.subHeaderText(
                      text: data.heading ?? '',
                      fontWeight: FontWeight.bold,
                      fontFamily: cPoppins,
                      color: data.isSelected!
                          ? APPColors.appBlack
                          : APPColors.bg_grey29,
                      fontSize: 13.sp,
                    ),
                    RabbleText.subHeaderText(
                      text: data.subHeading ??'',
                      color: data.isSelected!
                          ? APPColors.appBlack
                          : APPColors.bg_grey29,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            const Divider(
              color: APPColors.bg_grey12,
              thickness: 0.5,
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
