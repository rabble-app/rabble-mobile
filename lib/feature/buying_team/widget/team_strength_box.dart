import '../../../core/config/export.dart';

class TeamStrengthBox extends StatelessWidget {
  const TeamStrengthBox({Key? key, required  this.amountSaved, required this.teamStrength, required this.vansPrevented,}) : super(key: key);

  final String vansPrevented;
  final String amountSaved;

  final String teamStrength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        content(Assets.png.preventedVans.png(), '$vansPrevented $kVans'),
        content(Assets.png.amountSaved.png(), '$amountSaved $kAmountSaved'),
        
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const PagePadding.customHorizontalVerticalSymmetric(7, 7),
            decoration: BoxDecoration(
              color: APPColors.appGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RabbleText.subHeaderText(
              text: '$kTeamStrength $teamStrength',
              textAlign: TextAlign.center,
              color: APPColors.appWhite,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget content(Widget icon, String text) {
    return Padding(
      padding: const PagePadding.onlyTop(6),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 3.w,
          ),
          RabbleText.subHeaderText(
            text: text,
            color: APPColors.appBlack,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
