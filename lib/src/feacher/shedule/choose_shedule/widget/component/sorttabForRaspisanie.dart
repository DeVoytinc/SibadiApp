import 'package:flutter/material.dart';
import 'package:untitled1/src/feacher/shedule/choose_shedule/widget/screen/choose_shedule_screen.dart';

class SortTabRaspisanie extends StatelessWidget {
  SortTabRaspisanie(
      {required this.index,
      required this.label,
      required this.funk,
      super.key});

  int index = 0;
  String label;
  Function(int) funk;

  @override
  Widget build(BuildContext context) => Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            funk(index);
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: tabIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.white10,
              //side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ));
}
