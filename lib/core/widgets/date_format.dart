import 'package:intl/intl.dart';

class DateFormatUtil {
  static String formatDate(String stringDate, String format) {
    print(stringDate);
    final parsedDate = DateTime.parse(stringDate.split(':')[0].split('T')[0]);
    final String formattedDate = DateFormat(format).format(parsedDate);
    return formattedDate;
  }

  static String formatDate2(String stringDate, String format) {
    print(stringDate);
    final parsedDate = DateTime.parse(stringDate.split(':')[0].split('T')[0]);

    String dayWithSuffix = _getDayWithSuffix(parsedDate.day);

    String formattedDate =
        '$dayWithSuffix ${DateFormat('MMMM', 'en_US').format(parsedDate)}';

    return formattedDate;
  }

  static String _getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  static String formatDateAndSubtract(String stringDate, String format) {
    final dateTime = DateTime.parse(stringDate).toLocal();

    final dateTimeMinus5Days =
        dateTime.subtract(Duration(days: 5)); // Subtracting 5 days

    final formatter = DateFormat(format);
    final formattedDate = formatter.format(dateTimeMinus5Days);
    return formattedDate;
  }

  static String formatDateAndAdd(String stringDate, String format) {
    final dateTime = DateTime.parse(stringDate).toLocal();

    final dateTimeMinus5Days =
        dateTime.add(Duration(days: 5)); // Subtracting 5 days

    final formatter = DateFormat(format);
    final formattedDate = formatter.format(dateTimeMinus5Days);
    return formattedDate;
  }

  static String countDays(String stringDate) {
    DateTime targetDate = DateTime.parse(stringDate).toLocal();

    DateTime currentDate = DateTime.now();

    int differenceInDays = targetDate.difference(currentDate).inDays + 1;

    return differenceInDays.toString();
  }

  static String calculatePercentage(int value, int total) {
    String percentage = ((value / total) * 100).toStringAsFixed(0);

    print('value ${value}');
    print('total ${total}');
    print("percentage ${percentage}");
    return int.parse(percentage) < 100 ? percentage.toString() : '100';
  }

  static double calculateScreenPercentage(num value, num total) {
    if (((value / total) * 1300) > total) {
      return total - 100.toDouble();
    }
    print("((value / total) * 1300) ${((value / total) * 1300)}");
    return ((value / total) * 1300);
  }

  static String convertEpochInWeek(String epochTime) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(epochTime) * 1000);
    int weeks = dateTime.difference(DateTime(1970)).inDays ~/ 7;

    return '$weeks Week';
  }

  int epochToTotalWeeks(int epochTimestamp) {
    final int days = epochTimestamp ~/
        (24 * 60 * 60); // Convert the timestamp to days directly
    final int weeks = days ~/ 7;
    return weeks == 0 ? 1 : weeks;
  }

  static String amountFormatter(double amount) {
    print("amount $amount");
    NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: '\£', // Currency symbol (optional)
      decimalDigits: 2, // Number of decimal digits (optional)
    );

    return currencyFormatter.format(amount);
  }

  static int remainingDays(String date) {
    DateTime currentDate = DateTime.now();
    DateTime futureDate = DateTime.parse(date).toLocal();

    Duration diff = futureDate.difference(currentDate);

    return diff.inDays < 0 && diff.inHours == 0 && diff.inMinutes == 0
        ? 0
        : diff.inHours < 24 && diff.inMinutes > 0
            ? 1
            : diff.inDays;
  }

  static String formatMessageTime(DateTime messageTime) {
    final now = DateTime.now();
    final difference = now.difference(messageTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('dd/MM/yyyy').format(messageTime);
    }
  }
}
