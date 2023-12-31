library material_calendar_event;

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class MaterialCalendarEvent extends StatefulWidget {
  final DateTime currentDate;
  List<EvenList>? evenList=[];

  MaterialCalendarEvent({super.key, required this.currentDate,this.evenList});

  @override
  State<StatefulWidget> createState() => MaterialCalendarEvent1();
}

class MaterialCalendarEvent1 extends State<MaterialCalendarEvent> {
  late int month, year;
  late String currentMonth, currentYear;
  late int startPosition = 0;
  late int endDate;
  late Map<int, dynamic> hasMap = {};

  //late List<DateList> dateList = [];
  late double sizeBox = 510;
  late double sizeBox1 = 250;
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



  @override
  void initState() {
    setState(() {
      widget.currentDate;
      month = widget.currentDate.month;
      year = widget.currentDate.year;
      currentMonth = DateFormat("MMM").format(widget.currentDate);
      currentYear = DateFormat("yyyy").format(widget.currentDate);
    });
    GetEndDate(month, year);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEFF3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //MONTH AND YEAR
            SizedBox(
              width: sizeBox,
              child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //REVERSED
                        IconButton(
                            onPressed: () {
                              setState(() {
                                month -= 1;
                              });
                              GetEndDate(month, year);
                            },
                            icon: Icon(
                              Icons.arrow_left_rounded,
                            )),

                        InkWell(
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "$currentMonth $currentYear",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              )),
                          onTap: () {
                            openAlertDialog(currentMonth, currentYear, 0);
                          },
                        ),

