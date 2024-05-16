extension NameExtensions on String {
  String get initials {
    if (isEmpty) return '';

    final List<String> words = trim().split(' ');
    final StringBuffer initials = StringBuffer();

    for (final String word in words) {
      if (word.isNotEmpty) {
        initials.write(word[0]);
      }
    }

    return initials.toString();
  }
}
