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

    return differenceInDays <0? '0': differenceInDays.toString();
  }

  static String calculatePercentage(int value, int total) {
    String percentage = ((value / total) * 100).toStringAsFixed(0);

    print('value ${value}');
    print('total ${total}');
    print("percentage ${percentage}");
    if(percentage=='NaN')
      return '0';
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


 static String getNextDeliveryDate(String? dateString, int frequencyInSeconds) {
    if (dateString == null) {
      return 'Next Delivery date TBD';
    }

    DateTime targetDate = DateTime.parse(dateString).toLocal();
    DateTime currentDate = DateTime.now();

    // Calculate the adjusted target date based on frequency
    DateTime adjustedDate = targetDate;
    if (currentDate.isAfter(targetDate)) {
      // Date has passed, calculate the next delivery date
      int daysToAdd = 0;
      switch (frequencyInSeconds) {
        case 604800: // 1 week
          daysToAdd = 7;
          break;
        case 1209600: // 2 weeks
          daysToAdd = 14;
          break;
        case 2419200: // 1 month
        // Adjusted to the next month
          adjustedDate = DateTime(targetDate.year, targetDate.month + 1, targetDate.day);
          break;
        default:
        // Custom frequency, calculate based on seconds
          daysToAdd = (frequencyInSeconds / 86400).round();
          break;
      }
      adjustedDate = adjustedDate.add(Duration(days: daysToAdd));
    }

    // Calculate the difference in days
    int differenceInDays = daysBetween(currentDate,adjustedDate);

    // Return appropriate string based on the difference
    if (differenceInDays == 0) {
      return 'Next Delivery due today';
    } else if (differenceInDays == 1) {
      return 'Next Delivery tomorrow';
    } else if (differenceInDays > 1 && differenceInDays <= 10) {
      return 'Next Delivery in $differenceInDays days';
    } else {
      return 'Next Delivery on ${DateFormat('dd MMM yyyy').format(adjustedDate)}';
    }
  }
 static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
