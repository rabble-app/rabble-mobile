import '../../../config/export.dart';

class TotalMembersView extends StatelessWidget {
  const TotalMembersView({Key? key, required this.memberCount, }) : super(key: key);

  final String memberCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RabbleText.subHeaderText(
          text: kManageMTeamMembers,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        RabbleText.subHeaderText(
          text: '$memberCount $kMembers',
          fontSize: 11.sp,
          fontWeight: FontWeight.normal,
          color: APPColors.greyText,
        ),
      ],
    );
  }
}
