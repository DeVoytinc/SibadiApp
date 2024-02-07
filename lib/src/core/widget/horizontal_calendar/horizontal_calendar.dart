import 'package:flutter/material.dart';
import 'package:untitled1/src/core/widget/horizontal_calendar/day_tab.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({required this.itemBuilder, super.key});

  final Widget? Function(BuildContext, DateTime) itemBuilder;

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  
  List<String> listOfDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  PageController daysController = PageController(initialPage: 13);
  late PageController raspController;
  int selectedIndex = 0;
  DateTime threeMonthAgo =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 13 * 7 + (DateTime.now().weekday - 1)));
  DateTime threeMonthBefore =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: 13 * 7 + (7 - DateTime.now().weekday)));
  late int count;
  List<DateTime> indexesWithDate = [];
  int daypageindex = 13;
  int previousRaspIndex = 0;
  bool userinputrasp = true;
  bool userinputcalendar = true;

  @override
  void initState() {
    super.initState();
    count = threeMonthBefore.difference(threeMonthAgo).inDays;
    indexesWithDate = List.generate(
      count,
      (index) => threeMonthAgo.add(Duration(days: index)),
    );
    selectedIndex = indexesWithDate.indexOf(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    raspController = PageController(
    initialPage: selectedIndex,
  );
  }

  void _changeSelectedIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  Widget raspisanieDayConstructor(int index) => Expanded(
        child: GestureDetector(
          onTap: () {
            _changeSelectedIndex(index);
            raspController.jumpToPage(index);
          },
          child: RaspisanieDay(
            daynumber: indexesWithDate[index].day,
            dayname: listOfDays[indexesWithDate[index].weekday - 1],
            index: index,
            date: indexesWithDate[index],
            selected: selectedIndex == index,
          ),
        ),
      );

  Widget horizontalCalendar() => Container(
        height: 70,
        width: double.infinity,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: PageView.builder(
          controller: daysController,
          onPageChanged: (value) => setState(() {
            userinputrasp = false;
            if (value < daypageindex && userinputcalendar) {
              raspController.jumpToPage(selectedIndex - 7);
            } else if (value > daypageindex && userinputcalendar) {
              raspController.jumpToPage(selectedIndex + 7);
            }
            userinputcalendar = true;
            userinputrasp = true;
            daypageindex = value;
          }),
          itemCount: 26,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                raspisanieDayConstructor(0 + 7 * index),
                raspisanieDayConstructor(1 + 7 * index),
                raspisanieDayConstructor(2 + 7 * index),
                raspisanieDayConstructor(3 + 7 * index),
                raspisanieDayConstructor(4 + 7 * index),
                raspisanieDayConstructor(5 + 7 * index),
                raspisanieDayConstructor(6 + 7 * index),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          horizontalCalendar(),
          Expanded(
            child: PageView.builder(
              controller: raspController,
              onPageChanged: (value) {
                if (value < previousRaspIndex &&
                    previousRaspIndex % 7 == 0 &&
                    userinputrasp) {
                  userinputcalendar = false;
                  daysController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                }
                if (value > previousRaspIndex &&
                    previousRaspIndex % 7 == 6 &&
                    userinputrasp) {
                  userinputcalendar = false;
                  daysController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                }
                userinputrasp = true;
                _changeSelectedIndex(value);
                previousRaspIndex = value;
              },
              itemCount: 26 * 7 + 7,
              itemBuilder: (context, index) {
                final date = indexesWithDate[index];
                return widget.itemBuilder(context, date);
              },
            ),
          ),
        ],
      );
}
