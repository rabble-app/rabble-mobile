import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rabble/core/config/export.dart';

class CustomCalendar extends StatefulWidget {
  final String nextDate;
  final Function(DateTime)? selectedDateCallBack;
  CustomCalendar(this.nextDate, {this.selectedDateCallBack});


  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat cf = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late DateTime firstDay;
  late DateTime lastDay;


  void _calculateBounds() {
    firstDay = DateTime(focusedDay.year, focusedDay.month, 1);
    final daysInMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0).day;
    lastDay = DateTime(focusedDay.year, focusedDay.month, daysInMonth);
  }

  void _previousMonth() {
    final previousMonth = DateTime(focusedDay.year, focusedDay.month - 1, focusedDay.day);
    setState(() {
      selectedDay = previousMonth;
      focusedDay = previousMonth;
      _calculateBounds();
    });
  }

  void _nextMonth() {
    final nextMonth = DateTime(focusedDay.year, focusedDay.month + 1, focusedDay.day);
    setState(() {
      selectedDay = nextMonth;
      focusedDay = nextMonth;
      _calculateBounds();
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateBounds();
  }

  @override
  Widget build(BuildContext context) {
    print("Date ${widget.nextDate}");
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: APPColors.appWhite,
        border: Border.all(width: 2, color: APPColors.appWhite),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3), // Offset in the x and y direction
          ),
        ],
      ),
      child: Container(
        margin: PagePadding.all(3.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RabbleText.subHeaderText(
                  text: DateFormat.yMMMM().format(focusedDay),
                  fontFamily: cPoppins,
                  color: APPColors.bg_grey30,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: _previousMonth,
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: APPColors.bg_grey31,
                          size: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    InkWell(
                      onTap: _nextMonth,
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: APPColors.bg_grey31,
                          size: 14,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            const Divider(
              color: APPColors.bg_grey23,
              thickness: 1,
              height: 0.1,
            ),
            SizedBox(
              height: 2.h,
            ),
            TableCalendar(
              firstDay: firstDay,
              lastDay: lastDay,
              focusedDay: selectedDay,
              onDaySelected: (DateTime sl, DateTime fc) {
                setState(() {
                  selectedDay = sl;
                  focusedDay = fc;
                });

                widget.selectedDateCallBack!.call(selectedDay);
              },
              onPageChanged: (DateTime focusedDay) {
                selectedDay = focusedDay;
                _calculateBounds();
              },
              selectedDayPredicate: (DateTime day) => isSameDay(selectedDay, day),
              availableCalendarFormats: const {CalendarFormat.month: ''},
              availableGestures: AvailableGestures.horizontalSwipe,
              shouldFillViewport: false,
              calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                      color: APPColors.bg_grey30,
                      fontSize: 10.sp,
                      fontFamily: cUrbanist,
                      fontWeight: FontWeight.w400),
                  selectedDecoration: const BoxDecoration(
                    color: APPColors.appBlack,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                      color: APPColors.bg_grey30,
                      fontSize: 10.sp,
                      fontFamily: cUrbanist,
                      fontWeight: FontWeight.w400),
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                      color: APPColors.appPrimaryColor,
                      fontFamily: cUrbanist,
                      fontSize: 9.sp),
                  weekendDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(
                      color: APPColors.bg_grey30,
                      fontSize: 10.sp,
                      fontFamily: cUrbanist,
                      fontWeight: FontWeight.w400),
                  weekNumberTextStyle: TextStyle(
                      color: APPColors.bg_grey30,
                      fontSize: 10.sp,
                      fontFamily: cUrbanist,
                      fontWeight: FontWeight.w400)),
              headerVisible: false,
              rowHeight: 5.h,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: APPColors.bg_grey32,
                    fontSize: 10.sp,
                    fontFamily: cUrbanist,
                    fontWeight: FontWeight.w400),
                weekendStyle: TextStyle(
                    color: APPColors.bg_grey32,
                    fontSize: 10.sp,
                    fontFamily: cUrbanist,
                    fontWeight: FontWeight.w400),
              ),
              onFormatChanged: (CalendarFormat f) {
                setState(() {
                  cf = f;
                });
              },
              calendarBuilders: CalendarBuilders(
                outsideBuilder: (BuildContext context, DateTime day, _) {
                  return const SizedBox.shrink();
                },
              ),
              calendarFormat: cf,
            )
          ],
        ),
      ),
    );
  }
}
