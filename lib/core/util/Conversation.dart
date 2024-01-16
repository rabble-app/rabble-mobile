import 'package:rabble/core/widgets/date_format.dart';

class Conversation {
  static getFrequencyText(int freequency) {
    int fq = DateFormatUtil().epochToTotalWeeks(freequency);

    if (fq == 1) {
      return 'Weekly';
    }
    if (fq > 1 && fq < 4) {
      return 'Every ${fq.toInt()} Weeks';
    }

    if (fq >= 4 && fq <= 8) {
      return 'Monthly';
    }

    if (fq > 4) {
      return 'Every ${(fq / 4).toInt()} Months';
    }

    return '';
  }

  static getFrequencyText2(int freequency) {
    int fq = DateFormatUtil().epochToTotalWeeks(freequency);

    print('fq ${fq}');
    print('fq ${fq}');

    if (fq == 1) {
      return 'Every Week';
    }
    if (fq > 1 && fq < 4) {
      return 'Every ${fq.toInt()} Weeks';
    }

    if (fq >= 4 && fq < 8) {
      return 'Every Month';
    }

    if (fq > 4) {
      return 'Every ${(fq / 4).toInt()} Months';
    }

    return '';
  }
}
