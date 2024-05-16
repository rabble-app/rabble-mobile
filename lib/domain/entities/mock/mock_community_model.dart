import 'package:rabble/core/config/export.dart';

class MockCommunityModel {
  final String heading, subHeading;
  final PngGenImage image;

  MockCommunityModel({
    required this.heading,
    required this.subHeading,
    required this.image,
  });

  static List<MockCommunityModel> getMockDaysData() {
    return [
      MockCommunityModel(
          heading: 'Supporting sustainable farming ',
          subHeading: 'Rewarding the farmer with consistent orders',
          image: Assets.png.sustaible),
      MockCommunityModel(
          heading: 'Eliminating food waste ',
          subHeading: 'It doesn’t sit on shelves waiting to be bought',
          image: Assets.png.waste),
      MockCommunityModel(
          heading: 'Buying at a significant discount.',
          subHeading:
              'Buying as a team allows the producer to discount the items',
          image: Assets.png.sale)
    ];
  }
}
