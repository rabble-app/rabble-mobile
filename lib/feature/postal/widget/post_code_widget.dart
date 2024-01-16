import 'package:rabble/config/export.dart';

class PostCodeWidget extends StatelessWidget {
  final Function? callBack;

  const PostCodeWidget({Key? key, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
        create: (context) => PostalCubit(),
        builder: (context, state, bloc) {
          return BehaviorSubjectBuilder<String>(
              subject: PostalCodeService().postalCodeGlobalSubject,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    callBack!.call();
                  },
                  child: Row(
                    children: [
                      Assets.svgs.pin.svg(
                          width: 5.w,
                          height: 2.h,
                          color:  APPColors.appPrimaryColor3),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      RabbleText.subHeaderText(
                        text: snapshot.data!.isEmpty ? '-' : snapshot.data!,
                        color: APPColors.appPrimaryColor3,
                        fontSize: 13.sp,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
