library material_calendar_event;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
class MaterialCalendarEvent extends StatefulWidget {
  final DateTime currentDate;
  const MaterialCalendarEvent({super.key,
    required this.currentDate});

  @override
  State<StatefulWidget> createState() => MaterialCalendarEvent1(currentDate);
}

class MaterialCalendarEvent1 extends State<MaterialCalendarEvent> {
  late int month, year;
  late String currentMonth, currentYear;
  late DateTime currentDate;
  late int startPosition = 0;
  late int endDate;
  late Map<int, dynamic> hasMap = {};
  //late List<DateList> dateList = [];
  late List<String> weekList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  late List<String> monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  MaterialCalendarEvent1(this.currentDate);
  @override
  void initState() {
    setState(() {
      currentDate;
      month = currentDate.month;
      year = currentDate.year;
      currentMonth = DateFormat("MMM").format(currentDate);
      currentYear = DateFormat("yyyy").format(currentDate);
    });
    GetEndDate(month, year);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  GetEndDate(int monthEnd, int yearEnd) {
    /*setState(() {
      currentmonthEnd = DateFormat("MMM").format();
      currentYear = DateFormat("yyyy").format(today);
    });*/
    var date = DateTime(yearEnd, monthEnd + 1, 0);
    String formattedTime = DateFormat("MMM").format(date);
    String findYear = DateFormat('yyyy').format(date);
    print(date);
    print(findYear);
    currentYear = findYear;
    var date1 = DateTime(yearEnd, monthEnd, 1);
    print(date1);
    String weekDays = DateFormat("EEE").format(date1);
    print(weekDays);
    for (int i = 0; i < weekList.length; i++) {
      if (weekList[i].toString() == weekDays) {
        startPosition = i;
        break;
      }
    }
    currentMonth = formattedTime;

    setState(() {
      month = monthEnd;
      year = yearEnd;
      currentMonth;
      currentYear;
      endDate = date.day.toInt();
    });
    print(endDate);
    GetMap(endDate, startPosition);
  }

}
