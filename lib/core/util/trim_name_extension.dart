extension NameExtensions on String {

  String getName() {
    List<String> text = split(' ');

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : ' ';

      combination = firstCharName2.isNotEmpty
          ? firstCharName1[0] + firstCharName2[0]
          : firstCharName1[0];
    }
    return combination;
  }
}
