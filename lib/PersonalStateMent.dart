import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/mycolors.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/PersonalStateMent.dart';
import 'package:untitled1/itemCommonStatement.dart';
import 'package:untitled1/elemensts/post.dart';
import 'package:untitled1/main.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:windows1251/windows1251.dart';

String groupLink = '?group=13226';

class PersonalStatementItem extends StatelessWidget{
  var container1 = Container(
    height: 100,
    margin: EdgeInsets.all(10),
    child: Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 100,
              color: mygrey,
              child: Container(
                margin: EdgeInsets.only(left: 7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 220,
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                              'Основы программирования',
                              style: TextStyle(
                                fontSize: 18,
                              )
                          ),

                        ),
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 85),
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: Color.fromARGB(255, 146, 228, 149),
                                  child: Center(
                                    child: Text(
                                      '80',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
              ),
            ),
          ),
        )
      ],
    )
  );
  @override
  Widget build(BuildContext context) {
    return container1;

  }

}