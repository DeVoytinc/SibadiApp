import 'package:flutter/material.dart';

import 'ChooseRaspisanie.dart';

// ignore: must_be_immutable
class SortTabRaspisanie extends StatelessWidget {
  SortTabRaspisanie({super.key, required this.index, required this.label, required this.funk});

  int index = 0;
  String label;
  Function(int) funk;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: (){
            funk(index);
          }, 
          style: ElevatedButton.styleFrom(
            elevation: 0,
              backgroundColor: tabIndex == index  ? Theme.of(context).primaryColor : Colors.white10,
              //side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
            ),
            ),
        ),
      )
    );
  }
}