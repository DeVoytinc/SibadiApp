import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/mycolors.dart';
class ItemCommonStatement extends StatelessWidget{

  static String _discipline = 'хуй';

  ItemCommonStatement(String discipline, {super.key}){
    _discipline = discipline;
  }

  var container3 = Container(
    color: mygrey,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
    child: Container(
      margin: EdgeInsets.only(left: 7),
      child: Container(
        color: Colors.white,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
        child: Row(
          children: [
            Container(
              width: 220,
              margin: EdgeInsets.all(10),
              child: Text(
                _discipline,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )
                ),
              
             ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 40),
                width: 100,
                child: Container(
                  color: myredDark,///////////////////////////////////
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'ЭКЗАМЕН',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return container3;
  }

}