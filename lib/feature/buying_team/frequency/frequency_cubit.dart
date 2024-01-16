import 'package:rabble/config/export.dart';

class FrequencyCubit extends RabbleBaseCubit {
  FrequencyCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<bool> validateFrequnecySelected$ =
      BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<FrequencyData> frequencySelectedUpdateSubject$ =
      BehaviorSubject<FrequencyData>();
  BehaviorSubject<List<FrequencyData>> frequencyDataSubject$ =
      BehaviorSubject<List<FrequencyData>>.seeded([
    FrequencyData(
        heading: kOnceWeek,
        frequecnyEpoch: kOnceWeekN,
        isSelected: false,
        isCustom: false),
    FrequencyData(
        heading: kOnce2Week,
        frequecnyEpoch: kOnce2WeekN,
        isSelected: false,
        isCustom: false),
    FrequencyData(
        heading: kEveryMonth,
        frequecnyEpoch: kEveryMonthN,
        isSelected: false,
        isCustom: false),
    FrequencyData(
        heading: kEvery2Months,
        frequecnyEpoch: kEvery2MonthN,
        isSelected: false,
        isCustom: false),
  ]);

  void onSelectedFrequency(FrequencyData data, int index) {
    print(index);
    List<FrequencyData> tempList = frequencyDataSubject$.value;
    for (int i = 0; i < tempList.length; i++) {
      if (i == index) {
        frequencySelectedUpdateSubject$.sink.add(data);

        BuyingTeamCreationService()
            .addTeamCreationData(mFrequency, int.parse(data.frequecnyEpoch!));

        validateFrequnecySelected$.sink.add(true);
        data.isSelected = true;
        data.isCustom = true;

        tempList[tempList
            .indexWhere((element) => element.heading == data.heading)] = data;
      } else {
        tempList[i].isCustom = false;
        tempList[i].isSelected = false;
      }
    }
    print(BuyingTeamCreationService().creationDataSubject$.value[mFrequency]);
    frequencyDataSubject$.sink.add(tempList);
  }

  BehaviorSubject<String> weekSubject$ = BehaviorSubject<String>.seeded(
    'Week',
  );
  BehaviorSubject<int> isExpandedSubject$ = BehaviorSubject<int>.seeded(0);

  BehaviorSubject<String> numberSubject$ = BehaviorSubject<String>.seeded('1');

  BehaviorSubject<List<String>> weekListSubject$ =
      BehaviorSubject<List<String>>.seeded(['Week', 'Month']);

  List<String> weekList = ['Week', 'Month'];

  void onUpdateFrequency(FrequencyData data, int index) {
    List<FrequencyData> tempList = frequencyDataSubject$.value;

    for (int i = 0; i < tempList.length; i++) {
      if (i == index && data.isSelected!) {
        frequencySelectedUpdateSubject$.sink.add(data);
        tempList[i].isCustom = true;

        validateFrequnecySelected$.sink.add(true);
        tempList[i].isSelected = true;
      } else {
        tempList[i].isCustom = false;
        tempList[i].isSelected = false;
      }
    }
    frequencyDataSubject$.sink.add(tempList);
  }

  Future<bool> updateTeamData(String teamId, Map<String, dynamic> body, {bool? same}) async {
    emit((RabbleBaseState.secondaryBusy()));

    var addTeamRes =
        await userRepo.updateTeamData(teamId, throwOnError: true, body: body,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (addTeamRes!.status == 200) {
      if(same==null)
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  BehaviorSubject<DateTime> selectedDateFormat$ = BehaviorSubject<DateTime>();

  int calculateWeekToEpoch(String value, String key) {
    late int epochTime;

    print("key $key");
    print("Value $value");

    if (key == 'Week') {
      int secondsPerWeek = 7 * 24 * 60 * 60; // Number of seconds in a week
      epochTime = int.parse(value) * secondsPerWeek;
    } else {
      // Using an average month length of 30.44 days
      int secondsPerMonth = (28 * 24 * 60 * 60).round(); // Number of seconds in an average month
      epochTime = int.parse(value) * secondsPerMonth;
    }

    print("epochTime $epochTime");
    return epochTime;
  }


  getHintPersonalization(String? producerName, int? frequency) {
    int value = DateFormatUtil().epochToTotalWeeks(frequency!);

    String result = 'We buy direct from $producerName ';

    if (value == 1) {
      result += 'weekly';
    } else if (value >= 4) {
      int months =
          value ~/ 4; // Integer division to get the number of full months.
      int remainingWeeks =
          value % 4; // Remaining weeks after extracting full months.

      if (months > 0) {
        result += (months == 1) ? '${remainingWeeks > 0? '$months month':' monthly'}' : 'every $months months';
      }

      if (remainingWeeks > 0) {
        if (months > 0) {
          result += ' and ';
        }
        result += '$remainingWeeks week${remainingWeeks > 1 ? 's' : ''}';
      }
    } else {
      result += 'every $value weeks';
    }

    return result += '. Send me a message and join the team';
  }

}
