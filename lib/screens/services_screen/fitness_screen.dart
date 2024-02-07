import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class EventFitnessDay {
  // final String title;

  // const EventFitnessDay(this.title);

  // @override
  // String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<EventFitnessDay>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 3),
//     value: (item) => List.generate(1, (index) => EventFitnessDay()))
//   ;

final Map<DateTime, List<EventFitnessDay>> _kEventSource = Map();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// List<DateTime> daysInRange(DateTime first, DateTime last) {
//   final dayCount = last.difference(first).inDays + 1;
//   return List.generate(
//     dayCount,
//     (index) => DateTime.utc(first.year, first.month, first.day + index),
//   );
// }

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {

  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late final ValueNotifier<List<EventFitnessDay>> _selectedEvents;

  @override
  void initState() {
    super.initState();

 _selectedDay = _focusedDay;
 _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
 _selectedEvents.dispose();
    super.dispose();
  }

  List<EventFitnessDay> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
 _selectedDay = selectedDay;
 _focusedDay = focusedDay;
//  _rangeStart = null; // Important to clean those
//  _rangeEnd = null;
//  _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

 _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _addFitnessday(){
    if (kEvents.containsKey(_selectedDay)){
      kEvents.remove(_selectedDay);
    }
    else{
      kEvents.addAll({_selectedDay: [EventFitnessDay()]});
    }
  }
  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

//   void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//     setState(() {
//  _selectedDay = null;
//       _focusedDay = focusedDay;
//  _rangeStart = start;
//  _rangeEnd = end;
//  _rangeSelectionMode = RangeSelectionMode.toggledOn;
//     });

//     // `start` or `end` could be null
//     if (start != null && end != null) {
//       _selectedEvents.value = _getEventsForRange(start, end);
//     } else if (start != null) {
//       _selectedEvents.value = _getEventsForDay(start);
//     } else if (end != null) {
//       _selectedEvents.value = _getEventsForDay(end);
//     }
//   }

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тренировки'),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       setState(() {
        //         isEdit = !isEdit;
        //       });
        //     }, 
        //     icon: Icon(!isEdit ? Icons.edit : Icons.visibility))
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TableCalendar<EventFitnessDay>(
              locale: 'ru_RU',
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              calendarFormat: _calendarFormat,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                // selectedDecoration: 
                //   !isEdit ? 
                //   BoxDecoration(color: Color.fromARGB(199, 52, 77, 187),shape: BoxShape.circle) : 
                //   BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: Color.fromARGB(255, 255, 85, 7), shape: BoxShape.circle)
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () async{
                  setState(() 
                    {
                      _addFitnessday();
                    }
                  );
                  await FirebaseFirestore.instance.collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .update({
                      'trainings': List.generate(kEvents.length, (index) => dateFormat.
                      format(kEvents.keys.elementAt(index))),
                    }
                  );
                  
                }, 
                child: Text(
                  _selectedDay.compareTo(kToday) < 0 
                  
                  ? 

                  kEvents.containsKey(_selectedDay) ? 
                  'Перепутал, не тренировался' :
                  'Тренировался, честное слово' 
                  
                  : 

                  kEvents.containsKey(_selectedDay) ? 'Передумал':
                  'Потренируюсь, честно')),
            )
            // Expanded(
            // child: ValueListenableBuilder<List<EventFitnessDay>>(
            //   valueListenable: _selectedEvents,
            //   builder: (context, value, _) {
            //     return ListView.builder(
            //       itemCount: value.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: const EdgeInsets.symmetric(
            //             horizontal: 12.0,
            //             vertical: 4.0,
            //           ),
            //           decoration: BoxDecoration(
            //             border: Border.all(),
            //             borderRadius: BorderRadius.circular(12.0),
            //           ),
            //           child: ListTile(
            //             onTap: () => print('${value[index]}'),
            //             title: Text('${value[index]}'),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}