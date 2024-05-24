class MockHubModel {
  String postCodeTo;
  String postCodeFrom;

  MockHubModel(this.postCodeTo, this.postCodeFrom);

  static List<MockHubModel> getMockHubs() {
    return [
      MockHubModel('TR19 7AA', 'KW1 4YT'),
      MockHubModel('75190', '74900'),
      MockHubModel('75160', '75900'),
    ];
  }
}
