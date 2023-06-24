import 'package:flutter/material.dart';
import 'package:material_calendar_event/material_calendar_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime currentDate;
  /*late List<EvenList> evenList = [
    EvenList("9:32", 0xff008A5E, "2023-06-01", ""),
    EvenList("10:20", 0xff008A5E, "2023-06-02", ""),
    EvenList("11:00", 0xff008A5E, "2023-06-03", ""),
    EvenList("5:20", 0xff008A5E, "2023-06-04", ""),
    EvenList("9:20", 0xff008A5E, "2023-06-05", ""),
    EvenList("", 0xffB73434, "2023-06-06", "LOP"),
    EvenList("9:20", 0xff008A5E, "2023-06-07", ""),
    EvenList("", 0xffF1BE41, "2023-06-08", "CL"),
    EvenList("9:20", 0xff008A5E, "2023-06-09", ""),
    EvenList("9:20", 0xff008A5E, "2023-06-10", ""),
    EvenList("", 0xffF1BE41, "2023-06-11", "CL"),
    EvenList("", 0xffB73434, "2023-06-12", "LOP"),
    EvenList("9:20", 0xff008A5E, "2023-06-13", ""),
    EvenList("9:20", 0xff008A5E, "2023-06-14", ""),
    EvenList("9:32", 0xff008A5E, "2023-06-15", ""),
    EvenList("10:20", 0xff008A5E, "2023-06-16", ""),
    EvenList("11:00", 0xff008A5E, "2023-06-17", ""),
    EvenList("5:20", 0xff008A5E, "2023-06-18", ""),
    EvenList("9:20", 0xff008A5E, "2023-06-19", ""),
    EvenList("", 0xffB73434, "2023-06-20", "LOP"),
    EvenList("9:20", 0xff008A5E, "2023-06-21", ""),
    EvenList("9:20", 0xff008A5E, "2023-06-22", ""),
  ];*/

  @override
  void initState() {
    currentDate = DateTime.now();
    setState(() {
      currentDate;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: MaterialCalendarEvent(currentDate: currentDate)),
    );
  }
}
