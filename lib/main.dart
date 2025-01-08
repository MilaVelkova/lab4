import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab4/screen/EventDetailsDialog.dart';
import 'package:lab4/screen/MapScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'firebase_options.dart';
import 'models/Event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред на полагање',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late Map<DateTime, List<Event>> events;
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    events = {};
  }

  void onSaveEvent(Event event) {
    setState(() {
      if (events[event.date] == null) {
        events[event.date] = [];
      }
      events[event.date]?.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Распоред на полагањe'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: selectedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          Expanded(
            child: ListView(
              children: events[selectedDay] != null
                  ? events[selectedDay]!.map((event) {
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text('${event.location} - ${event.time}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(event: event),
                      ),
                    );
                  },
                );
              }).toList()
                  : [],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return EventDetailsDialog(
                      selectedDay: selectedDay,
                      onSaveEvent: onSaveEvent,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



