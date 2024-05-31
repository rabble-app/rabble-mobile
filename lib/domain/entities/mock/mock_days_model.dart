class MockDaysModel {
  final String dayName;
  final String time;

  MockDaysModel({required this.dayName, required this.time});

  static List<MockDaysModel> getMockDaysData() {
    return [
      MockDaysModel(dayName: 'Monday', time: '9:00 AM - 6:00 PM'),
      MockDaysModel(dayName: 'Tuesday', time: '9:00 AM - 6:00 PM'),
      MockDaysModel(dayName: 'Wednesday', time: '9:00 AM - 6:00 PM'),
      MockDaysModel(dayName: 'Thursday', time: '9:00 AM - 6:00 PM'),
      MockDaysModel(dayName: 'Friday', time: 'Open 24/7'),
    ];
  }
}
