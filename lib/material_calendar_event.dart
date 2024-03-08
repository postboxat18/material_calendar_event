library material_calendar_event;
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class MaterialCalendarEvent extends StatefulWidget {
  final List<EventList>? eventList;
  final Color selectedClr;
  final Color primaryColor;
  final String monthYear;

  const MaterialCalendarEvent(
      this.selectedClr, this.primaryColor, this.monthYear, this.eventList,
      {super.key});

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
  late bool isTab;
  late bool isLand;
  late double heightLand;
  late double widthLand;
  late double height;
  late double width;
  late double paddingHeight;
  late double paddingWidth;
  late List<String> weekList1 = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  late List<String> weekList = ["S", "M", "T", "W", "T", "F", "S"];
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = DateFormat('MMMM-yyyy').parse(widget.monthYear);
    setState(() {
      currentDate;
      month = currentDate.month;
      year = currentDate.year;
      currentMonth = DateFormat("MMM").format(currentDate);
      currentYear = DateFormat("yyyy").format(currentDate);
    });
    getEndDate(month, year);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLand = MediaQuery.of(context).orientation == Orientation.portrait;
    isTab = MediaQuery.of(context).size.shortestSide < 600 ? false : true;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    paddingWidth = isTab ? (width * 0.02) : (width * 0.03);
    paddingHeight = (height * 0.15);
    return Container(
      margin: EdgeInsets.fromLTRB(paddingWidth, 15, paddingWidth, 15),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: widget.selectedClr),
              borderRadius: BorderRadius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: width,
              child: Table(
                children: [
                  TableRow(children: [
                    for (int i = 0; i < weekList.length; i++) ...[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            weekList[i].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ))
                    ]
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: width,
              child: Column(children: [
                for (int i = 1; i <= (endDate / 6) + 1; i++) ...[
                  tableRowList(i)
                ]
              ]),
            )
          ],
        ),
      ),
    );
  }

  getEndDate(int monthEnd, int yearEnd) {

    var date = DateTime(yearEnd, monthEnd + 1, 0);
    String formattedTime = DateFormat("MMM").format(date);
    String findYear = DateFormat('yyyy').format(date);

    currentYear = findYear;
    var date1 = DateTime(yearEnd, monthEnd, 1);

    String weekDays = DateFormat("EEE").format(date1);

    for (int i = 0; i < weekList.length; i++) {
      if (weekList1[i].toString() == weekDays) {
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

    getMap(endDate, startPosition);
  }

  getMap(int endDate, int startPosition) {
    hasMap = {};
    //List<DateList> dateList = [];
    List<String> str = [];
    int n = 1;

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
  }

  tableRowList(int i) {
    List<String> str = hasMap[i];
    String isSelect = "";
    return Table(
      children: [
        TableRow(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: widget.selectedClr))),
            children: [
              for (int j = 0; j < str.length; j++) ...[
                StatefulBuilder(
                  builder: (context, setState) => InkWell(
                    child: Container(
                      height: isLand ? height / 3 : height / 7,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: isSelect == j.toString()
                                    ? widget.selectedClr
                                    : Colors.transparent)),
                      ),
                      child: Column(
                        children: [
                          //DATE
                          checkCurrentDate(str[j].toString()),
                          //EVENT LIST
                          checkEventList(str[j].toString(), 0),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (str[j].isNotEmpty) {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              String weekDay = "";
                              String month = "";
                              DateTime list = DateFormat("MMMM-yyyy")
                                  .parse(widget.monthYear);
                              var monthFormat = DateFormat('yyyy-MM-dd')
                                  .parse(
                                      "${list.year}-${list.month}-${str[j]}");
                              weekDay =
                                  DateFormat('EEEE').format(monthFormat);
                              month = DateFormat('MMMM').format(monthFormat);
                              bool isCurrentData = false;
                              DateTime now = DateTime.now();
                              int n = DateTime(list.year, list.month,
                                      int.parse(str[j]))
                                  .difference(
                                      DateTime(now.year, now.month, now.day))
                                  .inDays;
                              isCurrentData = n == 0;

                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                actions: <Widget>[
                                  Container(
                                    height: height / 3,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //DATE DAY
                                        Row(
                                          children: [
                                            Text(
                                              str[j],
                                              style: TextStyle(
                                                  color: isCurrentData
                                                      ? widget.primaryColor
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                weekDay,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: Divider(
                                            color: widget.selectedClr,
                                          ),
                                        ),
                                        //DATE MONTH
                                        Row(
                                          children: [
                                            Text(
                                              str[j],
                                              style: TextStyle(
                                                  color: isCurrentData
                                                      ? widget.primaryColor
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                month,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    fontSize: 10),
                                              ),
                                            )
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: Wrap(
                                            children: [
                                              checkEventList(
                                                  str[j].toString(), 1),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                  ),
                )
              ]
            ])
      ],
    );
  }

  checkCurrentDate(String day) {
    String findMonth = DateFormat('MMM').format(DateTime.now());
    String findYear = DateFormat('yyyy').format(DateTime.now());
    String findDate = DateFormat('dd').format(DateTime.now());
    String date = "";
    if (day.isNotEmpty) {
      DateTime dates = DateFormat('dd').parse(day);
      date = DateFormat('dd').format(dates);
    }
    return currentYear == findYear &&
            currentMonth == findMonth &&
            date == findDate
        ? Card(
            margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: widget.primaryColor)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
            padding: const EdgeInsets.all(5),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      day.isEmpty ? Colors.black : textDayColor(int.parse(day)),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ));
  }

  textDayColor(int j) {
    var date1 = DateTime(year, month, j);
    String weekDays = DateFormat('EEE').format(date1);
    return weekDays == "Sat" || weekDays == "Sun" ? Colors.black : Colors.black;
  }

  checkEventList(String i, int val) {
    String day = "";
    if (i.isNotEmpty) {
      DateTime dates = DateFormat('dd').parse(i);
      day = DateFormat('dd').format(dates);
    }
    bool isTrue = true;
    var dateFormat;
    if (day.isEmpty) {
    } else {
      DateTime list = DateFormat("MMMM-yyyy").parse(widget.monthYear);
      var monthFormat =
          DateFormat('yyyy-MM-dd').parse("${list.year}-${list.month}-$day");
      dateFormat = DateFormat('yyyy-MM-dd').format(monthFormat);
    }

    return Visibility(
        visible: day.isEmpty ? false : isTrue,
        maintainAnimation: true,
        maintainState: true,
        maintainSize: true,
        child: Wrap(
          children: [
            for (int l = 0; l < widget.eventList!.length; l++) ...[
              if (dateFormat.toString() ==
                  widget.eventList?[l].date.toString()) ...[
                eventFunc(widget.eventList![l], val),
              ] else ...[
                const Text("")
              ]
            ]
          ],
        ));
  }

  eventFunc(EventList eventList, int val) {
    List<EventName> eventName = eventList.map[eventList.date];
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        //spacing: 2,
        children: [
          for (int i = 0; i < eventName.length; i++) ...[
            Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: val == 1
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (eventName[i].msg?.isNotEmpty ?? false) ...[
                    //CIRCLE
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                      child: Icon(Icons.circle_rounded,
                          color: eventName[i].color, size: 5),
                    ),
                  ],
                  //TIME
                  textMsg(
                      eventName[i].msg ?? "", eventName[i].fulMsg ?? "", val),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  textMsg(String msg, String fulMsg, int val) {
    if (val == 0) {
      msg = msg;
    } else {
      msg = fulMsg;
    }

    return Text(msg,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400));
  }
}

class EventList {
  String? date;
  Map<dynamic, dynamic> map;

  EventList(this.date, this.map);

  @override
  String toString() {
    // TODO: implement toString
    return "$date $map \n";
  }
}

class EventName {
  final Color? color;
  final String? msg;
  final String? fulMsg;

  EventName(this.color, this.msg, this.fulMsg);

  @override
  String toString() {
    // TODO: implement toString
    return "$color $msg $fulMsg\n";
  }
}
