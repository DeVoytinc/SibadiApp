import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RaspisanieDay extends StatelessWidget {
  final int daynumber;
  final String dayname;
  final int index;
  final DateTime date;
  bool selected = false;

  RaspisanieDay({
    required this.daynumber,
    required this.dayname,
    required this.index,
    required this.date,
    super.key,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: date.day == DateTime.now().day &&
                    date.month == DateTime.now().month &&
                    date.year == DateTime.now().year
                ? Colors.white
                : Theme.of(context).appBarTheme.backgroundColor!,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  daynumber.toString(),
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  dayname,
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
}