                        //FORWARD
                        IconButton(
                            onPressed: () {
                              setState(() {
                                month += 1;
                              });
                              GetEndDate(month, year);
                            },
                            icon: Icon(
                              Icons.arrow_right_rounded,
                            )),
                      ])),
            ),
            SizedBox(
              width: sizeBox,
              child: Table(
                children: [
                  TableRow(children: [
                    for (int i = 0; i < weekList.length; i++) ...[
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            weekList[i].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: weekList[i].toString() == "Sat" ||
                                        weekList[i].toString() == "Sun"
                                    ? Colors.black
                                    : Colors.black),
                          ))
                    ]
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: sizeBox,
              child: Column(children: [
                for (int i = 1; i <= (endDate / 6) + 1; i++) ...[
                  TableRowList(i)
                ]
              ]),
            )
          ],
        ),
      ),
    );
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

  GetMap(int endDate, int startPosition) {
    print("GetMap");
    hasMap = {};
    //List<DateList> dateList = [];
    List<String> str = [];
    int n = 1;
    print(startPosition);
    for (int i = 1; i <= (endDate / 6) + 1; i++) {
      str = [];
      int m = 1;
      for (int j = n; j <= (i == 1 ? 1 : 6 + n); j++) {
        if (i == 1) {
          for (int k = 0; k < 7; k++) {
            if (k < startPosition) {
              str.add("");
            } else {
              str.add(m.toString());

              m += 1;
            }
          }
        } else {
          str.add(endDate >= j ? j.toString() : "");

        }

        hasMap[i] = str;
      }
      n += i == 1 ? m - 1 : 7;
    }
    setState(() {
      hasMap;
    });
    print("Length" + hasMap.length.toString());
  }

  void openAlertDialog(String currentMonth, String currentYear, int n) {
    List<int> yearList = [];
    for (int i = int.parse(currentYear) - 8;
        i < int.parse(currentYear) + 8;
        i++) {
      yearList.add(i);
    }

    n == 0
        ? showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                  data: ThemeData(backgroundColor: Color(0xffEBEFF3)),
                  child: AlertDialog(
                    backgroundColor: const Color(0xffEBEFF3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white)),
                    actions: [
                      SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              //YEAR
                              InkWell(
                                child: Container(
                                  width: 240,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        currentYear,
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                onTap: () {
                                  openAlertDialog(currentMonth, currentYear, 1);
                                },
                              ),

                              //MONTH
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < monthList.length;
                                      i++) ...[
                                    InkWell(
                                      child: Card(
                                        elevation: 0,
                                        color: monthList[i].toString() ==
                                                currentMonth
                                            ? Color(0xff0074B7)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              monthList[i].toString(),
                                              style: TextStyle(
                                                  color:
                                                      monthList[i].toString() ==
                                                              currentMonth
                                                          ? Colors.white
                                                          : Colors.black),
                                            )),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        GetEndDate(
                                            i + 1, int.parse(currentYear));
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ],
                          ))
                    ],
                  ));
            })
        : showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                  data: ThemeData(backgroundColor: Color(0xff0074B7)),
                  child: AlertDialog(
                    backgroundColor: const Color(0xffEBEFF3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white)),
                    actions: [
                      SizedBox(
                          width: 350,
                          child: Column(
                            children: [
                              Container(
                                  width: 300,
                                  decoration: ShapeDecoration(
                                    //color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //REVERSED
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            openAlertDialog(currentMonth,
                                                yearList[0].toString(), 1);
                                          },
                                          icon: Icon(
                                            Icons.arrow_left_rounded,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            "${yearList[0]}-${yearList[yearList.length - 1]}",
                                            textAlign: TextAlign.center,
                                          )),
                                      //FORWARD
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            openAlertDialog(
                                                currentMonth,
                                                yearList[yearList.length - 1]
                                                    .toString(),
                                                1);
                                          },
                                          icon: Icon(
                                            Icons.arrow_right_rounded,
                                          )),
                                    ],
                                  )),

                              //YEAR
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  for (int i = 0; i < yearList.length; i++) ...[
                                    InkWell(
                                      child: Card(
                                        elevation: 0,
                                        color: yearList[i].toString() ==
                                                currentYear
                                            ? Color(0xff0074B7)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              yearList[i].toString(),
                                              style: TextStyle(
                                                  color:
                                                      yearList[i].toString() ==
                                                              currentYear
                                                          ? Colors.white
                                                          : Colors.black),
                                            )),
                                      ),
                                      onTap: () {
                                        int month = 0;
                                        for (int i = 0;
                                            i < monthList.length;
                                            i++) {
                                          if (currentMonth ==
                                              monthList[i].toString()) {
                                            month = i + 1;
                                            break;
                                          }
                                        }
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        openAlertDialog(currentMonth,
                                            yearList[i].toString(), 0);
                                        GetEndDate(month,
                                            int.parse(yearList[i].toString()));
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ],
                          ))
                    ],
                  ));
            });
  }

  TableRowList(int i) {
    List<String> str = hasMap[i];

    return Container(
      child: Table(
        children: [
          TableRow(children: [
            for (int j = 0; j < str.length; j++) ...[
              Column(
                children: [
                  //DATE
                  CheckCurrenDate(str[j].toString()),
                  //EVENLIST
                  CheckEventList(str[j].toString()),

                ],
              )
            ]
          ])
        ],
      ),
    );
  }

  CheckCurrenDate(String day) {
    String findMonth = DateFormat('MMM').format(widget.currentDate);
    String findYear = DateFormat('yyyy').format(widget.currentDate);
    String findDate = DateFormat('dd').format(widget.currentDate);
    return currentYear == findYear &&
            currentMonth == findMonth &&
            day == findDate
        ? Card(
            color: Color(0xff0074B7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      day.isEmpty ? Colors.black : TextDayColor(int.parse(day)),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ));
  }

  TextDayColor(int j) {
    var date1 = DateTime(year, month, j);
    String weekDays = DateFormat('EEE').format(date1);
    return weekDays == "Sat" || weekDays == "Sun" ? Colors.red : Colors.black;
  }

  CheckEventList(String day) {
    print("CheckEventList");
    bool isTrue = true;
    var dateFormat;
    if (day.isEmpty) {
    } else {
      var monthFormat =
      DateFormat('yyyy-MMM-dd').parse("$currentYear-$currentMonth-$day");
      dateFormat = DateFormat('yyyy-MM-dd').format(monthFormat);
      print(dateFormat.toString());
    }
    return Visibility(
        visible: day.isEmpty ? false : isTrue,
        maintainAnimation: true,
        maintainState: true,
        maintainSize: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int l = 0; l < widget.evenList!.length; l++) ...[
              if (dateFormat.toString() == widget.evenList?[l].date.toString()) ...[
                //EVENT
                CheckCurrentEvent(widget.evenList![l].date.toString(),
                    widget.evenList![l].clr.toString(), widget.evenList![l].time.toString()),
                //TIME
                CheckCurrentTime(
                    widget.evenList![l].date.toString(), widget.evenList![l].time.toString()),
              ] else ...[
                Text("")
              ]
            ]
          ],
        ));
  }
  CheckCurrentEvent(String day, String clr, String time) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Icon(Icons.circle_rounded, color: Color(int.parse(clr)), size: 5),
    );


    bool isTrue = true;
    if (day.isEmpty) {
    } else {
      /*var monthFormat =
          DateFormat('yyyy-MMM-dd').parse("$currentYear-$currentMonth-$day");*/
      var monthFormat = DateFormat('yyyy-MM-dd').parse(day);
      isTrue = widget.currentDate.isAfter(monthFormat);
    }


  }

  CheckCurrentTime(String day, String time) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Text(day.isEmpty ? "" : time,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
    );
  }


}

class EvenList {
  String? time;
  int? clr;
  String? date;
  String? msg;

  EvenList(this.time, this.clr, this.date, this.msg);
}
