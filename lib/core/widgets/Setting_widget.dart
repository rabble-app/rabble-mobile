import 'package:rabble/config/export.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigatorHelper().navigateTo('/setting_view');
      },
      child: Padding(
        padding: PagePadding.onlyRight(2.w),
        child: Assets.svgs.setting.svg(color: APPColors.appPrimaryColor),
      ),
    );
  }
}
