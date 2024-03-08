import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late List<EventList> eventList = [
    EventList("2024-03-01",
        {"2024-03-01": [EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-03",
        {"2024-03-03": [EventName(Color(0xffF1BE41), "PH", "Public Holiday")]}),
    EventList("2024-03-05",
        {"2024-03-05": [EventName(Color(0xff008A5E), "10:20", "10:20"), EventName(Color(0xffB73434), "SL", "Sick Leave")]}),
    EventList("2024-03-06",
        {"2024-03-06": [EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-07",
        {"2024-03-07": [EventName(Color(0xffB73434), "CL", "Casual Leave")]}),
    EventList("2024-03-10",
        {"2024-03-10": [EventName(Color(0xffF1BE41), "PH", "Public Holiday")]}),
    EventList("2024-03-11",
        {"2024-03-11": [EventName(Color(0xff008A5E), "10:20", "10:20"),EventName(Color(0xffB73434), "CL", "Casual Leave")]}),
    EventList("2024-03-14",
        {"2024-03-14": [EventName(Color(0xffF1BE41), "CL", "Casual Leave")]}),
    EventList("2024-03-15",
        {"2024-03-15": [EventName(Color(0xffF1BE41), "PH", "Public Holiday")]}),
    EventList("2024-03-16",
        {"2024-03-16":[ EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-18",
        {"2024-03-18":[ EventName(Color(0xff008A5E), "10:20", "10:20"),EventName(Color(0xffB73434), "SL", "Sick Leave")]}),
    EventList("2024-03-20",
        {"2024-03-20": [EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-22",
        {"2024-03-22": [EventName(Color(0xffB73434), "SL", "Sick Leave")]}),
    EventList("2024-03-24",
        {"2024-03-24": [EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-26",
        {"2024-03-26":[ EventName(Color(0xffB73434), "CL", "Casual Leave")]}),
    EventList("2024-03-29",
        {"2024-03-29": [EventName(Color(0xff008A5E), "10:20", "10:20")]}),
    EventList("2024-03-30",
        {"2024-03-30": [EventName(Color(0xffF1BE41), "SL", "Sick Leave")]}),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  SingleChildScrollView(child: MaterialCalendarEvent(Colors.grey, Colors.blueAccent, DateFormat("MMMM-yyyy")
              .format(DateTime.now()), eventList),),
    );
  }
}
